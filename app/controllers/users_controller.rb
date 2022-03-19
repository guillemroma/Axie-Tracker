class UsersController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'


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
        battle.result == "won" ? (@wins +=1 && @battles += 1) : (@battles += 1)
      end
    end



  end

  def update

    @user = User.find(params["team"]["user_id"].to_i)
    @address = params["team"]["ronin_address"].gsub!("ronin:", "0x")
    @user_team = Team.where('ronin_address' => @address).exists? ? @user.teams.first : Team.create(
      user_id: current_user.id,
      ronin_address: @address,
      mmr: add_metrics(@address)["mmr"],
      rank: add_metrics(@address)["rank"],
      current_slp: add_metrics(@address)["total_slp"],
      total_slp: add_metrics(@address)["raw_total"],
      last_claim: add_metrics(@address)["last_claim"],
      next_claim: add_metrics(@address)["next_claim"],
      scholar_name: params["team"]["scholar_name"]
      )

    add_axies(@address)["data"]["axies"]["results"].each do |axie|

      @axie_genes = add_genes_to_axie(axie["id"].to_i)
      Pet.create(team_id: @user_team.id, image: axie["image"], axie_game_id: @axie_genes["story_id"],name: @axie_genes["name"], hp: @axie_genes["stats"]["hp"], morale: @axie_genes["stats"]["morale"], speed: @axie_genes["stats"]["speed"], skill: @axie_genes["stats"]["skill"], axie_class:  @axie_genes["class"], eyes: @axie_genes["parts"][0]["name"], ears: @axie_genes["parts"][1]["name"], back: @axie_genes["parts"][2]["name"], mouth: @axie_genes["parts"][3]["name"], horn: @axie_genes["parts"][4]["name"], tail: @axie_genes["parts"][5]["name"])

    end

    add_battles(@address)["battles"].each do |battle|

      battle_id = battle["battle_uuid"]
      result = battle["winner"] == @address ? "won" : "lost"
      Battle.create(team_id: @user_team.id, result: result, battle_uuid: battle_id)

    end

    @team_metrics = add_metrics(@address)
    @user.teams.first.mmr = @team_metrics["mmr"]
    @user.teams.first.rank = @team_metrics["rank"]
    @user.teams.first.current_slp = @team_metrics["total_slp"]
    @user.teams.first.total_slp = @team_metrics["raw_total"]
    @user.teams.first.last_claim = @team_metrics["last_claim"]
    @user.teams.first.next_claim = @team_metrics["next_claim"]
    #check_win_rate(@user.teams.first)
    #@user.teams.first.win_rate = @win_rate
    raise
    @user.teams.first.save

    redirect_to "/users/#{current_user.id}"
  end

  private

  def ronin_address_params
    params.require(:team).permit(:ronin_address)
  end

  def add_metrics(ronin_address)

    url = URI("https://game-api.axie.technology/api/v2/#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse(response.body)

  end

  def add_axies(ronin_address)

    url = URI("https://axie-infinity.p.rapidapi.com/get-axies/#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = ENV["AXIE_HOST"]
    request["x-rapidapi-key"] = ENV["AXIE_KEY"]

    response = http.request(request)
    json_response = JSON.parse(response.body)

  end

  def add_genes_to_axie(axie_id)

    url = URI("https://api.axie.technology/getgenes/#{axie_id}/all")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse(response.body)

  end

  def add_battles(ronin_address)

    url = URI("https://game-api.axie.technology/logs/pvp/#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse(response.body)

  end

  def check_win_rate(team)
    wins = 0
    battles = 0

    team.battles.each do |battle|
      battle.result == "won" ? (wins +=1 && battles += 1) : (battles += 1)
    end
    @win_rate = wins / battles
    return @win_rate
  end

end
