require "json"
require "net/http"
require "net/https"

class CreateDownloadRequestSample

  def initialize
    @endpoint = "https://connect.gettyimages.com/v1/download/CreateDownloadRequest"
  end

  def create_download_request(secure_token, download_token)
    #Secure token is required for create download request
    request = {
        :RequestHeader => {
            :Token => secure_token,
            :CoordinationId => "MyUniqueId"
        },
        :CreateDownloadRequestBody =>
            { :DownloadItems =>
                  [{
                       :DownloadToken => download_token
                   }]
            }
    }
    response = post_json(request)
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
