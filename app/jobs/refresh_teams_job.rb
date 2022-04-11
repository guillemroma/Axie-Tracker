class RefreshTeamsJob < ApplicationJob
  queue_as :default

  def perform
    #we start updating the metrics for each of the teams
    #since tam metrics are dynamic because users are playing,
    #we need ot make sure that these are being regulary updated
    teams = Team.all
    teams.each do |team|
      axie_api = AxieApi.new
      team_metrics = axie_api.add_metrics(team.ronin_address)
      team.update(
        mmr: (team_metrics.nil? ? 0 : team_metrics["mmr"]),
        rank: (team_metrics.nil? ? 0 : team_metrics["rank"]),
        current_slp: (team_metrics.nil? ? 0 : team_metrics["total_slp"]),
        total_slp: (team_metrics.nil? ? 0 : team_metrics["raw_total"]),
        last_claim: (team_metrics.nil? ? 0 : team_metrics["last_claim"]),
        next_claim: (team_metrics.nil? ? 0 : team_metrics["next_claim"]),
      )
      team.save

      #same as in the Teams case, we also need to update the daily earnings, mmr and ranking
      #because after each battle, this values will change
      unless team_metrics.nil?
        daily_earnings = DailyEarning.where(ronin_address: team.ronin_address, date: Date.today).first
        unless daily_earnings.nil?
          daily_earnings.update(daily_slp: team_metrics["total_slp"])
          daily_earnings.save
        end

        daily_levels = DailyLevel.where(ronin_address: team.ronin_address, date: Date.today).first
        unless daily_levels.nil?
          daily_levels.update(mmr: team_metrics["mmr"])
          daily_levels.save
        end
        daily_rankings = DailyRanking.where(ronin_address: team.ronin_address, date: Date.today).first
        unless daily_rankings.nil?
          daily_rankings.update(rank: team_metrics["rank"])
          daily_rankings.save
        end
      end

      #since the user might potentially acquire new axies (as well as get rid of some)
      #we need to keep track of the axies associated to a given address
      #we basically write the create and update because
      #1) when the user team was created, the api call could have failed
      #hence we need to create the axies from scratch
      #2) In future versions of the game user will be able to change parts of their axies
      #hence we need to make sure that these are being under constant scrutiny
      unless axie_api.add_axies(team.ronin_address).nil?
        axies = axie_api.add_axies(team.ronin_address)
        axies["data"]["axies"]["results"].each do |axie|
          axie_genes = axie_api.add_genes_to_axie(axie["id"].to_i)
          if Pet.where(axie_game_id: axie_genes["story_id"])
            pet = Pet.where(axie_game_id: axie_genes["story_id"])
            pet.update(
              name: (axie_genes.nil? ? "-" : axie_genes["name"]),
              hp: (axie_genes.nil? ? 0 : axie_genes["stats"]["hp"]),
              morale: (axie_genes.nil? ? 0 : axie_genes["stats"]["morale"]),
              speed: (axie_genes.nil? ? 0 : axie_genes["stats"]["speed"]),
              skill: (axie_genes.nil? ? 0 : axie_genes["stats"]["skill"]),
              axie_class: (axie_genes.nil? ? "-" : axie_genes["class"]),
              eyes: (axie_genes.nil? ? "-" : axie_genes["parts"][0]["name"]),
              ears: (axie_genes.nil? ? "-" : axie_genes["parts"][1]["name"]),
              back: (axie_genes.nil? ? "-" : axie_genes["parts"][2]["name"]),
              mouth: (axie_genes.nil? ? "-" : axie_genes["parts"][3]["name"]),
              horn: (axie_genes.nil? ? "-" : axie_genes["parts"][4]["name"]),
              tail: (axie_genes.nil? ? "-" : axie_genes["parts"][5]["name"])
            )
            pet.save
          else
            Pet.create(
              team_id: team,
              image: axie["image"],
              axie_game_id: (axie_genes.nil? ? 0 : axie_genes["story_id"]),
              name: (axie_genes.nil? ? "-" : axie_genes["name"]),
              hp: (axie_genes.nil? ? 0 : axie_genes["stats"]["hp"]),
              morale: (axie_genes.nil? ? 0 : axie_genes["stats"]["morale"]),
              speed: (axie_genes.nil? ? 0 : axie_genes["stats"]["speed"]),
              skill: (axie_genes.nil? ? 0 : axie_genes["stats"]["skill"]),
              axie_class: (axie_genes.nil? ? "-" : axie_genes["class"]),
              eyes: (axie_genes.nil? ? "-" : axie_genes["parts"][0]["name"]),
              ears: (axie_genes.nil? ? "-" : axie_genes["parts"][1]["name"]),
              back: (axie_genes.nil? ? "-" : axie_genes["parts"][2]["name"]),
              mouth: (axie_genes.nil? ? "-" : axie_genes["parts"][3]["name"]),
              horn: (axie_genes.nil? ? "-" : axie_genes["parts"][4]["name"]),
              tail: (axie_genes.nil? ? "-" : axie_genes["parts"][5]["name"])
            )
          end
        end

        #we will check if there are axies that were included in the past
        #that no longer belong to the user (he/she sold them)
        user_axies = Pets.where(team_id: team)
        user_axies_api = axies["data"]["axies"]["results"]

        user_axies.each do |axie|
          axie.destroy if !user_axies_api.detect { |hash| hash["story_id"] == axie.axie_game_id }
        end
      end

      #we also have to update team's battles
      battles = axie_api.add_battles(team.ronin_address)
      battles_hash_elo = {}

      unless battles["battles"].nil?
        battles["battles"].each do |battle|
          battle_id = battle["battle_uuid"]
          battle["winner"] == team.ronin_address ? result = "won" : result = "lost"
          battles_hash_elo[battle_id] = battle["eloAndItem"]
          #in case the battle already exists, we don't do anything as once a battle has happened
          #nothing changes about it. since every battle has it unique identifier (battle_uuid)
          #we basically check wether if there is any battle with that identifier in our DB or not
          unless Battle.where(battle_uuid: battle_id)
            Battle.create(
              result: result,
              battle_uuid: battle_id,
              ronin_address: team.ronin_address
            )
          end
        end
      end

      Battle.where(ronin_address: @address).each do |battle|
        @new_mmr = 0
        @old_mmr = 0
        battles_hash_elo[battle[:battle_uuid]].each do |player|
          if player["player_id"] == battle[:ronin_address]
            @new_mmr = player["new_elo"]
            @old_mmr = player["old_elo"]
          end
        end
        battle[:new_mmr] = @new_mmr
        battle[:old_mmr] = @old_mmr
        battle.save
      end
    end
  end
end
