require 'rest-client'
require 'net/http'
require 'uri'

class GetImageDetailsSample

  def initialize
    @endpoint = "https://connect.gettyimages.com/v1/search/GetImageDetails"
  end

  # token received from CreateSession/RenewSession API call
  # USAGE: asset_ids = ["1234567890","1234567890"]
  #        response = @get_image_details.go @token, asset_ids
  def get_image_details(token, assetIds)

    request = {
        :RequestHeader => {
            :Token => token,
            :CoordinationId => "MyUniqueId"
        },
        :GetImageDetailsRequestBody => {
            :CountryCode => "USA",
            :ImageIds => assetIds,
            :Language => "en-us"
        }
    }

    response = post_json(request)

    # status = response["ResponseHeader"]["Status"]
    # images = response["GetImageDetailsResult"]["Images"]
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