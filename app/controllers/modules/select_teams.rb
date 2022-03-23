module SelectTeams
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  def SelectTeams.add

    url = URI("https://game-api.axie.technology/toprank?offset=0&limit=50")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse(response.body)

  end

end
