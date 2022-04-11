class RefreshRankingJob < ApplicationJob
  queue_as :default

  def perform
    #we start reseting the ranking, since we run this job once a day,
    #we make sure that the ranking is refreshed on a daily basis
    #before reseting the ranking, we make sure we are also deleting the
    #battles associated to the former ranking to store the minimum possible data
    reset_ranking = Ranking.all
    reset_ranking.each { |player|
      reset_battles = Battle.where(ronin_address: player.ronin_address)
      reset_battles.destroy_all
    }
    reset_ranking.destroy_all
    #once the above is achieved, we create a new ranking from scratch
    world_ranking = SelectTeams.new
    fetch_teams = world_ranking.add
    fetch_teams["items"].each do |team|
      Ranking.create(
        rank: team["rank"],
        scholar_name: team["name"],
        mmr: team["elo"],
        ronin_address: team["client_id"]
      )
    end
    #once we have created the ranking, we iterate over all the player addresses
    #and we create new battles in order to have the win-reate and the battle logs
    #available
    new_ranking = Ranking.all
    new_ranking.each { |player|
      #In order to do the battle show we cannot nest more than to each loops
      #because the code breaks constantly. We initially had it like this but since it was
      #extremlly unstable we switched it to this new approach:
      #We first call the axi api for battles and at the same time we create an empty hash
      #in this empty hash we store the battle uid and the result of the battle (we do it this way beacuse
      #we need to iterate multiple times on the json response that we recieve from the api)
      axie_api = AxieApi.new
      battles = axie_api.add_battles(player.ronin_address)
      @battles_hash_elo = {}
      #so we basically:
      #1-Create a battle with all the information available in the first iteration
      unless battles["battles"].nil?
        battles["battles"].each do |battle|
          #battle will refer to the iteration on the battles hash, new_battle to the
          #battle instance that we will create and then save in the DB as a new record
          new_battle_id = battle["battle_uuid"]
          battle["winner"] == player.ronin_address ? result = "won" : result = "lost"
          #important to note that at this stage we basicalli take the empty hash we previously created
          #and we fill it with a key (being the battle_id, a unique identifier that every battle has)
          #and a value (being the values associated to the "eloAndItem" key from the json response)
          @battles_hash_elo[new_battle_id] = battle["eloAndItem"]
          new_battle = Battle.create(
            result: result,
            battle_uuid: new_battle_id,
            ronin_address: player.ronin_address
          )
        end
      end
      #2-Once the battles are created (with partial information), we fetch them
      #one by one so we can update the missing fields
      Battle.where(ronin_address: player.ronin_address).each do |battle|
        new_mmr = 0
        old_mmr = 0
        unless @battles_hash_elo[battle[:battle_uuid]].nil?
          @battles_hash_elo[battle[:battle_uuid]].each do |player|
            if player["player_id"] == battle[:ronin_address]
              new_mmr = player["new_elo"]
              old_mmr = player["old_elo"]
            end
            end
          battle[:new_mmr] = new_mmr
          battle[:old_mmr] = old_mmr
          battle.save
        end
      end
    }
  end
end
