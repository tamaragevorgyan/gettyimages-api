# Getty Images Connect API

The Getty Images Connect API allows developers to:
- [Search](https://connect.gettyimages.com/swagger/ui/index.html#!/Search) for images from our extensive catalog.
- Get [image metadata](https://connect.gettyimages.com/swagger/ui/index.html#!/Images).
- [Download](https://connect.gettyimages.com/swagger/ui/index.html#!/Downloads) images using standard Getty Images product types (e.g. Premium Access, Image Packs, Thinkstock Subscriptions).

## Getting started

### If you already have a Mashery Member account

1. [Sign in](https://api.gettyimages.com/login/login) with your Mashery Member credentials.
2. Click the **My Account** link near the top right of the page.
3. Click the **Get API keys** button.
4. Register your application and select your desired type of Api-Key. Two options are available:
    -  **Issue a new key for Getty Test**
        - Use to test Getty Images Connect functionality including: image search and metadata, download, and account management.
    - **Issue a new key for Connect Embed**
        - Use to search for and embed from over 40 million embedable images.

### If you do not have a Mashery Member account

1. [Register](https://api.gettyimages.com/member/register) a new Mashery Member account and your application.
2. Select your desired type of Api-Key. Two options are available:
    -  **Issue a new key for Getty Test**
        - Use to test Getty Images Connect functionality including: image search and metadata, download, and account management.
    - **Issue a new key for Connect Embed**
        - Use to search for and embed from over 40 million embedable images.
3. Click **Register**. You will receive an email presently with a confirmation link. Click the link.
4. Sign in with your Mashery Member credentials.

### After registering an application and receiving an Api-Key

1. Finish reading this overview.
2. Play with and learn more about the technical details using our interactive [endpoint documentation](https://connect.gettyimages.com/swagger/ui/index.html).
3. Begin developing your application using the [OAuth 2 Client Credentials Flow](https://github.com/gettyimages/connect/blob/master/documentation/endpoints/oauth2/README.md#client-credentials-flow)

## Quick links

- [Interactive Documentation](https://connect.gettyimages.com/swagger)
- [Code Samples](code-samples)
- [Release Notes](release-notes.md)
- [Connect Overview (below)](#Connect-Overview)
- [Getty Images Concepts (below)](#Getty-Images-Concepts)

## Connect Overview

- [Current Version](#current-version)
- [Schema](#schema)
- [Swagger](#swagger)
- [Parameters](#parameters)
- [Errors](#errors)
- [Http Verbs](#http-verbs)
- [Http Redirects](#http-redirects)
- [Authentication](#authentication)
- [Hypermedia](#hypermedia)
- [Pagination](#pagination)
- [Rate Limiting](#throttling)
- [Cross Origin Resource Sharing](#cross-origin-resource-sharing)
- [Timezones](#timezones)

### Current Version

Connect is currently on version 3, as indicated by the base URI:

    https://connect.gettyimages.com/v3/

### Schema

All Connect access is over HTTPS. All data is sent and received as JSON.

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

### Swagger

We use [Swagger (https://connect.gettyimages.com/swagger)](https://connect.gettyimages.com/swagger) to document Connect endpoints. You can interact directly with Connect via Swagger after acquiring an Api-Key.

### Parameters

Some Connect endpoints take parameters specified as a segment in the path:

    curl -i "https://connect.gettyimages.com/images/{id}

Additional options can be specified as HTTP query string parameters:

    curl -i "https://connect.gettyimages.com/images?phrase=animals

Some resources allow filtering on their representations:

    curl -i "https://connect.gettyimages.com/images/{id}?fields=id,title

In the last example, the `fields` querystring parameter will limit the response information down to the id and title of the image requested.

### Errors

This section documents the standard HTTP status codes returned by API Connect V3
for each endpoint.  Where appropriate, endpoint/request specific usage is called
out.  Examples are provided where needed to clarify how a request coding error 
results in the error status code being returned to your application.

#### Endpoint /v3/downloads/{id} ####


The Connect V3 API returns these HTTP status codes:

*  200 OK
*  303 See other
*  400 Bad Request
*  401 Unauthorized
*  403 Forbidden
*  404 Image Not Found
*  500 Internal System Error
*  502 Bad Gateway
*  596 Service Not Found

#### 200 OK ####
All  Connect V3 API requests return 200 OK for all successful calls to the V3 
RESTful web service.  Please note, however, a successful search (request status 
code 200) may return no results as encoded in the JSON response body. 

#### 303 See Other ####
Response code 303 is reserved to indicate the one-step download request 
/v3/downloads/{id} is redirecting the session to 
The Connect /v3/downloads/{id} request returns 302 to indicate to the client applications that their request 
is being redirected to a different.

The image download will not display in the Swagger tools.
#### 400 Bad Request ####

The Connect V3 API returns 400 Bad Request when it cannot parse the request.  
Sources for parse errors include missing separators between request elements, 
misspelled query or header parameters and incorrectly specified image parameters.
Examples of these errors include

Connect V3 /v3/search/images endpoints returns 400 Bad Request whenever the initial 
search specifies a **page** query parameter with a value other than 1 (**page=1**),
a **page-size=** query parameter whose value is greater than 100, less than 1 or 
a non-numeric value.

#### 401 Unauthorized ####
The Connect /v3/downloads/{id} request returns a 401 Unauthorized status code
 when the client access token specified in the request is

1.	Invalid --  The token provided was not generated by our OAuth2 security system, 
2.	Expired --  Too much time has expired between creating the token with OAuth2 and this use.
3.	Omitted --	The token was omitted from the request.

#### 403 Forbidden ####
The Connect /v3/downloads/{id} request returns 403 Forbidden when

1.	the request header Api-Key: key-value pair is omited,
2.	the Api-Key: key is misspelled, or
3.	the Api-key value is invalid or
4.	the Api-Key is omitted.

#### 404 Image Not Found ####
The Connect /v3/downloads/{id} and /v3/image/{id} requests return status code 404 Not Found 
when provided an image Id that cannot be found.

The Connect V3 image search requests, /v3/search/images, /v3/search/image/creative and
/v3/search/image/editorial do not return 404.

#### 500 Internal Server Error ####

Connect V3 or its host platform will return 500 Internal Server Error when an 
unexpected condition was encountered and no more specific message is available.  
We encourage you to report this error to Getty Images for resolution.

Additionally, the Connect /v3/images/{id} request returns status code 500 when the access token is
missing.
#### 502 Bad Gateway ####
the Connect /v3/images/{id} request returns status code 502 Bad Gateway when the URL points to an invalid 
or unknown host name.

#### 596 Service Not Found ####
The Connect /v3/images/{id} endpoint returns status code 596 when the image Id is
missing:.

### Http Verbs

Where possible, Connect strives to use appropriate HTTP verbs for each action.

Verb	Description
GET	Used for retrieving resources.
POST	Used for creating resources, or performing custom actions (such as merging a pull request).
PUT	Used for replacing resources or collections. For PUT requests with no body attribute, be sure to set the Content-Length header to zero.
DELETE	Used for deleting resources.

### HTTP Redirects

Connect uses HTTP redirection where appropriate. Clients should assume that any request may result in a redirection. Receiving an HTTP redirect is not an error and clients should follow that redirect. Redirect responses will have a Location header field which contains the URI of the resource to which the client should repeat the requests.  We use 302 and 303 HTTP response status codes for redirects.

Here's an example of a call to oauth2/token:

	https://connect.gettyimages.com/oauth2/auth?response_type=token&client_id={api-key}
	
	HTTP/1.1 302 Found
	Date: Mon, 14 Jul 2014 18:34:51 GMT
	Expires: -1
	Location: https://secure.gettyimages.com/sign-in/oauth?app_name=v3Search-test&resume_params=redirect_uri%3dhttps%253a%252f%252fconnect.gettyimages.com%252fSwaggerUI%252fimplicit_grant.html%26client_id%3d{api-key}

### Authentication ###

All requests to connect.gettyimages.com require the use of an Api-Key for purposes of identifying the client. 

    -H "Api-Key:{Your Api-Key}"

An authorization header is required to perform download operations, as well as getting certain user specific fields in searches. The input after **Bearer** is the token received from the oauth2/token call. 

    curl -d 'grant_type=client_credentials&client_id={api_key}&client_secret={api_secret}' https://connect.gettyimages.com/oauth2/token

All requests to connect.gettyimages.com require the use of an Api-Key for purposes of identifying the client.

    curl -H "Api-Key:{Your Api-Key}" -H "Authorization: Bearer {access_token}" https://connect.gettyimages.com/v3/downloads/83454811 -d "'" -L -o 83454811.jpg

Many operations require an individual user (e.g. a Getty Images customer) to be identified. Credentials (API key and secret) must be acquired from our [Api Portal](http://api.gettyimages.com/). An authorization token can then be requested via our [OAuth2 endpoint](https://connect.gettyimages.com/oauth2/token). These credentials must be passed via the Authorization Bearer HTTP header.

    curl -H "Api-Key:{Your Api-Key}" -H "Authorization: Bearer {access_token}" https://connect.gettyimages.com/v3/downloads/83454811 -d "'" -L -o 83454811.jpg


Note that we reserve the right to revoke a token without warning; this will occur, for example, if the user updates his/her credentials through the website.  In this case the service will respond with a **??????** response, and the client should re-enter the OAuth workflow.

### Hypermedia ###
All resources may have one or more `uri` properties linking to other resources. These provide explicit URIs, saving Connect clients from the need to construct URIs on their own. It is highly recommended that Connect clients use these provided URIs. Doing so will make future upgrades of Connect easier for developers. All URIs are expected to be proper [RFC 6570 URI](http://tools.ietf.org/html/rfc6570) templates.

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

This URI "https://connect.gettyimages.com/Public/3.0/downloads/3231670" can now be used to get the image when a POST is made to it with your Api-Key and access token.

### Pagination ###

Connect provides an abundance of information about the images found that match your search.  Sometimes, even most of the time, you will find you are asking for *too much* information, and to keep our servers (and your applications) happy, Connect will automatically paginate your search results.  

- Connect will return your results in groups called ***pages***.
- The number of items in a page is its ***page size***.
- You may specify how many items you receive in a page using the ***page-size*** query parameter.  By default, Search uses a page size of 30 items per page.  The maximum number of items per page is 100.
- You should specify the desired page number on each search.  If omitted, page will default to 1, returning the same  ***page-size*** results on each call.
- The ***last*** page returned to you may be as few as one item or as many ***page-size*** items.    You will never receive more than ***page-size*** items in any page.

The following example shows how to add a page and page-size query parameter to your search request using curl:

    curl -I "https://connect.gettyimages.com/v3/search/images?phrase=vampire0cows&page=1&page-size=20" -H "Api-Key:{Your Api-Key}" -H "Authorization: Bearer {Your Token}"

Please note: the authorization token has been reduced in size.

### Throttling ###
Self serve clients will have a limited rate compared to registered clients.  Rate Limits can be found on your Mashery account page found here:  [Mashery Account Information](https://gettyimages.mashery.com/apps/mykeys)

Click the **"View Report"** link on your key to get the current status of your rate limit.

There are two rate limits and each limit has its own error message.

- Calls per second

    HTTP/1.1 403 Forbidden 
    X-Error-Detail:  Account Over Queries Per Second Limit

    {"message":"Account Over Queries Per Second Limit"}   

- Calls per day

    HTTP/1.1 403 Forbidden 
    X-Error-Detail:  Account Over Rate Limit

    {"message":"Account Over Rate Limit"}

### Cross Origin Resource Sharing ###

We support cross origin resource sharing. All endpoints will return the header:

    Access-Control-Allow-Origin: *

### Timezones ###

We use UTC as the timezone for our date fields.


## Getty Images Concepts

### Images sizes
If explicitly specified (by asking for 'sizes' in the 'fields' parameter) when querying image metadata, sizes will be included, indicating height and width by pixels.  Size tokens from previous Connect versions are no longer honored.

### Display vs Download
When retrieving images via search or asset metadata operations, you have the option of retrieving various URIs for image display (e.g. uri-preview, uri-comp, etc).  These are for displaying within the context of your application and are not licensed for re-use outside the context of your application.  Depending on various rules (client application permissions, user type, image type image size) the images may be watermarked.

Downloads (available through 'downloads' and 'largestdownloads' fields) allow non-watermarked images to be licensed and downloaded for re-consumption by the end user (consistent with all licensing permissions and restrictions as if the user had downloaded the image through the [gettyimages.com](http://gettyimages.com) or [thinkstockphotos.com](http://thinkstockphotos.com) websites.   

### Product Types, Authorizations, and Downloads
**TODO: Explain the basic concepts of product types (GI types you only have one applicable agreement, TS types you may have multiples and so need to choose).  And how they affect image authorization and downloading.**
