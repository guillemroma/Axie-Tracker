class UsersController < ApplicationController
  skip_before_action :authenticate_user!, :raise => false
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/add_axie.rb'
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/exchange.rb'
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/coin.rb'
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/info.rb'


  def index

    @users = User.all

  end

  def show

    @user = User.find(params[:id])
    @team = Team.new

    @mmr = []
    @current_slp = 0
    @wins = 0
    @battles = 0

    @user.teams.each do |team|
      @current_slp += team.current_slp if !team.current_slp.nil?
      @mmr << team.mmr
      team.battles.each do |battle|
        battle.result == "won" ? ((@battles += 1) && (@wins += 1)) : (@battles += 1)
      end
    end

    fetch_coins
    @articles = Info.present
    @article_count = 0
  end

  def update

    @user = User.find(params["team"]["user_id"].to_i)
    @address = params["team"]["ronin_address"].gsub!("ronin:", "0x")

    if Team.where('ronin_address' => @address).exists?
    else
      @user_team = Team.create(
        user_id: current_user.id,
        ronin_address: @address,
        mmr: AXIEAPI.add_metrics(@address)["mmr"],
        rank: AXIEAPI.add_metrics(@address)["rank"],
        current_slp: AXIEAPI.add_metrics(@address)["total_slp"],
        total_slp: AXIEAPI.add_metrics(@address)["raw_total"],
        last_claim: AXIEAPI.add_metrics(@address)["last_claim"],
        next_claim: AXIEAPI.add_metrics(@address)["next_claim"],
        scholar_name: params["team"]["scholar_name"]
      )

      AXIEAPI.add_axies(@address)["data"]["axies"]["results"].each do |axie|
        @axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
        Pet.create(
          team_id: @user_team.id,
          image: axie["image"],
          axie_game_id: @axie_genes["story_id"],
          name: @axie_genes["name"],
          hp: @axie_genes["stats"]["hp"],
          morale: @axie_genes["stats"]["morale"],
          speed: @axie_genes["stats"]["speed"],
          skill: @axie_genes["stats"]["skill"],
          axie_class:  @axie_genes["class"],
          eyes: @axie_genes["parts"][0]["name"],
          ears: @axie_genes["parts"][1]["name"],
          back: @axie_genes["parts"][2]["name"],
          mouth: @axie_genes["parts"][3]["name"],
          horn: @axie_genes["parts"][4]["name"],
          tail: @axie_genes["parts"][5]["name"]
        )
      end

      AXIEAPI.add_battles(@address)["battles"].each do |battle|
        battle_id = battle["battle_uuid"]
        result = battle["winner"] == @address ? "won" : "lost"
        Battle.create(team_id: @user_team.id, result: result, battle_uuid: battle_id)
      end

      @team_metrics = AXIEAPI.add_metrics(@address)
      update_team(@user_team, @team_metrics)

    end

    fetch_coins
    Info.present
    @article_count = 0

    redirect_to "/users/#{@user.id}"

  end

  private

  def ronin_address_params
    params.require(:team).permit(:ronin_address)
  end

  def update_team (user_team, team_metrics)
    user_team.scholar_name = params["team"]["scholar_name"]
    user_team.mmr = team_metrics["mmr"]
    user_team.rank = team_metrics["rank"]
    user_team.current_slp = team_metrics["total_slp"]
    user_team.total_slp = team_metrics["raw_total"]
    user_team.last_claim = team_metrics["last_claim"]
    user_team.next_claim = team_metrics["next_claim"]
    user_team.win_rate = AXIEAPI.check_win_rate(user_team)
    user_team.save
  end

  def fetch_coins
    @btc_usd = Coin.add_btc
    @eth_usd = Coin.add_eth
    @axs_usd = Coin.add_axs
    @slp_usd = Coin.add_slp
    @ron_usd = Coin.add_ron
    @usd_to_eur_er = Exchange.add('USD','EUR')
  end
end
