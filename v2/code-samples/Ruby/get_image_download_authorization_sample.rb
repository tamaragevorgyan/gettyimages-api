require "json"
require "net/http"
require "net/https"

class GetImageDownloadAuthorizationSample

  def initialize
    @endpoint = "http://connect.gettyimages.com/v1/download/GetImageDownloadAuthorizations"
  end

  def go(token, size_key, image_id)
    request = {
            :RequestHeader =>
                {
                    :Token => token,
                    :CoordinationId => "MyId"
                },
            :GetImageDownloadAuthorizationsRequestBody =>
                {
                    :ImageSizes => [{:ImageId => image_id, :SizeKey => size_key}]
                }
        }
      response = post_json(request)
  end

  def post_json(request)
      #You may wish to replace this code with your preferred library for posting and receiving JSON data.
      uri = URI.parse(@endpoint)
      http = Net::HTTP.new(uri.host, 80)
      http.use_ssl = false

      response = http.post(uri.path, request.to_json, {'Content-Type' =>'application/json'}).body
      JSON.parse(response)
    end
end

