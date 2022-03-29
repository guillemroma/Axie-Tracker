module AXIEAPI
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  def AXIEAPI.add_axies(ronin_address)

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

  def AXIEAPI.add_battles(ronin_address)

    url = URI("https://game-api.axie.technology/logs/pvp/#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse(response.body)
  end

  def AXIEAPI.check_win_rate(team)
    wins = 0
    battles = 0

    team.battles.each do |battle|
      battle.result == "won" ? ((battles += 1) && (wins += 1)) : (battles += 1)
    end
    @win_rate = wins.to_f / battles.to_f
    return @win_rate
  end

  def AXIEAPI.add_genes_to_axie(axie_id)

    url = URI("https://api.axie.technology/getgenes/#{axie_id}/all")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse(response.body)

  end

  def AXIEAPI.add_metrics(ronin_address)

    url = URI("https://game-api.axie.technology/api/v2/#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse(response.body)

  end

end
