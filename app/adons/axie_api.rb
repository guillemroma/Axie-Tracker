class AxieApi
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'
  require 'timeout'

  def initialize()
  end

  def add_axies(ronin_address)

    url = URI("https://axie-infinity.p.rapidapi.com/get-axies/#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE


    manage_request_with_api_key(url, http)

  end

  def add_battles(ronin_address)

    url = URI("https://game-api.axie.technology/logs/pvp/#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    manage_request(url, http)

  end

  def check_win_rate(team)
    wins = 0
    battles = 0

    Battle.where(ronin_address: team.ronin_address).each do |battle|
      battle.result == "won" ? ((battles += 1) && (wins += 1)) : (battles += 1)
    end
    @win_rate = wins.to_f / battles.to_f
    return @win_rate
  end

  def add_genes_to_axie(axie_id)

    url = URI("https://api.axie.technology/getgenes/#{axie_id}/all")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    manage_request(url, http)

  end

  def add_metrics(ronin_address)

    url = URI("https://game-api.axie.technology/api/v2/#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    manage_request(url, http)

  end

  def check_win_rate_ranking(ronin_address)
    wins = 0
    battles = 0

    Battle.where(ronin_address: ronin_address).each do |battle|
      battle.result == "won" ? ((battles += 1) && (wins += 1)) : (battles += 1)
    end
    @win_rate = wins.to_f / battles.to_f
    return @win_rate
  end

  private

  def manage_request(url, http)
  #we first check if the api server is responding or not
  #the amount of seconds that we can afford to test that is 3
  #if in 3 seconds we have not gotten a response, then the method returns "nil"
  #if we recieve a response in less than 3 secons, status["success"] will equal true
  #if it does not execute we will get a timeout::error, in that case the code will stop itself from executing
  #and will return "nil" (as specified before)

    begin
      status= Timeout::timeout(3) {
        request = Net::HTTP::Get.new(url)
        response = http.request(request)
      }
      rescue Timeout::Error
        return nil
    end

  #since the above method only returns either "true" (and allow the code to keep going")
  #or "nil" and stops the code from running, we need to rewrtie the code we want to execute in case the api server is working well
    request = Net::HTTP::Get.new(url)
    response = http.request(request)

  #since we may encoutner with server errors, we check the server reply an if there is no error
  #(meaning that the reply.message will be "OK"), then we parse the Json file
  #otherwise we return nil
    if response.message == "OK"
      JSON.parse(response.body)
    else
      return nil
    end
  end

  def manage_request_with_api_key(url, http)

    begin
      status = Timeout::timeout(1) {
        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-host"] = ENV["AXIE_HOST"]
        request["x-rapidapi-key"] = ENV["AXIE_KEY"]
        response = http.request(request)
      }
    rescue Timeout::Error
      return nil
    end

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = ENV["AXIE_HOST"]
    request["x-rapidapi-key"] = ENV["AXIE_KEY"]
    response = http.request(request)

    if response.message == "OK"
      json_response = JSON.parse(response.body)
    else
      return nil
    end
  end

end
