# Getty Images Connect API v3 #
Our API allows developers to:
  * [Search](https://connect.gettyimages.com/swagger/ui/index.html#!/Search) for images
  * Get [image metadata](https://connect.gettyimages.com/swagger/ui/index.html#!/Images)
  * [Download](https://connect.gettyimages.com/swagger/ui/index.html#!/Downloads) images

## Steps to get started
  1. [Swagger Interactive Documentation](https://connect.gettyimages.com/swagger)
  1. [Quick Start](quick-start.md)
  1. [Register](https://api.gettyimages.com/member/register) for an API Key.
  1. [Code Samples](code-samples)
  1. [Release Notes](release-notes.md) 

# Overview #

  1. [Current Version](#current-version)
  1. [Schema](#schema)
  1. [Swagger](#swagger)
  1. [Parameters](#parameters)
  1. [Errors](#errors)
  1. [Http Verbs](#http-verbs)
  1. [Http Redirects](#http-redirects)
  1. [Authentication](#authentication)
  1. [Hypermedia](#hypermedia)
  1. [Pagination](#pagination)
  1. [Rate Limiting](#throttling)
  1. [Cross Origin Resource Sharing](#cross-origin-resource-sharing)
  1. [Timezones](#timezones)

### Current Version ###

The Connect API is currently on v3 as indicated by the URI

    https://connect.gettyimages.com/v3/{resource_name}

### Schema ###
All API access is over HTTPS and accessed from the [https://connect.gettyimages.com/v3/](https://connect.gettyimages.com/v3/) domain. All data is sent and received as JSON.

    curl -H Api-Key:mzqtmcrk8bpsx9jfr9c9y47x -i https://connect.gettyimages.com/v3/search/images?phrase=cheese
    
    HTTP/1.1 200 OK
    Access-Control-Allow-Headers: origin, accept, content-type
    Access-Control-Allow-Methods: options, post
    Access-Control-Allow-Origin: *
    Access-Control-Max-Age: 1728000
    Cache-Control: no-cache,no-cache
    Content-Language: en-US
    Content-Type: application/json; charset=utf-8
    Date: Mon, 14 Jul 2014 18:43:44 GMT
    Expires: -1
    Pragma: no-cache
    Server: Mashery Proxy
    X-Mashery-Responder: prod-j-worker-us-west-1c-13.mashery.com
    Content-Length: 23292
    Connection: keep-alive
    
    {"sample response": "in json format"}

All timestamps are returned in ISO 8601 format:

    YYYY-MM-DDTHH:MM:SSZ

***TODO: Mention Mime Types***

### Swagger ###

We use Swagger as our main tool for exploring our API. You can start interacting with the API immediately after acquiring an API key.

[https://connect.gettyimages.com/swagger](https://connect.gettyimages.com/swagger)

## Parameters ##

Some API methods take parameters specified as a segment in the path:

    curl -i "https://connect.gettyimages.com/images/<image_id>

Additional options can be specified as HTTP query string parameters:

    curl -i "https://connect.gettyimages.com/images?phrase=animals

Some resources allow filtering on their representations:

    curl -i "https://connect.gettyimages.com/images/<image_id>?fields=id,title

In the last example, the fields query string parameter will limit the response information down to the id and title of the image requested.


***TODO: Discuss fields and multi-value lists (e.g. filters)***

## Errors ##

***todo: describe getty error cases (4xx vs 5xx), mimetype, and special cases (e.g. non-mimetype).  Use specific examples!***

This section documents the HTTP status codes returned by the Connect V3 API and 
provides the most likely cause and resolution for the cause.

Errors is grouped into two sections:  Endpoint Errors documents the status codes returned by each of the V3 endpoints

### Endpoint Errors ###

This section documents the standard HTTP status codes returned by API Connect V3 for each endpoint.  Each entry below describes the end point and lists the possible error codes and the meaning of the status code with in the context of the endpoint.


A numerically sorted list of status codes returned by Connect V3 is found in the 
section HTTP/1.1 Status Codes, below.

#### Endpoint /v3/downloads/{id} ####
The Connect V3 endpoint is used to download an image identified by its asset number
returned by one of the three /v3/search endpoints documented below.

The Connect V3 downloads endpoint returns these success and error status codes:

*  200 OK
*  303 See other
*  400 Bad Request
*  401 Unauthorized
*  403 Forbidden
*  404 Image Not Found
*  500 Internal System Error
*  502 Bad Gateway

##### 200 OK #####
Connect V3 returns 200 OK for all successful calls to the /v3/download/{id} 
endpoint. 

##### 303 See Other #####
Connect V3 returns 302 to indicate to the client applications that their request 
is being redirected to a different endpoint for downloading the requested image.

The image download will not display in the Swagger tools.
###### Example ######

	https://connect.gettyimages.com/v3/search/images?phrase=kittens  
	https://connect.gettyimages.com:443/v3/downloads/451681062
		 --  the preceeding call to downloads returns 303 
	http://delivery.gettyimages.com/xa/451681062.jpg?v=1&c=IWSAsset&k=1&d=[SECURITY TOKEN]
		 --  the preceeding call to //delivery returns 303
	

##### 400 Bad Request #####
The Connect v3 API returns 400 Bad Request whenever it cannot parse the download
request or the request is otherwise does not conform to the specifications outlined
in this document.

###### Example ######

##### 401 Unauthorized #####
Connect V3 returns 401 Unauthorized when presented with an invalid client token.
###### Example ######

	https://connect.gettyimages.com/v3/downloads/123533904
	Api-Key: t0B30rN0tb3T4a5IsTheQu3s
	Authorization: Bad Bearer CaiBWhB0eGaJzF9a7CzSzbGCzkHAdlQCfEAX6Qcm4IJyqA0Jjef8Zru8b9CqhOJFNyl19mMQTMODfVldREQOsIVIxKWsq5Le8coRunVlcS9EQSgNcC3RpMnfRrWzCUElyO8Y1h+7mXbMCOlKMmK2l3Sde2KXOZDsUFlfdweoZV8=|77u/WGVETUgrd3VZcGM5bUtpNGNDamUKMTE3MzEKOTE4ODQ0MAphdWVsQmc9PQpjdTZsQmc9PQoxCnQyZ3c5cWs3NHE2OWdoZ3ZjNmhnbjNocgoxMjcuMC4wLjEKMAoxMTczMQphdWVsQmc9PQoxMTczMQowCgo=|4

##### 403 Forbidden #####
Connect V3 returns 403 Forbidden when presented with an invalid api-key in the Api-Key: header.
###### Example ######
	https://connect.gettyimages.com/v3/downloads/123533904
	Api-Key: L00kL1keARand0mL3tt3rSNo
	Authorization: Bearer CaiBWhB0eGaJzF9a7CzSzbGCzkHAdlQCfEAX6Qcm4IJyqA0Jjef8Zru8b9CqhOJFNyl19mMQTMODfVldREQOsIVIxKWsq5Le8coRunVlcS9EQSgNcC3RpMnfRrWzCUElyO8Y1h+7mXbMCOlKMmK2l3Sde2KXOZDsUFlfdweoZV8=|77u/WGVETUgrd3VZcGM5bUtpNGNDamUKMTE3MzEKOTE4ODQ0MAphdWVsQmc9PQpjdTZsQmc9PQoxCnQyZ3c5cWs3NHE2OWdoZ3ZjNmhnbjNocgoxMjcuMC4wLjEKMAoxMTczMQphdWVsQmc9PQoxMTczMQowCgo=|4

##### 404 Image Not Found #####
Connect V3 Download returns 404 Image Not Found with the specified image ID is invalid or does not exist.
###### Example ######
Assuming 123533904 is a valid image ID, changing the zero 0 to the letter O will 
generate a 404 Not Found.  Changing the leading 1 to a 9 will produce the same 404 result.

	-- invalid ID - contains the letter 'o':
	https://connect.gettyimages.com/v3/downloads/1235339o4

	-- invalid ID - image does not exist
	https://connect.gettyimages.com/v3/downloads/923533904

##### 500 Internal Server Error #####
Connect V3 or its host platform will return 500 Internal Server Error when an 
unexpected condition was encountered and no more specific message is available.  
We encourage you to report this error to Getty Images for resolution.

##### 502 Bad Gateway #####
Connect V3 returns status code 502 Bad Gateway when the URL points to an invalid 
or unknown host name.

###### Example ######
	-- connectx is an invalid host name (at this writing):
	https://connectx.gettyimages.com/v3/downloads/123533904



#### Endpoint /v3/images/{id} ####
The /v3/images/{id} endpoint is used to return the metadata about the specified, 
comma separated list of images (*{id}*).

	https://connect.gettyimages.com/v3/images/451681062
	https://connect.gettyimages.com/v3/images/451681062,500381311

Optional query parameters are used to refine the metadata returned:

	https://connect.gettyimages.com/v3/search/images?phrase=kittens&fields=summary-set%2Cartist

The optional page and page-size query parameters tells the Connect V3 API how to 
paginate the request:

	https://connect.gettyimages.com/v3/search/images?phrase=kittens&fields=summary-set%2Cartist

##### 200 OK #####
Connect V3 returns 200 OK for all successful calls to the /v3/download/{id} 
endpoint. 

##### 303 See Other #####
The Connect V3 API does not use status code 303 for /v3/download/{id}

##### 400 Bad Request #####

##### 303 See Other #####
Connect V3 does not use status code 303 for /v3/download/{id}
##### 400 Bad Request #####
##### 401 Unauthorized #####
##### 403 Forbidden #####
##### 404 Image Not Found #####
##### 500 Internal Server Error #####
##### 502 Bad Gateway #####
##### 596 #####
The Connect V3 /v3/images/{id} endpoint returns status code 596 



#### /v3/search/images ####
#### /v3/search/images/creative ####
#### /v3/search/images/editorial ####

The three search/images exhibit similar behavior in responding to errors and 
reporting http status codes and will be documented together;.

Optional query parameters are used to refine the metadata returned:

	https://connect.gettyimages.com/v3/search/images?phrase=kittens&fields=summary-set%2Cartist

The optional page and page-size query parameters tells the Connect V3 API how to 
paginate the request:

	https://connect.gettyimages.com/v3/search/images?phrase=kittens&fields=summary-set%2Cartist

##### 200 OK #####
##### 200 OK #####
Connect V3 returns 200 OK for all successful calls to the xxx/v3/download/{id} 
endpoint. 

##### 303 See Other #####
Connect V3 does not use status code 303 for xxx/v3/download/{id}
##### 400 Bad Request #####
##### 401 Unauthorized #####
##### 403 Forbidden #####
##### 404 Image Not Found #####
##### 500 Internal Server Error #####
##### 502 Bad Gateway #####



##### 200 OK #####
Connect V3 returns 200 OK for all successful calls to the xxx/v3/download/{id} 
endpoint. 
##### 401 Unauthorized #####
##### 403 Forbidden #####
##### 404 Image Not Found #####
##### 500 Internal Server Error #####
##### 502 Bad Gateway #####



##### 200 OK #####
Connect V3 returns 200 OK for all successful calls to the xxx/v3/download/{id} 
endpoint. 

##### 303 See Other #####
Connect V3 does not use status code 303 for xxx/v3/download/{id}
##### 400 Bad Request #####
##### 401 Unauthorized #####
##### 403 Forbidden #####
##### 404 Image Not Found #####
##### 500 Internal Server Error #####
##### 502 Bad Gateway #####





### HTTP 1.1 Status Codes Summary ###

This section summarizes the HTTP status codes returned by Connect V3 endpoints in 
numeric order.  The summary includes the definition of the status code as 
specified by RFC-2616 and a list in alphabetic order of the end points and any exceptions to variation from the standard.

#### 200 OK ####
#### 303 See Other ####
#### 400 Bad Request ####
#### 401 Unauthorized ####
#### 403 Forbidden ####
#### 404 Image Not Found ####
#### 500 Internal Server Error ####
#### 502 Bad Gateway ####

### Endpoint - Status Code Crossreference ###

 |: EndPoint                 : | 200 | 303 | 400 | 401 | 403 | 404 | 500 | 502 |
 |:--------------------------- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | 
 | /v3/downloads/{id}          |  x  |  x  |  x  |  x  |  x  |  x  |  x  |  x  |
 | /v3/images/                 |  x  |  x  |  x  |  x  |  x  |  x  |  x  |  x  | 
 | /v3/images/{id}             |  x  |  x  |  x  |  x  |  x  |  x  |  x  |  x  | 
 | /v3/search/images           |  x  |  x  |  x  |  x  |  x  |  x  |  x  |  x  | 
 | /v3/search/images/creative  |  x  |  x  |  x  |  x  |  x  |  x  |  x  |  x  | 
 | /v3/search/images/editorial |  x  |  x  |  x  |  x  |  x  |  x  |  x  |  x  | 

HTTP Status Codes returned by endpoints.


### Http Verbs ###

Where possible, API v3 strives to use appropriate HTTP verbs for each action.

Verb	Description
GET	Used for retrieving resources.
POST	Used for creating resources, or performing custom actions (such as merging a pull request).
PUT	Used for replacing resources or collections. For PUT requests with no body attribute, be sure to set the Content-Length header to zero.
DELETE	Used for deleting resources.

### HTTP Redirects ###

Connect API v3 uses HTTP redirection where appropriate. Clients should assume that any request may result in a redirection. Receiving an HTTP redirect is not an error and clients should follow that redirect. Redirect responses will have a Location header field which contains the URI of the resource to which the client should repeat the requests.  We use 302 and 303 HTTP response status codes for redirects.

Here's an example of a call to oatuh2/token:

	https://connect.gettyimages.com/oauth2/auth?response_type=token&client_id={api-key}
	
	HTTP/1.1 302 Found
	Date: Mon, 14 Jul 2014 18:34:51 GMT
	Expires: -1
	Location: https://secure.gettyimages.com/sign-in/oauth?app_name=v3Search-test&resume_params=redirect_uri%3dhttps%253a%252f%252fconnect.gettyimages.com%252fSwaggerUI%252fimplicit_grant.html%26client_id%3d{api-key}

### Authentication ###

All requests to connect.gettyimages.com require the use of an ApiKey for purposes of identifying the client. 

    -H "Api-Key:{Your API Key}"

An authorization header is required to perform download operations, as well as getting certain user specific fields in searches. The input after **Bearer** is the token received from the oauth2/token call. 

    url -d 'grant_type=client_credentials&client_id={apikey}&client_secret={apisecret}' https://connect.gettyimages.com/oauth2/token

All requests to connect.gettyimages.com require the use of an API key for purposes of identifying the client.

	curl -H "Api-Key:{mashery_apikey}" -H "Authorization: Bearer {access_token}" https://connect.gettyimages.com/v3/downloads/83454811 -d "'" -L -o 83454811.jpg

Many operations require an individual user (e.g. a Getty Images customer) to be identified. Credentials (API key and secret) must be acquired from our API portal (**link here**). Authorization (token) can then be requested via our OAuth endpoint (**link here**). These credentials must be passed via the Authorization Bearer HTTP header.

	curl -H "Api-Key:{mashery_apikey}" -H "Authorization: Bearer {access_token}" https://connect.gettyimages.com/v3/downloads/83454811 -d "'" -L -o 83454811.jpg


Note that we reserve the right to revoke a token without warning; this will occur, for example, if the user updates his/her credentials through the website.  In this case the service will respond with a **??????** response, and the client should re-enter the OAuth workflow.

### Hypermedia ###
All resources may have one or more url properties linking to other resources. These are meant to provide explicit URLs so that proper API clients don’t need to construct URLs on their own. It is highly recommended that API clients use these. Doing so will make future upgrades of the API easier for developers. All URLs are expected to be proper [RFC 6570 URI](http://tools.ietf.org/html/rfc6570) templates.

Here's an example of an image search asking for largest-downloads :

    "images": [
	    {
	      "id": "3231670",
	      "largestDownloads": [
		    {
		      "product-type": "premiumaccess",
		      "uri": "https://connect.gettyimages.com/Public/3.0/downloads/3231670"
		    }
	      ]
    	}
	]

This URL "https://connect.gettyimages.com/Public/3.0/downloads/3231670" can now be used to get the image when a POST is made to it with your api-key and authorization token.
### Pagination ###

The Connect API provides an abundance of information about the images found that match your search.  Sometimes, even most of the time, you will find you are asking for *too much* information, and to keep our servers (and your applications) happy, the Connect API will automatically paginate your search results.  

- The Connect API will return your results in groups called ***pages***.
- The number of items in a page is its ***page size***.
- You may specify how many items you receive in a page using the ***page-size*** query parameter.  By default, Search uses a page size of 30 items per page.  The maximum number of items per page is 100.
- You should specify the desired page number on each search.  If omitted, page will default to 1, returning the same  ***page-size*** results on each call.
- The ***last*** page returned to you may be as few as one item or as many ***page-size*** items.    You will never receive more than ***page-size*** items in any page.

The following example shows how to add a page and page-size query parameter to your search request using curl:

    C:\>curl -I "https://connect.gettyimages.com/v3/search/images?phrase=vampire0cows&page=1&page-size=20"   -H "Api-Key:x2xx9xx74x69xxxxx6xxx3xx"   -H "Authorization:Bearer XXX.....XXX"

Please note: the authorization token has been reduced in size.

### Throttling ###
Self serve clients will have a limited rate compared to registered clients.  Rate Limits can be found on your Mashery account page found here:  [Mashery Account Information](https://gettyimages.mashery.com/apps/mykeys)

Click the **"View Report"** link on your key to get the current status of your rate limit.

There are two rate limits and each limit has its own error message.

- Calls per second
<pre>HTTP/1.1 403 Forbidden 
   X-Error-Detail:  Account Over Queries Per Second Limit
   {"message":"Account Over Queries Per Second Limit"}   
</pre>
- Calls per day
<pre>HTTP/1.1 403 Forbidden 
   X-Error-Detail:  Account Over Rate Limit
   {"message":"Account Over Rate Limit"}
</pre>

### Cross Origin Resource Sharing ###

### Timezones ###
We use UTC as the timezone for our date fields.
# Getty Images Concepts #

## Images and Sizes ##
If explicitly specified (by asking for 'sizes' in the 'fields' parameter) when querying image metadata, sizes will be included, indicating height and width by pixels.  Size tokens from previous API versions are no longer honored.

## Display vs Download ##
When retrieving images via search or asset metadata operations, you have the option of retrieving various URLs for image display (e.g. uri-preview, uri-comp, etc).  These are for displaying within the context of your application and are not licensed for re-use outside the context of your application.  Depending on various rules (client application permissions, user type, image type image size) the images may be watermarked.

Downloads (available through 'downloads' and 'largestdownloads' fields) allow non-watermarked images to be licensed and downloaded for re-consumption by the end user (consistent with all licensing permissions and restrictions as if the user had downloaded the image through the [gettyimages.com](http://gettyimages.com) or [thinkstockphotos.com](http://thinkstockphotos.com) websites.   

## Agreements, Authorizations, and Downloads ##
**TODO: Explain the basic concepts of agreements (GI types you only have one applicable agreement, TS types you may have multiples and so need to choose).  And how they affect image authorization and downloading.**
