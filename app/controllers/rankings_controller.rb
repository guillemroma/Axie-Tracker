class RankingsController < ApplicationController
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/select_teams.rb'

  def index

    @ranking = Ranking.all

    if params[:query].present?
      @ranking = @ranking.where('scholar_name ILIKE ?', "%#{params[:query]}%").paginate(:page => params[:page], :per_page => 15)
    else
      destroy
      @fetch_teams = SelectTeams.add
      @fetch_teams["items"].each do |team|
        Ranking.create(
          rank: team["rank"],
          scholar_name: team["name"],
          mmr: team["elo"]
        )
      @ranking = Ranking.all.paginate(:page => params[:page], :per_page => 15)
      end

    end


    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'rankings/list_ranking', locals: { ranking: @ranking }, formats: [:html] }
    end

  end

  def destroy

    Ranking.destroy_all

  end

end
