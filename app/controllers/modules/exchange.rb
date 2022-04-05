module Exchange
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  Modules::Exchange

  def Exchange.add(from,to)

    url = URI("https://api.exchangerate.host/convert?from=#{from}&to=#{to}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)

    response = http.request(request)
    json_response = JSON.parse(response.body)["info"]["rate"]

  end

end
