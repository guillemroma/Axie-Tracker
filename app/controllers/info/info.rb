module Info
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  Info = 0

  def Info.present
    url = URI("https://cryptopanic.com/api/v1/posts/?auth_token=#{ENV["AUTH"]}&currencies=AXS,SLP")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)

    response = http.request(request)
    return @articles = JSON.parse(response.body)

  end
end
