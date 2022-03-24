class TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, :raise => false
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/add_axie.rb'
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/exchange.rb'
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/coin.rb'
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/info.rb'

  def create

    @user = User.find(params["team"]["user_id"].to_i)
    @address = params["team"]["ronin_address"].gsub!("ronin:", "0x")

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

  private

  def ronin_address_params

    params.require(:team).permit(:ronin_address, :scholar_name)

  end

  def update_team(user_team, team_metrics)

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

  def update_team_background(team, team_metrics, address)

    team.mmr = team_metrics["mmr"]
    team.rank = team_metrics["rank"]
    team.current_slp = team_metrics["total_slp"]
    team.total_slp = team_metrics["raw_total"]
    team.last_claim = team_metrics["last_claim"]
    team.next_claim = team_metrics["next_claim"]
    team.win_rate = AXIEAPI.check_win_rate(team)
    team.save

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

    AXIEAPI.add_battles(address)["battles"].each do |battle|
      battle_id = battle["battle_uuid"]
      result = battle["winner"] == address ? "won" : "lost"
      Battle.create(team_id: team.id, result: result, battle_uuid: battle_id)
    end

  end

end
