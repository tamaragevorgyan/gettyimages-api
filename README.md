# Getty Images API 3.0

Seamlessly integrate Getty Images' expansive digital content, powerful search technology, and rich metadata into your publishing tools, products and services!
- <a href="https://api.gettyimages.com/swagger/ui/index.html#!/Search" target="_blank">Search</a> for images from our extensive creative and editorial catalogs.
- Get <a href="https://api.gettyimages.com/swagger/ui/index.html#!/Images" target="_blank">image metadata</a>.
- <a href="https://api.gettyimages.com/swagger/ui/index.html#!/Downloads" target="_blank">Download</a> files using your Getty Images products (e.g., Editorial subscriptions, Easy Access, Thinkstock Subscriptions, and Image Packs).

This page describes the Getty Images API version 3.0. <a href="v2/README.md" target="_blank">Documentation for prior versions</a> is also available.

## New Features

- Simplified authentication and authorization. Client applications no longer need to maintain session tokens. Instead, applications identify themselves on every call to the API with an Api-Key. Resources that require or support authorization based on user identity will accept OAuth2 access tokens in addition to the application’s Api-Key.
- RESTful API for working with image and metadata resources leveraging HTTP verbs and returning standard HTTP Status codes.
- Simplified image download process by providing direct download links in search and metadata resources.
- <a href="https://api.gettyimages.com/swagger" target="_blank">Interactive documentation</a> that is always up-to-date and in sync with our latest API functionality.
- Localization support using the `Accept-Language` HTTP header.
- [SDKs](#sdks) to make getting started even easier.

## Quick links

- [Getting Started](#getting-started)
- [API Overview](#api-overview)
- <a href="oauth2.md" target="_blank">OAuth2 Access Tokens</a>
- <a href="https://api.gettyimages.com/swagger" target="_blank">Interactive Documentation</a>
- <a href="code-samples" target="_blank">Code Samples</a>
- <a href="release-notes.md" target="_blank">Release Notes</a>
- [Getty Images API SDKs](#sdks)

## Getting Started

### If you already have a Mashery Member account

1. <a href="https://api.gettyimages.com/login/login" target="_blank">Sign in</a> with your Mashery Member credentials.
2. Click the **My Account** link near the top right of the page.
3. Click the **Get API keys** button.
4. Register your application and select your desired type of Api-Key. We provide two key options.
    -  **Issue a new key for Getty Test**
        - Use to test Getty Images API functionality including: image search and metadata, download, and account management.
    - **Issue a new key for Getty Images Embed**
        - Use to search for and embed from over 40 million embeddable images.

### If you do not have a Mashery Member account

1. <a href="https://api.gettyimages.com/member/register" target="_blank">Register</a> a new Mashery Member account and your application.
2. Select your desired type of Api-Key. We provide two key options.
    -  **Issue a new key for Getty Test**
        - Use to test Getty Images API functionality including: image search and metadata, download, and account management.
    - **Issue a new key for Getty Images Embed**
        - Use to search for and embed from over 40 million embeddable images.
3. Click **Register**. You will receive an email presently with a confirmation link. Click the link.
4. Sign in with your Mashery Member credentials.

### After registering an application and receiving an Api-Key

1. Finish reading this overview.
2. Play with and learn more about the technical details using our interactive <a href="https://api.gettyimages.com/swagger/ui/index.html" target="_blank">endpoint documentation</a>.
3. Begin developing your application! All calls must be [authenticated](#authentication) with your Api-Key. To [authorize](#authorization) access to protected resources (e.g. `https://api.gettyimages.com/v3/downloads/{id}`) get an access token using the [OAuth 2 client credentials flow](oauth2.md#client-credentials-flow).

## API Overview

- [Current Version](#current-version)
- [Authentication](#authentication)
- [Authorization](#authorization)
- [Request Throttling](#request-throttling)
- [Schema](#schema)
- [Resources](#resources)
- [HTTP Verbs](#http-verbs)
- [Parameters](#parameters)
- [Hypermedia](#hypermedia)
- [HTTP Redirects](#http-redirects)
- [Errors](#errors)
- [Pagination](#pagination)
- [Cross Origin Resource Sharing](#cross-origin-resource-sharing)
- [Localization](#localization)
- [oEmbed](#oembed)

### Current Version

The Getty Images API is currently at version 3. Use the following base URI to access version 3 endpoints.

    https://api.gettyimages.com/v3/

### Authentication

The Getty Images API requires all requests include an Api-Key to authenticate the client. Pass the Api-Key via the custom `Api-Key` HTTP Header.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/images/452224426"

### Authorization

The Getty Images API allows, and in some cases requires, requests to include an access token to authorize elevated client privileges. Pass the access token via the standard `Authorization` HTTP header as type `Bearer`.

    curl -H "Api-Key:j878g39yx378pa77djthzzpn" -H "Authorization: Bearer {access_token}" https://api.gettyimages.com/v3/downloads/83454811 -d "'" -L -o sample.jpg

Acquire an access token using one of the Getty Images API [OAuth2 grants](oauth2.md#authorization-grant-flows). This example uses the OAuth2 [client credentials flow](oauth2.md#client-credentials-flow).

    curl -d 'grant_type=client_credentials&client_id=j878g39yx378pa77djthzzpn&client_secret=hZJS5A3GJpJvcGhaXwev3kwmq3DgtfcQmEuGbGruQBfsz' "https://api.gettyimages.com/oauth2/token"

    HTTP/1.1 200 OK
    Content-Type: application/json; charset=utf-8
    Content-Length: 123

    {"access_token": "{token_string}", "token_type": "Bearer", "expires_in": "1800"}

If elevated client privilege is required but missing, the API returns an authorization challenge in the response.

    HTTP/1.1 401 Unauthorized
    WWW-Authenticate: Bearer realm="Download",error="invalid_token",error_description="The access token is missing"

### Request Throttling

The Getty Images API throttles client requests based on limits associated with the client's Api-Key. These limits can be viewed on your <a href="https://api.gettyimages.com/apps/mykeys" target="_blank">account page</a>. Click the **View Report** link on your key to get the current status of an Api-Key's limits.

There are two throttling limits and each has its own error message.

- Calls per second limit
    ```
    HTTP/1.1 403 Forbidden
    X-Error-Detail: Account Over Queries Per Second Limit

    {"message": "Account Over Queries Per Second Limit"}
    ```
- Calls per day limit
    ```
    HTTP/1.1 403 Forbidden
    X-Error-Detail: Account Over Rate Limit

    {"message": "Account Over Rate Limit"}
    ```

### Schema

All API access is over HTTPS. All data is sent and received as JSON.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/search/images?phrase=books"

    HTTP/1.1 200 OK
    Access-Control-Allow-Headers: origin, accept, content-type
    Access-Control-Allow-Methods: options, post
    Access-Control-Allow-Origin: *
    Access-Control-Max-Age: 1728000
    Cache-Control: no-cache,no-cache
    Content-Language: en-US
    Content-Type: application/json; charset=utf-8
    Date: Wed, 16 Jul 2014 17:43:01 GMT
    Expires: -1
    Pragma: no-cache
    Server: Mashery Proxy
    X-Mashery-Responder: prod-j-worker-us-west-1b-19.mashery.com
    Content-Length: 29728
    Connection: keep-alive

    {"result_count": 867845, "images": [ /* snipped */ ]}

The Getty Images API returns UTC date/time values in <a href="http://www.w3.org/TR/NOTE-datetime" target="_blank">ISO 8601</a> format.

    YYYY-MM-DDTHH:MM:SSZ

#### Summary, Detail, and Custom Representations

Some fields are computationally expensive for the API to provide or require additional access privileges; and therefore, are not returned by default. Clients can specify additional fields be returned for a resource using the `fields` querystring parameter.

The default set of fields returned are the `summary_set`. Both of the following produce the same response.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/images/452224426
    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/images/452224426?fields=summary_set

The API provides a `detail_set` specifier that will include additional fields.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/images/452224426?fields=detail_set

Alternately, clients can pass a comma delimited list of the specific fields they are interested in.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/images/452224426?fields=id,title"

Some fields are in neither `summary_set` nor `detail_set` and must be explicitly specified.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/images/452224426?fields=download_sizes"

Some fields require additional access priviledges and must be explicitly specified. In these cases clients must also provide an [access token](#authorization).

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" -H "Authorization: Bearer {access_token}" "https://api.gettyimages.com/v3/images/452224426?fields=downloads"

##### Download Sizes

Authorizing download of an image is computationally expensive. Therefore, clients that wish to receive details of available download sizes for images must explicitly specify that they want this information via the `fields` querystring parameter. The following tables show the available and allowed `fields` arguments for the endpoints that can return sizes and/or links to the downloadable image.

| `fields` argument   | description                                                   |
|---------------------|---------------------------------------------------------------|
| `downloads`         | returns downloadable sizes with hypermedia download links    |
| `download_sizes`    | returns downloadable sizes without hypermedia download links |
| `largest_downloads` | returns hypermedia download links to the largest size         |

| endpoints                    | `download_sizes` | `downloads` | `largest_downloads` |
|------------------------------|------------------|-------------|---------------------|
| `v3/search/images`           |                  |             |          X          |
| `v3/search/images/creative`  |                  |             |          X          |
| `v3/search/images/editorial` |                  |             |          X          |
| `v3/images`                  |        X         |       X     |          X          |

Note that clients using the `download_sizes` or `largest_downloads` arguments must also provide an [access token](#authorization).

##### Display Sizes

Display sizes can be retrieved by passing any of the following arguments in the `fields` parameter.

| `fields` argument | description           |
|-------------------|-----------------------|
| `display_set`     | all display sizes     |
| `high_res_comp`   | largest display size  |
| `comp`            | large display size    |
| `preview`         | medium display size   |
| `thumb`           | smallest display size |

### Resources

The Getty Images API provides a RESTful API centered around resources, identified by a URI, that can be acted upon by the standard [HTTP verbs](#http-verbs). Descriptions of the Getty Images API resources are provided on our <a href="https://api.gettyimages.com/swagger" target="_blank">interactive documentation page</a>.

### HTTP Verbs

The Getty Images API strives to use appropriate HTTP verbs to perform actions on our [resources](#resources).

| verb   | description                                          |
|--------| -----------------------------------------------------|
| GET 	 | use to retrieve a resources or collection            |
| POST	 | use to create a resource or perform a custom action  |
| PUT    | use to store an entity under a specific resource     |
| DELETE | *unsupported at this time*                           |

### Parameters

Some API endpoints take parameters specified as a segment in the path.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/images/452224426"

Additional options can be specified as HTTP querystring parameters.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/search/images?phrase=books"

Some resources allow filtering on their representations using the `fields` querystring parameter.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/images/452224426?fields=id,title"

In the last example the response will contain only the fields `id` and `title`.

### Hypermedia

All resources may have one or more URI properties linking to other resources. These provide explicit URIs to additional resources, saving API clients from the need to construct the URIs on their own.

Here's an example of a search result providing a URI for downloading the image's largest size.

```json
"images": [
    {
      "id": "3231670",
      "largest_downloads": [
        {
          "media_type": "image/jpeg",
          "bytes": 2226077,
          "downloads": [
            {
              "product_type": "premiumaccess",
              "uri": "https://api.gettyimages.com/v3/downloads/3231670"
            }
          ],
          "height": 3000,
          "width": 1607
        }
      ]
    }
  ]

```

A POST to the provided URI with a valid Api-Key and access token will download the image.

### HTTP Redirects

The Getty Images API uses HTTP redirection where appropriate. Clients should assume that any request may result in a redirection and be prepared to follow the redirect. Redirect responses will have a `Location` header field which contains the URI of the resource to which the client should repeat the requests. The API currently uses <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.3.3" target="_blank">`302 Found`</a> and <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.3.4" target="_blank">`303 See Other`</a> for redirects.

### Errors

There are the most common errors a client may receive when calling the API.

1. Sending misspelled or improperly formatted request bodies or querystring parameters will result in a `400 Bad Request` response.
    ```http
    HTTP/1.1 400 Bad Request
    Content-Type: application/json; charset=utf-8

    {
        "message": "Invalid Request. Possible required parameter missing."
    }
    ```
1. Omitting, misspelling, or sending invalid Api-Key will result in a `403 Forbidden: Account Inactive` response.
    ```http
    HTTP/1.1 403 Forbidden
    Content-Type: application/json; charset=utf-8

    {
        "message": "Account Inactive"
    }
    ```
1. Submitting invalid image `id`'s will result in a `404 Not Found` response.
    ```http
    HTTP/1.1 404 Not Found
    Content-Type: application/json; charset=utf-8

    {
        "code": "ImageNotFound",
        "message": "Image not found: 452O76944"
    }
    ```
1. Exceeding your Api-Key's [call per second throttle limit](#request-throttling) will result in a `403 Forbidden: Account Over Queries Per Second Limit` response.
    ```http
    HTTP/1.1 403 Forbidden
    X-Error-Detail:  Account Over Queries Per Second Limit
    Content-Type: application/json; charset=utf-8

    {
        "message": "Account Over Queries Per Second Limit"
    }
    ```
1. Exceeding your Api-Key's [call per day throttle limit](#request-throttling) will result in a `403 Forbidden: Account Over Rate Limit` response.
    ```http
    HTTP/1.1 403 Forbidden
    X-Error-Detail:  Account Over Rate Limit
    Content-Type: application/json; charset=utf-8

    {
        "message": "Account Over Rate Limit"
    }
    ```

### Pagination

Many Getty Images API endpoints provide support for pagination of results. Pagination can be controlled by using the `page` and `page_size` querystring parameters. Default values will be used if none are provided.

- The `page` parameter defaults to 1.
- Search results default to a `page_size` of 30 items per `page`. Valid values are: 1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 25, 30, 50, 60, 75, 100.

This example demonstrates requesting the first page, containing 20 items, of search results.

    curl -H "Api-Key:j878g39yx378pa77djthzzpn" "https://api.gettyimages.com/v3/search/images?phrase=dogs&page=1&page_size=20"

### Cross Origin Resource Sharing

We support cross origin resource sharing ([CORS](http://www.w3.org/TR/cors/)). All endpoints (except `/oauth2/token` and `/oauth2/auth`) return the following header.

    Access-Control-Allow-Origin: *


### Localization

Many Connect endpoints provide support for localization of certain request or response fields using the `Accept-Language` HTTP header. This header value defaults to `en-US` if
- the client omits the `Accept-Language` HTTP header,
- the client omits a locale, or
- the client specifies an unsupported locale.

This example will return country names in French.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" -H "Accept-Language:fr" https://api.gettyimages.com/v3/countries

### oEmbed

##### What is oEmbed?

oEmbed is a format for allowing an embedded representation of a URL on third party sites. The simple API allows a website to display embedded content (such as photos or videos) when a user posts a link to that resource, without having to parse the resource directly.

Full documentation and various client libraries for the oEmbed specification can be found here: http://oembed.com


##### Endpoint
Use the following endpoints to access this operation:

	http://embed.gettyimages.com/oembed


##### Request
The oEmbed request is a GET with the following required parameter. Note: URL encode query string parameters.

	url: http://gty.im/[asset-id]

In addition, you should use the optional caller parameter, providing descriptive value identifying your application.

	caller: example.com

The oEmbed request returns JSON. If the *optional* "format" parameter is used it must contain the value "json". Other formats are not supported and using another value such as "xml" will result in a 501 (Not Implemented) error.

Example request:

	http://embed.gettyimages.com/oembed?url=http%3a%2f%2fgty.im%2f74917285&caller=example.com


##### Response
The oEmbed JSON response has this form, per the oEmbed specification:

	{
	  "type": string,
	  "version": string,
	  "title": string,
	  "caption": string,
	  "photographer": string,
	  "collection": string,
	  "html": string,
	  "width": int,
	  "height": int,
	  "thumbnail_url": string,
	  "thumbnail_height": int,
	  "thumbnail_width": int,
	  "terms_of_use_url": string
	}

Example response:

	{
		"type": "rich",
		"version": "1.0",
		"height": 643,
		"width": 395,
		"html": "\u003cdiv style=\"background-color:#fff;display:inline-block;font-family:'Helvetica Neue',Arial,sans-serif;color:#a7a7a7;font-size:11px;width:100%;max-width:395px;min-width:300px;\"\u003e\u003cdiv style=\"overflow:hidden;position:relative;height:0;padding:150.379747% 0 49px 0;width:100%;\"\u003e\u003ciframe src=\"//localhost:3000/embed/74917285?et=GCDFoeg3T3xB1L6jmY5dDQ\u0026sig=mXFz-gxQc_lIp2nmITlHtjjKIvYL1UD6e5yjuPDQ9FU=\" width=\"395\" height=\"643\" scrolling=\"no\" frameborder=\"0\" style=\"display:inline-block;position:absolute;top:0;left:0;width:100%;height:100%;\"\u003e\u003c/iframe\u003e\u003c/div\u003e\u003cp style=\"margin:0;\"\u003e\u003c/p\u003e\u003cdiv style=\"padding:0;margin:4px 0 0 10px;text-align:left;\"\u003e\u003ca href=\"http://www.gettyimages.com/detail/74917285\" target=\"_blank\" style=\"color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;\"\u003e#74917285\u003c/a\u003e / \u003ca href=\"http://www.gettyimages.com\" target=\"_blank\" style=\"color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;\"\u003egettyimages.com\u003c/a\u003e\u003c/div\u003e\u003c/div\u003e",
		"title": "Model Released Basketball",
		"caption": "Model Released: Two young men outdoors, one man holding basketball, portrait (Photo by Black 100/Getty Images)",
		"photographer": "Black 100",
		"collection": "Allsport Concepts",
		"thumbnail_url": "http://delivery.candidate-gettyimages.com/xt/74917285.jpg?v=1\u0026g=fs2|0|editorial3|17|285\u0026s=1",
		"thumbnail_height": "170",
		"thumbnail_width": "113",
		"terms_of_use_url": "http://www.gettyimages.com/Corporate/Terms.aspx"
	}

##### Workflow example: oEmbed
1. Find embeddable images on www.gettyimages.com (see embed.gettyimages.com for more information)
2. Call oEmbed using the asset id of the embeddable image that you wish to use.

##### Workflow example: Getty Images API client using oEmbed
1. Call CreateSession or OAuth with system/key and user credentials to create an authentication token.
2. Call SearchForImages to find images specifying the search is for embeddable images only, by adding the Filter property EmbedContentOnly (boolean) within the SearchForImagesRequestBody.
3. Call oEmbed with each of the asset ids of the embeddable images that you wish to use.

## SDKs
SDKs for our API are available for multiple languages:
- <a href="https://github.com/gettyimages/connect_sdk_csharp" target="_blank">C#</a>
- <a href="https://github.com/gettyimages/connect_sdk_java" target="_blank">Java</a>
- <a href="https://github.com/gettyimages/connect_sdk_nodejs" target="_blank">Node.js</a>
- <a href="https://github.com/gettyimages/connect_sdk_objective-c" target="_blank">Objective-C (iOS and OS X)</a>
- <a href="https://github.com/gettyimages/connect_sdk_php" target="_blank">PHP</a>
- <a href="https://github.com/gettyimages/connect_sdk_ruby" target="_blank">Ruby</a>
