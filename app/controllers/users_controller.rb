class UsersController < ApplicationController
  skip_before_action :authenticate_user!, :raise => false
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/add_axie.rb'
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/exchange.rb'
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/coin.rb'
  require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/info.rb'


  def index



    if (params.keys == ["controller", "action"]) && (params[:controller] == "users" && params[:action] == "index") || (params[:MMR] == "" && params["win-rate"] == "" && params[:team] == "" && params[:slp] == "" && params[:controller] == "users" && params[:action] == "index")

      #we have grouped the different URLs with no content inside; in that case we want to return all the users since there has not been any filter applied
      @users = User.all

    else

      #when we pass information in any of the parameters throught the project index filter we activate the filter
      #in case there is one or more params without values we select all the projects by default, otherwise we select the values passed
      if params[:MMR].blank?
        @users_mmr = User.all
      elsif params[:MMR] == "+ 2500"
        @users_mmr = User.joins(:teams).group("users.id").having("avg(mmr) >= ?", 2500)
      else
        @users_mmr = User.joins(:teams).group("users.id").having("avg(mmr) >= ? AND avg(mmr) <= ?", params[:MMR].gsub(/,/,"").split().first.to_i, params[:MMR].gsub(/,/,"").split().last.to_i)
      end

      @users_win_rate = (params["win-rate"].blank?) ? User.all : User.joins(:teams).group("users.id").having("avg(win_rate) * 100 >= ? AND avg(win_rate) * 100 <= ?", params["win-rate"].gsub(/%/,"").split.first.to_i, params["win-rate"].gsub(/%/,"").split.last.to_i)

      if params[:team].blank?
        @users_team = User.all
      elsif params[:team] == "+ 100"
        @users_team = User.joins(:teams).group("users.id").having("COUNT (*) >= ?", 100)
      else
        @users_team = User.joins(:teams).group("users.id").having("COUNT (*) >= ? AND COUNT (*) <= ?", params[:team].gsub(/,/,"").split().first.to_i, params[:team].gsub(/,/,"").split().last.to_i)
      end


      if params[:slp].blank?
        @users_slp = User.all
      elsif params[:slp] == "+ 1,000,000"
        @users_slp = User.joins(:teams).group("users.id").having("SUM(total_slp) >= ?", 1000000)
      else
        @users_slp = User.joins(:teams).group("users.id").having("SUM(total_slp) >= ? AND SUM(total_slp) <= ?", params[:slp].gsub(/,/,"").split().first.to_i, params[:slp].gsub(/,/,"").split().last.to_i)
      end

      @users = []

      @users_mmr.each do |user|
        if @users_win_rate.include?(user) && @users_team.include?(user) && @users_slp.include?(user)
          @users << user
        end
      end
    end

    #we create the filter options as follows
    #the idea is that we need to get all the different options available, per filter
    #in case there are duplicates, we need to earse them
    #finally, we need to sort the items in each array

    @mmr_array = ["1 - 1,000", "1,000 - 1,500", "1,500 - 2,000", "2,000 - 2,225", "2,225 - 2,500", "+ 2,500"]
    @win_rates_array = ["0% - 20%", "20% - 40%", "40% - 60%", "60% - 80%", "80% - 100%"]
    @teams_count_array = ["1 - 3", "3 - 5", "5 - 10", "10- 20", "20 - 50", "50 - 100", "+ 100"]
    @total_slps_array = ["1 - 1,000", "1,000 - 5,000", "5,000 - 15,000", "15,000 - 30,000", "30,000 - 60,000", "60,000 - 100,000", "100,000 - 500,000", "+ 1,000,000"]

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

  private

  def fetch_coins
    @btc_usd = Coin.add_btc
    @eth_usd = Coin.add_eth
    @axs_usd = Coin.add_axs
    @slp_usd = Coin.add_slp
    @ron_usd = Coin.add_ron
    @usd_to_eur_er = Exchange.add('USD','EUR')
  end
end
