require "json"
require "net/http"
require "net/https"

class SearchForEditorialImagesSample
  def initialize
    @endpoint = "http://connect.gettyimages.com/v1/search/SearchForImages"
    @phrase = "angelina jolie"
  end

   # token received from CreateSession/RenewSession API call
   def search_for_images(token)
    request = {
        :RequestHeader => { :Token => token},
        :SearchForImages2RequestBody => {
            :Query => { :SearchPhrase => @phrase},
            :ResultOptions => {
                :ItemCount => 25,
                :ItemStartNumber => 1
            },
            :Filter => { :ImageFamilies => ["editorial"] }
        }
    }
    response = post_json(request)

    #status = response["ResponseHeader"]["Status"]
    #images = response["SearchForImagesResult"]["Images"]
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
