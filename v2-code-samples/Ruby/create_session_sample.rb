require "json"
require "net/http"
require "net/https"

class CreateSessionSample
  attr_accessor :system_id, :system_pwd, :user_name, :user_pwd

  def initialize
    @endpoint = "https://connect.gettyimages.com/v1/session/CreateSession"
    @system_id = "your system id"
    @system_pwd = "your system password"
    @user_name = "user name"
    @user_pwd = "user password"
  end

  def create_session
    request = {
        :RequestHeader =>
            {
                :Token => ""
            },
        :CreateSessionRequestBody =>
            {
                :SystemId => @system_id,
                :SystemPassword => @system_pwd,
                :UserName => @user_name,
                :UserPassword => @user_pwd
            }
    }

    response = post_json(request)

    #status = response["ResponseHeader"]["Status"]
    #token = response["CreateSessionResult"]["Token"]
    #secure_token = response["CreateSessionResult"]["SecureToken"]
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