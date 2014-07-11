# Getty Images Connect API v3 #

Our set of APIs enable seamless integration of Getty Images' expansive content, powerful search and rich metadata directly into your products. With Connect's API solutions, you can fully control, customize and scale as you grow.

# Overview #

1. [Current Version](https://github.com/nskirov/connect#current-version)
2. [Schema](https://github.com/nskirov/connect#schema)
3. [Swagger](https://github.com/nskirov/connect#swagger)
4. [Parameters](https://github.com/nskirov/connect#parameters)
5. [Errors](https://github.com/nskirov/connect#errors)
6. [Http Verbs](https://github.com/nskirov/connect#http-verbs)
7. [Http Redirects](https://github.com/nskirov/connect#http-redirects)
8. [Authentication](https://github.com/nskirov/connect#authentication)
9. [Hypermedia](https://github.com/nskirov/connect#hypermedia)
10. [Pagination](https://github.com/nskirov/connect#pagination)
11. [Rate Limiting](https://github.com/nskirov/connect#throttling)
12. [Cross Origin Resource Sharing](https://github.com/nskirov/connect#cross-origin-resource-sharing)
13. [Timezones](https://github.com/nskirov/connect#timezones)

### Current Version ###

The Connect API is currently on v3 as indicated by the URI

    https://connect.gettyimages.com/v3/{resource_name}

### Schema ###
All operations in this version of the API require HTTPS.

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

### Http Verbs ###

Where possible, API v3 strives to use appropriate HTTP verbs for each action.

Verb	Description
GET	Used for retrieving resources.
POST	Used for creating resources, or performing custom actions (such as merging a pull request).
PUT	Used for replacing resources or collections. For PUT requests with no body attribute, be sure to set the Content-Length header to zero.
DELETE	Used for deleting resources.

### HTTP Redirects ###

API v3 uses HTTP redirection where appropriate. Clients should assume that any request may result in a redirection. Receiving an HTTP redirection is not an error and clients should follow that redirect. Redirect responses will have a Location header field which contains the URI of the resource to which the client should repeat the requests.

***TODO: Provide oauth or download examples of redirecting***

### Authentication ###

All requests to connect.gettyimages.com require the use of an ApiKey for purposes of identifying the client. 

    -H "Api-Key:{Your API Key}"

Authorization header is required to perform download operations, as well as getting certain user specific fields in searches. The input after **Bearer** is the token received from the oauth2/token call. 

    url -d 'grant_type=client_credentials&client_id={apikey}&client_secret={apisecret}' https://connect.gettyimages.com/oauth2/token

All requests to connect.gettyimages.com require the use of an API key for purposes of identifying the client.

	curl -H "Api-Key:{mashery_apikey}" -H "Authorization: Bearer {access_token}" https://connect.gettyimages.com/v3/downloads/83454811 -d "'" -L -o 83454811.jpg

Many operations require an individual user (e.g. a Getty Images customer) to be identified. Credentials (API key and secret) must be acquired from our API portal (**link here**). Authorization (token) can then be requested via our OAuth endpoint (**link here**). These credentials must be passed via the Authorization Bearer HTTP header.

	curl -H "Api-Key:{mashery_apikey}" -H "Authorization: Bearer {access_token}" https://connect.gettyimages.com/v3/downloads/83454811 -d "'" -L -o 83454811.jpg


Note that we reserve the right to revoke a token without warning; this will occur, for example, if the user updates his/her credentials through the website.  In this case the service will respond with a **??????** response, and the client should re-enter the OAuth workflow.

### Hypermedia ###

### Pagination ###

<!--
copied from <<[./v3/Pagination.md] which doesn't seem to be including correctly.
-->

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

# Getty Images Concepts #

## Images and Sizes ##
If explicitly specified (by asking for 'sizes' in the 'fields' parameter) when querying image metadata, sizes will be included, indicating height and width by pixels.  Size tokens from previous API versions are no longer honored.

## Display vs Download ##
When retrieving images via search or asset metadata operations, you have the option of retrieving various URLs for image display (e.g. uri-preview, uri-comp, etc).  These are for displaying within the context of your application and are not licensed for re-use outside the context of your application.  Depending on various rules (client application permissions, user type, image type image size) the images may be watermarked.

Downloads (available through 'downloads' and 'largestdownloads' fields) allow non-watermarked images to be licensed and downloaded for re-consumption by the end user (consistent with all licensing permissions and restrictions as if the user had downloaded the image through the [gettyimages.com](http://gettyimages.com) or [thinkstockphotos.com](http://thinkstockphotos.com) websites.   

## Agreements, Authorizations, and Downloads ##
**TODO: Explain the basic concepts of agreements (GI types you only have one applicable agreement, TS types you may have multiples and so need to choose).  And how they affect image authorization and downloading.**