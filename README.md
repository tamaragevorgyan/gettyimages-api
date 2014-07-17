# Getty Images Connect API

The Getty Images Connect API allows developers to
- [Search](https://connect.gettyimages.com/swagger/ui/index.html#!/Search) for images from our extensive catalog.
- Get [metadata](https://connect.gettyimages.com/swagger/ui/index.html#!/Images), such as the photographer's name, associated with images.
- [Download](https://connect.gettyimages.com/swagger/ui/index.html#!/Downloads) files at various sizes using standard Getty Images product types (e.g. Editorial Subscription, Easy Access, Thinkstock Subscriptions).
 
This page describes the current version of Connect. [Documentation for prior versions](v2/README.md) is also available.

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
        - Use to search for and embed from over 40 million embeddable images.

### If you do not have a Mashery Member account

1. [Register](https://api.gettyimages.com/member/register) a new Mashery Member account and your application.
2. Select your desired type of Api-Key. Two options are available:
    -  **Issue a new key for Getty Test**
        - Use to test Getty Images Connect functionality including: image search and metadata, download, and account management.
    - **Issue a new key for Connect Embed**
        - Use to search for and embed from over 40 million embeddable images.
3. Click **Register**. You will receive an email presently with a confirmation link. Click the link.
4. Sign in with your Mashery Member credentials.

### After registering an application and receiving an Api-Key

1. Finish reading this overview.
2. Play with and learn more about the technical details using our interactive [endpoint documentation](https://connect.gettyimages.com/swagger/ui/index.html).
3. Begin developing your application! All calls must be [authenticated](#authentication) with your Api-Key. To [authorize](#authorization) access to protected resources (e.g. `https://connect.gettyimages.com/v3/downloads/{id}`), get an access token using the [OAuth 2 Client Credentials Flow](oauth2.md#client-credentials-flow).

## Connect Overview

- [Endpoint Documentation](#endpoint-documentation)
- [Current Version](#current-version)
- [Authentication](#authentication)
- [Authorization](#authorization)
- [Schema](#schema)
- [Http Verbs](#http-verbs)
- [Http Redirects](#http-redirects)
- [Parameters](#parameters)
- [Errors](#errors)
- [Hypermedia](#hypermedia)
- [Pagination](#pagination)
- [Rate Limiting](#throttling)
- [Cross Origin Resource Sharing](#cross-origin-resource-sharing)
- [Timezones](#timezones)

### Endpoint Documentation

We use [Swagger](https://helloreverb.com/developers/swagger) to document Connect endpoints. You can interact directly with Connect via our [Swagger page (https://connect.gettyimages.com/swagger)](https://connect.gettyimages.com/swagger) after acquiring an Api Key.

### Current Version

Connect is currently at version 3. Use the following base URI to access version 3 endpoints.

    https://connect.gettyimages.com/v3/

### Authentication

All requests to Connect require an Api-Key to authenticate the client.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://connect.gettyimages.com/v3/images/452224426"

### Authorization

Some Connect endpoints require or optionally accept authorization via an access token. An access token can be acquired using a Connect [OAuth2 flow](/oauth2.md#authorization-grant-flows). The access token is passed via the HTTP `Authorization` header.

    Authorization: Bearer {access_token}

This example calls the OAuth2 [client credentials flow](oauth2.md#client-credentials-flow) to get an `access_token` (where the actual access token has been replaced with "token_string").

    curl -d 'grant_type=client_credentials&client_id=j878g39yx378pa77djthzzpn&client_secret=hZJS5A3GJpJvcGhaXwev3kwmq3DgtfcQmEuGbGruQBfsz' "https://connect.gettyimages.com/oauth2/token"
    
    HTTP/1.1 200 OK
    Content-Type: application/json; charset=utf-8
    Content-Length: 10870
    
    {"access_token":"token_string","token_type":"Bearer","expires_in":"1800"}

We can use the access token to download the image `sample.jpg` to the  current directory.

    curl -H "Api-Key:j878g39yx378pa77djthzzpn" -H "Authorization: Bearer {access_token}" https://connect.gettyimages.com/v3/downloads/83454811 -d "'" -L -o sample.jpg

If authorization is required but missing, the client recieves an authorization challenge in the response.

    HTTP/1.1 401 Unauthorized
    WWW-Authenticate: Bearer realm="Download",error="invalid_token",error_description="The access token is missing"

### Schema

All Connect access is over HTTPS. All data is sent and received as JSON.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://connect.gettyimages.com/v3/search/images?phrase=books"

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

    {"result_count":867845,"images":[ /* snipped */ ]}

All timestamps are returned in [ISO 8601](http://www.w3.org/TR/NOTE-datetime) format

    YYYY-MM-DDTHH:MM:SSZ

#### Summary, Detail, and Custom Representations

Some fields are computationally expensive for Connect to provide, or require additional authorization access privileges. Therefore, when a client retrieves a resource, the response defaults to a subset of the data fields for that resource. This is the `summary_set` representation of the resource. Clients can specify additional fields be returned for a resource using the `fields` querystring parameter. Connect provides a `detail_set` specifier that will include additional fields from a pre-defined set.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://connect.gettyimages.com/v3/images/452224426?fields=detail_set 

Alternately, clients can pass a comma delimited list of the specific fields they are interested in.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://connect.gettyimages.com/v3/images/452224426?fields=id,title"

Some fields are in neither `summary_set` nor `detail_set` and must be explicitly specified.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://connect.gettyimages.com/v3/images/452224426?fields=download_sizes"

##### Downloadable Sizes

Calculating download authorizations for the various available sizes of an image is computationally expensive. Therefore, clients must explicitly specify that they want this information via the `fields` querystring parameter. Clients must also provide an [access token](#authorizations) to retrieve downloadable sizes.

The following tables explain the available arguments and show the allowed `fields` arguments for the endpoints that can return sizes and downloads.

| argument          | description                                                             |
|-------------------|-------------------------------------------------------------------------|
| downloads         | returns downloadable sizes, with hypermedia links to download each size |
| download_sizes    | returns downloadable sizes, without hypermedia links                    |
| largest_downloads | returns hypermedia links to download the largest size                   |

| endpoints                    | download_sizes | downloads | largest_downloads |
|------------------------------|----------------|-----------|-------------------|
| `v3/search/images`           |                |           |        X          |
| `v3/search/images/creative`  |                |           |        X          |
| `v3/search/images/editorial` |                |           |        X          |
| `v3/images`                  |      X         |     X     |        X          |

##### Display Sizes

Display sizes can be retrieved by passing any of the following arguments in the `fields` parameter.

| argument | description                                        |
|----------|----------------------------------------------------|
| comp     | largest available display size                     |
| preview  | medium display size, approximately 400 pixels wide |
| thumb    | smallest display size, usually 170 pixels wide     |

### Http Verbs

Where possible, Connect strives to use appropriate HTTP verbs for each action.

Verb	| Description
------ | -----------------------------------------------
GET	| Used for retrieving resources.
POST	| Used for creating resources, or performing custom actions.
PUT	| Used for replacing resources or collections. For PUT requests with no body attribute, be sure to set the Content-Length header to zero.
DELETE	| Used for deleting resources.

### HTTP Redirects

Connect uses HTTP redirection where appropriate. Clients should assume that any request may result in a redirection. Receiving an HTTP redirection is not an error and clients should follow that redirect. Redirect responses will have a `Location` header field which contains the URI of the resource to which the client should repeat the requests. Connect currently uses [`302 Found`](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.3.3) and [`303 See Other`](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.3.4) for redirects.

### Parameters

Some Connect endpoints take parameters specified as a segment in the path.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://connect.gettyimages.com/v3/images/452224426"

Additional options can be specified as HTTP querystring parameters.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://connect.gettyimages.com/v3/search/images?phrase=books"

Some resources allow filtering on their representations, using the `fields` querystring parameter.

    curl -i -H "Api-Key:j878g39yx378pa77djthzzpn" "https://connect.gettyimages.com/v3/images/452224426?fields=id,title"

In the last example, the response will contain only the fields `id` and `title`.

### Errors

There are the most common errors a client may receive when calling Connect.

1. Sending misspelled or improperly formatted request bodies or querystring parameters will result in a `400 Bad Request` response.
    ```http
    HTTP/1.1 400 Bad Request
    Content-Type: application/json; charset=utf-8

    {
        "message": "Invalid Request. Possible required parameter missing."
    }
    ```
1. Omitting, misspelling or sending invalid Api-Key will result in a `403 Forbidden: Account Inactive` response.
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
1. Exceeding your Api-Key's [call per second throttle limit](#throttling) will result in a `403 Forbidden: Account Over Queries Per Second Limit` response.
    ```http
    HTTP/1.1 403 Forbidden
    X-Error-Detail:  Account Over Queries Per Second Limit
    Content-Type: application/json; charset=utf-8

    {
        "message": "Account Over Queries Per Second Limit"
    }
    ```
1. Exceeding your Api-Key's [call per day throttle limit](#throttling) will result in a `403 Forbidden: Account Over Rate Limit` response.
    ```http
    HTTP/1.1 403 Forbidden
    X-Error-Detail:  Account Over Rate Limit
    Content-Type: application/json; charset=utf-8

    {
        "message": "Account Over Rate Limit"
    }
    ```

### Hypermedia

All resources may have one or more URI properties linking to other resources. These provide explicit URIs to additional resources, saving Connect clients from the need to construct the URIs on their own.

Here's an example of a search result providing a URI for downloading the image's largest size.

```json
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
```

A POST to the provided URI with a valid Api-Key and access token will download the image.

### Pagination

Many Connect endpoints provide support for pagination of results. Pagination can be controlled by using the `page` and `page_size` querystring parameters. Default values will be used if none are provided.

- The `page` parameter defaults to 1.
- Search results default to a `page_size` of 30 items per `page`. The maximum `page_size` is 100.

This example demonstrates requesting the first page, containing 20 items, of search results.

    curl -H "Api-Key:j878g39yx378pa77djthzzpn" "https://connect.gettyimages.com/v3/search/images?phrase=dogs&page=1&page_size=20"

### Throttling

Api-Keys have associated throttle limits. These limits can be found on your [account page](https://api.gettyimages.com/apps/mykeys). Click the **View Report** link on your key to get the current status of your limits.

There are two throttling limits and each has its own error message.

- Calls per second
    ```
    HTTP/1.1 403 Forbidden
    X-Error-Detail:  Account Over Queries Per Second Limit

    {"message":"Account Over Queries Per Second Limit"}
    ```
- Calls per day
    ```
    HTTP/1.1 403 Forbidden
    X-Error-Detail:  Account Over Rate Limit

    {"message":"Account Over Rate Limit"}
    ```

### Cross Origin Resource Sharing

We support cross origin resource sharing. All endpoints will return the header:

    Access-Control-Allow-Origin: *

### Timezones

We use UTC as the timezone for our date fields.
