class RankingsController < ApplicationController

  def index
    if params[:query].present?
      @ranking = Ranking.all
      @ranking = @ranking.where('scholar_name ILIKE ?', "%#{params[:query]}%").paginate(:page => params[:page], :per_page => 15)
    else
      Ranking.destroy_all
      teams = SelectTeams.new
      fetch_teams = teams.add
      fetch_teams["items"].each do |team|
        Ranking.create(
          rank: team["rank"],
          scholar_name: team["name"],
          mmr: team["elo"],
          ronin_address: team["client_id"]
        )
      end
      @ranking = Ranking.all
      @ranking = @ranking.paginate(:page => params[:page], :per_page => 15)
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'rankings/list_ranking', locals: { ranking: @ranking }, formats: [:html] }
    end
  end

  def show

    axie_api = AxieApi.new
    battles = axie_api.add_battles(params[:ronin_address])
    battles_hash_elo = {}

    unless battles.nil?
      battles["battles"].each do |battle|
      battle_id = battle["battle_uuid"]
      battle["winner"] == params[:ronin_address] ? result = "won" : result = "lost"
      battles_hash_elo[battle_id] = battle["eloAndItem"]

      Battle.create(
        result: result,
        battle_uuid: battle_id,
        ronin_address: params[:ronin_address]
      )

      end
    end

    Battle.where(ronin_address: params[:ronin_address]).each do |battle|

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


    @battles = Battle.where(ronin_address: params[:ronin_address]).paginate(:page => params[:page], :per_page => 15)

    @result = [(axie_api.check_win_rate_ranking(params[:ronin_address]) * 100).to_i, ((1 - axie_api.check_win_rate_ranking(params[:ronin_address])) * 100).to_i]
    @labels = ["Won", "Lost or Drawn"]
    @ranking = true

    DailyLevel.having("ronin_address = ? AND date <= ?", params[:ronin_address], Date.today - 3) ? @display_charts = true : @display_charts = false

  end
end
