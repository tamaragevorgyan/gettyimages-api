require "json"
require "net/http"
require "net/https"

class GetLargestImageDownloadAuthorizationsSample

  def initialize
	  @endpoint = "http://connect.gettyimages.com/v1/download/GetLargestImageDownloadAuthorizations"
  end


  def get_largest_image_download_authorization(token ,image_id)
    request = {
        :RequestHeader => {
            :Token => token,
            :CoordinationId => "MyUniqueId"
        },
        :GetLargestImageDownloadAuthorizationsRequestBody =>
            { :Images =>
                [{
                  :ImageId => image_id
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
