# Getty Images Connect API

The Getty Images Connect API allows developers to:
- [Search](https://connect.gettyimages.com/swagger/ui/index.html#!/Search) for images from our extensive catalog.
- Get [metadata](https://connect.gettyimages.com/swagger/ui/index.html#!/Images), such as the photographer's name, associated with images.
- [Download](https://connect.gettyimages.com/swagger/ui/index.html#!/Downloads) images at various sizes using standard Getty Images product types (e.g. Premium Access, Image Packs, Thinkstock Subscriptions).

## Quick links

- [Getting Started](#getting-started)
- [Connect Overview (below)](#connect-overview)
- [OAuth2 Access Tokens](oauth2.md)
- [Interactive Documentation](https://connect.gettyimages.com/swagger)
- [Code Samples](code-samples)
- [Release Notes](release-notes.md)

## Getting Started

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
3. Begin developing your application! All calls must be [authenticated](#authentication) with your Api-Key. To [authorize](#authorization) access to protected resources, get an access token using the [OAuth 2 Client Credentials Flow](oauth2.md#client-credentials-flow).

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

Connect is currently on version 3, as indicated by the base URI

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

All timestamps are returned in [ISO 8601](http://www.w3.org/TR/NOTE-datetime) format

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

In the last example, the `fields` querystring parameter will limit the response fields to `id` and `title`.

### Errors

There are four possible types of client errors on API calls to Connect endpoints
that receive request headers or request bodies.

1. Sending misspelled or improperly formatted query parameters will result in a `400 Bad Request` response.

	    HTTP/1.1 400 Bad Request
    	Content-Type: application/json; charset=utf-8
    	Content-Length: 67
    	{
    		"Message":"Invalid Request. Possible required parameter missing."
    	}
    

2. Omitting, misspelling or sending invalid Api-Key will result in a `403 Forbidden` response.

	    HTTP/1.1 403 Forbidden
	    Content-Length: 31
	    Content-Type: application/json
	    {
	       message=Account Inactive
	    }

5. Submitting invalid `id`'s will result in a `404 Image Not Found` response.

    	HTTP/1.1 404 Not Found
    	Content-Length: 73
    	{
    		ErrorCode=ImageNotFound,
    		ErrorMessage=Image not found: 452O76944
    	}

Additionally, image downloads will result in a `303 See Other` response.

    	`HTTP/1.1 303 See Other`



### Http Verbs

Where possible, Connect strives to use appropriate HTTP verbs for each action.

Verb	| Description
------ | -----------------------------------------------
GET	| Used for retrieving resources.
POST	| Used for creating resources, or performing custom actions.
PUT	| Used for replacing resources or collections. For PUT requests with no body attribute, be sure to set the Content-Length header to zero.
DELETE	| Used for deleting resources.

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
All resources may have one or more URI properties linking to other resources. These provide explicit URIs, saving Connect clients from the need to construct URIs on their own.

Here's an example of an image search providing a URI for the image's largest download:

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

A POST to the provided URI with the Api-Key and Authorization headers will download the image.

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

### Throttling

Api-Keys have associated rate limits. These limits can be found on your [Mashery account](https://gettyimages.mashery.com/apps/mykeys) page.

Click the **View Report** link on your key to get the current status of your rate limit.

There are two rate limits and each limit has its own error message.

**Calls per second**

    HTTP/1.1 403 Forbidden 
    X-Error-Detail:  Account Over Queries Per Second Limit

    {"message":"Account Over Queries Per Second Limit"}   

**Calls per day**

    HTTP/1.1 403 Forbidden 
    X-Error-Detail:  Account Over Rate Limit

    {"message":"Account Over Rate Limit"}

### Cross Origin Resource Sharing

We support cross origin resource sharing. All endpoints will return the header:

    Access-Control-Allow-Origin: *

### Timezones

We use UTC as the timezone for our date fields.


## Getty Images Concepts

### Images sizes
If explicitly specified (by asking for 'sizes' in the 'fields' parameter) when querying image metadata, sizes will be included, indicating height and width by pixels.  Size tokens from previous Connect versions are no longer honored.

### Display vs Download
When retrieving images via search or asset metadata operations, you have the option of retrieving various URIs for image display (e.g. uri-preview, uri-comp, etc).  These are for displaying within the context of your application and are not licensed for re-use outside the context of your application.  Depending on various rules (client application permissions, user type, image type image size) the images may be watermarked.

Downloads (available through 'downloads' and 'largestdownloads' fields) allow non-watermarked images to be licensed and downloaded for re-consumption by the end user (consistent with all licensing permissions and restrictions as if the user had downloaded the image through the [gettyimages.com](http://gettyimages.com) or [thinkstockphotos.com](http://thinkstockphotos.com) websites.   

### Product Types, Authorizations, and Downloads
**TODO: Explain the basic concepts of product types (GI types you only have one applicable agreement, TS types you may have multiples and so need to choose).  And how they affect image authorization and downloading.**
