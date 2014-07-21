require "json"
require "net/http"
require "net/https"

class RenewSessionSample

  attr_accessor :system_id, :system_pwd

  def initialize
    @endpoint = "https://connect.gettyimages.com/v1/session/RenewSession"
    @system_id = "your system id"
    @system_pwd = "your system password"
  end

  # token received from CreateSession/RenewSession API call  
  def renew_session(token)
    request = {
        :RequestHeader =>
            {
                :Token => token
            },
        :RenewSessionRequestBody =>
            {
                :SystemId => @system_id,
                :SystemPassword => @system_pwd
            }
    }
    response = post_json(request)

    #status = response["ResponseHeader"]["Status"]
    #token = response["RenewSessionResult"]["Token"]
    #secure_token = response["RenewSessionResult"]["SecureToken"]
  end

  def post_json(request)
    #You may wish to replace this code with your preferred library for posting and receiving JSON data.
    uri = URI.parse(@endpoint)
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true

    response = http.post(uri.path, request.to_json, {'Content-Type' =>'application/json'}).body
    JSON.parse(response)
  end
end