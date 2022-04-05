class TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, :raise => false
  require_relative './modules/add_axie.rb'
  require_relative './modules/exchange.rb'
  require_relative './modules/coin.rb'
  require_relative './modules/info.rb'
  require 'date'

  def show

    if params[:ronin_address].present?

      Battle.where(ronin_address: params[:ronin_address]).destroy_all

      unless AXIEAPI.add_battles(params[:ronin_address]).nil?
        AXIEAPI.add_battles(params[:ronin_address])["battles"].each do |battle|


          battle_id = battle["battle_uuid"]
          result = battle["winner"] == params[:ronin_address] ? "won" : "lost"

          new_mmr = 0
          old_mmr = 0

          battle["eloAndItem"].each do |player|
            if player["player_id"] == params[:ronin_address]
              new_mmr = player["new_elo"]
              old_mmr = player["old_elo"]
            end
          end

          Battle.create(
            result: result,
            battle_uuid: battle_id,
            ronin_address: params[:ronin_address],
            new_mmr: new_mmr,
            old_mmr: old_mmr
          )
        end
      end

      @battles = Battle.where(ronin_address: params[:ronin_address]).paginate(:page => params[:page], :per_page => 15)

    else

      @team = Team.find(params[:id])
      @battles = Battle.where(ronin_address: @team.ronin_address).paginate(:page => params[:page], :per_page => 15)

      unless AXIEAPI.add_axies(@team.ronin_address).nil?
        AXIEAPI.add_axies(@team.ronin_address)["data"]["axies"]["results"].each do |axie|
          @axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
          Pet.create(
            team_id: @user_team.id,
            image: axie["image"],
            axie_game_id: (@axie_genes.nil? ? 0 : @axie_genes["story_id"]),
            name: (@axie_genes.nil? ? "-" : @axie_genes["name"]),
            hp: (@axie_genes.nil? ? 0 : @axie_genes["stats"]["hp"]),
            morale: (@axie_genes.nil? ? 0 : @axie_genes["stats"]["morale"]),
            speed: (@axie_genes.nil? ? 0 : @axie_genes["stats"]["speed"]),
            skill: (@axie_genes.nil? ? 0 : @axie_genes["stats"]["skill"]),
            axie_class: (@axie_genes.nil? ? "-" : @axie_genes["class"]),
            eyes: (@axie_genes.nil? ? "-" : @axie_genes["parts"][0]["name"]),
            ears: (@axie_genes.nil? ? "-" : @axie_genes["parts"][1]["name"]),
            back: (@axie_genes.nil? ? "-" : @axie_genes["parts"][2]["name"]),
            mouth: (@axie_genes.nil? ? "-" : @axie_genes["parts"][3]["name"]),
            horn: (@axie_genes.nil? ? "-" : @axie_genes["parts"][4]["name"]),
            tail: (@axie_genes.nil? ? "-" : @axie_genes["parts"][5]["name"])
          )
        end
      end
    end

    params[:ronin_address] ? (ronin_address = params[:ronin_address]) : (ronin_address = @team.ronin_address)

    @daily_slp = []
    @dates_slp = []

    DailyEarning.where(ronin_address: (ronin_address)).each do |daily_earning|
      @daily_slp << daily_earning.daily_slp
      @dates_slp << daily_earning.date
    end

    @daily_mmr = []
    @dates_mmr = []
    DailyLevel.where(ronin_address: ronin_address).each do |daily_mmr|
      @daily_mmr << daily_mmr.mmr
      @dates_mmr << daily_mmr.date
    end

    @daily_rank = []
    @dates_rank = []
    DailyRanking.where(ronin_address: ronin_address).each do |daily_rank|
      @daily_rank << daily_rank.rank
      @dates_rank << daily_rank.date
    end


    if params[:ronin_address]
      @result = [(AXIEAPI.check_win_rate_ranking(params[:ronin_address]) * 100).to_i, ((1 - AXIEAPI.check_win_rate_ranking(params[:ronin_address])) * 100).to_i]
      @labels = ["Won", "Lost or Drawn"]
      @ranking = true

    else
      if (@team.win_rate.present? && !@team.win_rate.nan?)
        @result = [(@team.win_rate * 100).to_i, ((1 - @team.win_rate) * 100).to_i]
        @labels = ["Won", "Lost or Drawn"]
      end
    end

    DailyLevel.having("ronin_address = ? AND date <= ?", params[:ronin_address], Date.today - 3) ? @display_charts = true : @display_charts = false

  end

  def create

    @user = User.find(params["team"]["user_id"].to_i)
    @address = params["team"]["ronin_address"].gsub!("ronin:", "0x")

    @user_team = Team.create(
      user_id: current_user.id,
      ronin_address: @address,
      mmr: (AXIEAPI.add_metrics(@address).nil? ? 0 : AXIEAPI.add_metrics(@address)["mmr"]),
      rank: (AXIEAPI.add_metrics(@address).nil? ? 0 : AXIEAPI.add_metrics(@address)["rank"]),
      current_slp: (AXIEAPI.add_metrics(@address).nil? ? 0 : AXIEAPI.add_metrics(@address)["total_slp"]),
      total_slp: (AXIEAPI.add_metrics(@address).nil? ? 0 : AXIEAPI.add_metrics(@address)["raw_total"]),
      last_claim: (AXIEAPI.add_metrics(@address).nil? ? 0 : AXIEAPI.add_metrics(@address)["last_claim"]),
      next_claim: (AXIEAPI.add_metrics(@address).nil? ? 0 : AXIEAPI.add_metrics(@address)["next_claim"]),
      scholar_name: params["team"]["scholar_name"]
      )

    unless AXIEAPI.add_battles(@user_team.ronin_address).nil?
      AXIEAPI.add_battles(@user_team.ronin_address)["battles"].each do |battle|
        battle_id = battle["battle_uuid"]
        result = battle["winner"] == @user_team.ronin_address ? "won" : "lost"

        new_mmr = 0
        old_mmr = 0

        battle["eloAndItem"].each do |player|
          if player["player_id"] == @user_team.ronin_address
            new_mmr = player["new_elo"]
            old_mmr = player["old_elo"]
          end
        end

        Battle.create(
          result: result,
          battle_uuid: battle_id,
          ronin_address: @user_team.ronin_address,
          new_mmr: new_mmr,
          old_mmr: old_mmr
        )
      end
    end

    unless AXIEAPI.add_metrics(@user_team.ronin_address).nil?
      DailyEarning.create(daily_slp: AXIEAPI.add_metrics(@user_team.ronin_address)["total_slp"], date: Date.today, ronin_address: @user_team.ronin_address)
      DailyLevel.create(mmr: AXIEAPI.add_metrics(@user_team.ronin_address)["mmr"], date: Date.today, ronin_address: @user_team.ronin_address)
      DailyRanking.create(rank: AXIEAPI.add_metrics(@user_team.ronin_address)["rank"], date: Date.today, ronin_address: @user_team.ronin_address)
    end

    (@user_team.win_rate = AXIEAPI.check_win_rate(@user_team)) if !AXIEAPI.check_win_rate(@user_team).nil?
    @user_team.save

    redirect_to "/users/#{@user.id}"

  end

  def update

    if params["team"]["ronin_address"].present? && params["team"]["scholar_name"].present?

      @team = Team.where(ronin_address: params["team"]["ronin_address"]).first
      @team.update(scholar_name: params["team"]["scholar_name"])
      @team.save

    else

      users = User.all
      users.each do |user|
        user.teams.each do |team|
          address = team.ronin_address
          team_metrics = AXIEAPI.add_metrics(address)
          update_team_background(team, team_metrics, address)
        end
      end

    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "teams/list_teams", locals: { team: @team }, formats: [:html] }
    end

  end

  def destroy

    team = Team.find(params["id"])
    battles = Battle.where(ronin_address: team.ronin_address)
    daily_earnings = DailyEarning.where(ronin_address: team.ronin_address)
    daily_levels = DailyLevel.where(ronin_address: team.ronin_address)
    daily_rankings = DailyRanking.where(ronin_address: team.ronin_address)

    @user = team.user_id

    team.destroy
    battles.destroy_all
    daily_earnings.destroy_all
    daily_levels.destroy_all
    daily_rankings.destroy_all

    redirect_to "/users/#{@user}"

  end

  private

  def update_team_background(team, team_metrics, address)

    #Update the main team metrics
    team.mmr = team_metrics["mmr"]
    team.rank = team_metrics["rank"]
    team.current_slp = team_metrics["total_slp"]
    team.total_slp = team_metrics["raw_total"]
    team.last_claim = team_metrics["last_claim"]
    team.next_claim = team_metrics["next_claim"]
    team.win_rate = AXIEAPI.check_win_rate(team)
    team.save

    #Update the Axies that one team has
    #Update the parts of the axie, in the future this will be upgraded regularly
    AXIEAPI.add_axies(address)["data"]["axies"]["results"].each do |axie|
      axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
      Pet.create(
        team_id: team.id,
        image: axie["image"],
        axie_game_id: axie_genes["story_id"],
        name: axie_genes["name"],
        hp: axie_genes["stats"]["hp"],
        morale: axie_genes["stats"]["morale"],
        speed: axie_genes["stats"]["speed"],
        skill: axie_genes["stats"]["skill"],
        axie_class:  axie_genes["class"],
        eyes: axie_genes["parts"][0]["name"],
        ears: axie_genes["parts"][1]["name"],
        back: axie_genes["parts"][2]["name"],
        mouth: axie_genes["parts"][3]["name"],
        horn: axie_genes["parts"][4]["name"],
        tail: axie_genes["parts"][5]["name"]
      )
    end

    #update the battles table with the new battles available
    AXIEAPI.add_battles(address)["battles"].each do |battle|
      battle_id = battle["battle_uuid"]
      result = battle["winner"] == address ? "won" : "lost"
      Battle.create(team_id: team.id, result: result, battle_uuid: battle_id)
    end

    #update the cumulative earning table with the current total_slp
    record_total_slp = CumulativeEarning.where("team_id = ? AND date = ?", team.id, Date.today)[0]
    record_total_slp.update(total_slp: team.total_slp)
    record_total_slp.save

    #update the daily earnings table by:
    #first: select and destroy records that do not pass the 15 days validation criteria
    cumulative_earning_date_old = CumulativeEarning.where("date < ?",  Date.today - 15)
    daily_earning_date_old = DailyEarning.where("date < ?",  Date.today - 15)

    cumulative_earning_date_old.destroy_all
    daily_earning_date_old.destroy_all

    #second: checking if there is a cumulative record from yesterday to perform a substraction
    #and later: if that is the case, check if there is any record with date today of daily earning
    #if both conditions are met, just update the record with the new difference of total_slp (if any)
    #else, we just update today's daily_slp from daily earnings with today's total_slp from cumulative earning

    if DailyEarning.all.detect { |hash| hash[:date] == (Date.today) }
      if CumulativeEarning.all.detect { |hash| hash[:date] == (Date.today - 1) }
        daily_total_slp = DailyEarning.where("team_id = ? AND date = ?", team.id, Date.today)[0]
        daily_total_slp.update(daily_slp: (CumulativeEarning.where("team_id = ? AND date = ?", team.id, Date.today)[0].total_slp - CumulativeEarning.where("team_id = ? AND date = ?", team.id, (Date.today - 1))[0].total_slp))
        daily_total_slp.save
      else
        daily_total_slp = DailyEarning.where("team_id = ? AND date = ?", team.id, Date.today)[0]
        daily_total_slp.update(daily_slp: CumulativeEarning.where("team_id = ? AND date = ?", team.id, Date.today)[0].total_slp)
        daily_total_slp.save
      end
    else
      #if the above conditions are not met, instead of update we will have to create the record
      #in order to do so, we follow the same logic (checking if there is any record of cumulative earning from yesterday)
      if CumulativeEarning.all.detect { |hash| hash[:date] == (Date.today - 1) }
        DailyEarning.create!(
          team_id: team.id,
          daily_slp: (CumulativeEarning.where("team_id = ? AND date = ?", team.id, Date.today)[0].total_slp - CumulativeEarning.where("team_id = ? AND date = ?", team.id, (Date.today - 1))[0].total_slp),
          date: Date.today
        )
      else
        DailyEarning.create!(
          team_id: team.id,
          daily_slp: (CumulativeEarning.where("team_id = ? AND date = ?", team.id, Date.today)[0].total_slp - CumulativeEarning.where("team_id = ? AND date = ?", team.id, (Date.today - 1))[0].total_slp),
          date: Date.today
        )
      end
    end

    daily_mmr = DailyLevel.where("team_id = ? AND date = ?", team.id, Date.today)[0]
    daily_mmr.update(mmr: team.mmr)
    daily_mmr.save

    daily_rank = DailyRanking.where("team_id = ? AND date = ?", team.id, Date.today)[0]
    daily_rank.update(rank: team.rank)
    daily_rank.save

  end
end
