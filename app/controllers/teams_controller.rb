class TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, :raise => false

  require 'date'

  def show
    axie_api = AxieApi.new
    @team = Team.find(params[:id])
    @battles = Battle.where(ronin_address: @team.ronin_address).paginate(:page => params[:page], :per_page => 15)

    unless axie_api.add_axies(@team.ronin_address).nil?
      axie_api.add_axies(@team.ronin_address)["data"]["axies"]["results"].each do |axie|
        axie_genes = axie_api.add_genes_to_axie(axie["id"].to_i)
        Pet.create(
          team_id: @user_team.id,
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

    ronin_address = @team.ronin_address

    @daily_slp = []
    @dates_slp = []

    DailyEarning.where(ronin_address: ronin_address).each do |daily_earning|
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

    if (@team.win_rate.present? && !@team.win_rate.nan?)
      @result = [(@team.win_rate * 100).to_i, ((1 - @team.win_rate) * 100).to_i]
      @labels = ["Won", "Lost or Drawn"]
    end

    (@display_charts = true) if (DailyEarning.having("date < ? ", Date.today - 3))
  end

  def create
    @user = User.find(params["team"]["user_id"].to_i)
    @address = params["team"]["ronin_address"].gsub!("ronin:", "0x")

    axie_api = AxieApi.new
    team_metrics = axie_api.add_metrics(@address)

    @user_team = Team.create(
      user_id: current_user.id,
      ronin_address: @address,
      mmr: (team_metrics.nil? ? 0 : team_metrics["mmr"]),
      rank: (team_metrics.nil? ? 0 : team_metrics["rank"]),
      current_slp: (team_metrics.nil? ? 0 : team_metrics["total_slp"]),
      total_slp: (team_metrics.nil? ? 0 : team_metrics["raw_total"]),
      last_claim: (team_metrics.nil? ? 0 : team_metrics["last_claim"]),
      next_claim: (team_metrics.nil? ? 0 : team_metrics["next_claim"]),
      scholar_name: params["team"]["scholar_name"]
      )

    #In order to do the battle show we cannot nest more than to each loops
    #because the code breaks constantly. We initially had it like this but since it was
    #extremlly unstable we switched it to this new approach:
    #We first call the axi api for battles and at the same time we create an empty hash
    #in this empty hash we store the battle uid and the result of the battle (we do it this way beacuse
    #we need to iterate multiple times on the json response that we recieve from the api)
    battles = axie_api.add_battles(@address)
    @battles_hash_elo = {}
    #so we basically:
    #1-Create a battle with all the information available in the first iteration
    unless battles["battles"].nil?
      battles["battles"].each do |battle|
        #battle will refer to the iteration on the battles hash, new_battle to the
        #battle instance that we will create and then save in the DB as a new record
        new_battle_id = battle["battle_uuid"]
        battle["winner"] == params[:ronin_address] ? result = "won" : result = "lost"
        #important to note that at this stage we basicalli take the empty hash we previously created
        #and we fill it with a key (being the battle_id, a unique identifier that every battle has)
        #and a value (being the values associated to the "eloAndItem" key from the json response)
        @battles_hash_elo[new_battle_id] = battle["eloAndItem"]
        new_battle = Battle.create(
          result: result,
          battle_uuid: new_battle_id,
          ronin_address: params[:ronin_address]
        )
      end
    end

    #2-Once the battles are created (with partial information), we fetch them
    #one by one so we can update the missing fields
    Battle.where(ronin_address: params[:ronin_address]).each do |battle|
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

    unless team_metrics.nil?
      DailyEarning.create(daily_slp: team_metrics["total_slp"], date: Date.today, ronin_address: @user_team.ronin_address)
      DailyLevel.create(mmr: team_metrics["mmr"], date: Date.today, ronin_address: @user_team.ronin_address)
      DailyRanking.create(rank: team_metrics["rank"], date: Date.today, ronin_address: @user_team.ronin_address)
    end

    (@user_team.win_rate = axie_api.check_win_rate(@user_team)) if !axie_api.check_win_rate(@user_team).nil?
    @user_team.save

    redirect_to "/users/#{@user.id}"
  end

  def update
    @team = Team.where(ronin_address: params["team"]["ronin_address"]).first
    @team.update(scholar_name: params["team"]["scholar_name"])
    @team.save

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
end
