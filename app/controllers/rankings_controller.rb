class RankingsController < ApplicationController

  def index
    @ranking = Ranking.all
    if params[:query].present?
      @ranking = @ranking.where('scholar_name ILIKE ?', "%#{params[:query]}%").paginate(:page => params[:page], :per_page => 15)
    else
      @ranking = @ranking.paginate(:page => params[:page], :per_page => 15)
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'rankings/list_ranking', locals: { ranking: @ranking }, formats: [:html] }
    end
  end

  def show
    #we start reseting the battles, we do not want to keep them in the DB 4ever since the ranking is dynamic
    #and there the cost of storing is too high
    reset_battles = Battle.where(ronin_address: params[:ronin_address])
    reset_battles.destroy_all
    #In order to do the battle show we cannot nest more than to each loops
    #because the code breaks constantly. We initially had it like this but since it was
    #extremlly unstable we switched to this new approach:
    #We first call the axi api for battles and at the same time we create an empty hash
    #in this empty hash we will store the battle uid and the result of the battle (we do it this way beacuse
    #we need to iterate multiple times on the json response that we recieve from the api)
    axie_api = AxieApi.new
    battles = axie_api.add_battles(params[:ronin_address])
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


    @battles = Battle.where(ronin_address: params[:ronin_address]).paginate(:page => params[:page], :per_page => 15)

    @result = [(axie_api.check_win_rate_ranking(params[:ronin_address]) * 100).to_i, ((1 - axie_api.check_win_rate_ranking(params[:ronin_address])) * 100).to_i]
    @labels = ["Won", "Lost or Drawn"]
    @ranking = true

    DailyLevel.having("ronin_address = ? AND date <= ?", params[:ronin_address], Date.today - 3) ? @display_charts = true : @display_charts = false
  end
end
