class Exchange
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  def initialize()
  end

  def add(from,to)

    url = URI("https://api.exchangerate.host/convert?from=#{from}&to=#{to}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    manage_request(url, http)

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
      json_response = JSON.parse(response.body)["info"]["rate"]
    else
      return nil
    end
  end
end
