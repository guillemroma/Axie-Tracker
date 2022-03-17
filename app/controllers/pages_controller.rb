class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  require 'uri'
  require 'net/http'
  require 'openssl'

  def self.add_metrics(ronin_address)

    url = URI("https://axie-infinity.p.rapidapi.com/get-update/#{ronin_address}?id=#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'axie-infinity.p.rapidapi.com'
    request["x-rapidapi-key"] = '00d49a5002mshd146e7dc3babfe4p16bccbjsn385a6dc6bf03'

    response = http.request(request)
    return response.read_body
  end

  def self.add_axies(ronin_address)

    url = URI("https://axie-infinity.p.rapidapi.com/get-axies/#{ronin_address}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'axie-infinity.p.rapidapi.com'
    request["x-rapidapi-key"] = '00d49a5002mshd146e7dc3babfe4p16bccbjsn385a6dc6bf03'

    response = http.request(request)
    return response.read_body

  end


  add_metrics('0xe530affded5adb5dfdc209b7e9b9439384b95189')
  add_axies('0xe530affded5adb5dfdc209b7e9b9439384b95189')
  

end
