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
    @address = RoninAddress.new

  end

  def update
    raise
    @user = User.find(current_user.id)
    @address = params["ronin_address"]["address"].gsub!("ronin:", "0x")
    @ronin_address = RoninAddress.create(address: @address, user_id: current_user.id)
    @user_team = Team.where('user_id' => current_user.id).exists? ? @user.team.id : Team.create(user_id: current_user.id)

    add_axies(@ronin_address)["data"]["axies"]["results"].each do |axie|

      @axie_genes = add_genes_to_axie(axie["id"].to_i)
      Axie.create(team_id: @user.team.id, image: axie["image"], axie_game_id: @axie_genes["story_id"],name: @axie_genes["name"], hp: @axie_genes["stats"]["hp"], morale: @axie_genes["stats"]["morale"], speed: @axie_genes["stats"]["speed"], skill: @axie_genes["stats"]["skill"], axie_class:  @axie_genes["class"], eyes: @axie_genes["parts"][0]["name"], ears: @axie_genes["parts"][1]["name"], back: @axie_genes["parts"][2]["name"], mouth: @axie_genes["parts"][3]["name"], horn: @axie_genes["parts"][4]["name"], tail: @axie_genes["parts"][5]["name"])

    end

    add_battles(@ronin_address)["battles"].each do |battle|
      result = battle["eloAndItem"][0]["result_type"]
      Battle.create(team_id: @user.team.id, result: result)
    end

    @team_metrics = add_metrics(@ronin_address)
    @user.team.mmr = @team_metrics["mmr"]
    @user.team.rank = @team_metrics["rank"]
    @user.team.current_slp = @team_metrics["total_slp"]
    @user.team.total_slp = @team_metrics["raw_total"]
    @user.team.last_claim = @team_metrics["last_claim"]
    @user.team.next_claim = @team_metrics["next_claim"]
    @user.team.save

    redirect_to "/users/#{current_user.id}"
  end

  private

  def ronin_address_params
    params.require(:ronin_address).permit(:address)
  end

  def add_metrics(ronin_address)

    url = URI("https://game-api.axie.technology/api/v2/#{ronin_address.address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse(response.body)

  end

  def add_axies(ronin_address)

    url = URI("https://axie-infinity.p.rapidapi.com/get-axies/#{ronin_address.address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    #request["x-rapidapi-host"] = ENV["AXIE_HOST"]
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

    url = URI("https://game-api.axie.technology/logs/pvp/#{ronin_address.address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse(response.body)

  end

end
