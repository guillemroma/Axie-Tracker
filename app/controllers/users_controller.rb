class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
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
