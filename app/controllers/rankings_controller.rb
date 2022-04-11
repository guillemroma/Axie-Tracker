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
    axie_api = AxieApi.new
    @battles = Battle.where(ronin_address: params[:ronin_address]).paginate(:page => params[:page], :per_page => 15)
    @result = [(axie_api.check_win_rate_ranking(params[:ronin_address]) * 100).to_i, ((1 - axie_api.check_win_rate_ranking(params[:ronin_address])) * 100).to_i]
    @labels = ["Won", "Lost or Drawn"]
    @ranking = true
    DailyLevel.having("ronin_address = ? AND date <= ?", params[:ronin_address], Date.today - 3) ? @display_charts = true : @display_charts = false
  end
end
