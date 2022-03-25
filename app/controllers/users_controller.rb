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
      raise
      @users_mmr = (params[:MMR].blank?) ? User.all : User.joins(:teams).group("users.id").having("avg(mmr) = ?", params[:MMR].to_i)
      @users_win_rate = (params["win-rate"].split().first.to_i.blank?) ? User.all : User.joins(:teams).group("users.id").having("avg(win_rate) = ?", ((params["win-rate"].to_f)/100))
      @users_team = (params[:team].blank?) ? User.all : User.joins(:teams).group("users.id").having("COUNT (*) = ?", params[:team].to_i)
      @users_slp = (params[:slp].blank?) ? User.all : User.joins(:teams).having("SUM(total_slp) = ?", params[:slp].to_i).group("users.id")

      @users = []

      #the filter will select all the projects that share the values defined in the filter (no value == all values)
      #it will check what projects are in the 4 different variables predefined before
      #in case there is a project that is shared across the 4 variables, it will display it


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

    @mmr_array = []

    User.all.each do |user|
      mmr = 0
      user.teams.each do |team|
        mmr += team.mmr
      end
      @mmr_array << (mmr / user.teams.count)
    end
    @mmr_array = @mmr_array.uniq.sort

    @win_rates_array = []

    User.all.each do |user|
      win_rate = 0
      user.teams.each do |team|
        win_rate += team.win_rate.to_f
      end
      @win_rates_array << (win_rate / user.teams.count)
    end
    @win_rates_array = @win_rates_array.uniq.sort

    @teams_count_array = []
    User.all.each do |user|
      @teams_count_array << user.teams.count
    end
    @teams_count_array = @teams_count_array.uniq.sort

    @total_slps_array = []
    User.all.each do |user|
      user_slp = 0
      user.teams.each do |team|
        user_slp += team.total_slp
      end
      @total_slps_array << user_slp
    end
    @total_slps_array = @total_slps_array.uniq.sort

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
