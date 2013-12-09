Authentication in Getty Connect Using OAuth 2.0
===============================================

What is OAuth?
--------------
OAuth is an open security protocol designed to protect system and user credentials in client applications. Think of all those apps on your phone that ask you to sync with your Twitter or Facebook account to pull in your contacts or other data specific to you. That’s OAuth in action! 

Prior to implementing OAuth, the Connect API required client applications to provide both client and user credentials. Connect authenticated the credentials and then granted access to the API and user functionality such as search, download, and lightbox management.

OAuth allows users to authorize a client application to access user functionality without requiring the client application to directly handle the user’s credentials. Thus OAuth improves security by reducing the exposure of end user credentials. 

What Changes?
-------------
Most existing client applications will continue to authenticate as they do currently. However, client applications that allow users to sign in with their Getty Images or Thinkstock credentials must use one of the authorization workflows defined in OAuth 2.0.


Important Terminology
---------------------
Before we dive into the details of the OAuth 2.0 authorization workflows, let’s make sure we’re using a common vocabulary:

| Term            | Definition      	                              | Example (if applicable)               |
|:----------------|:--------------------------------------------------|:--------------------------------------|
| Resource Owner  | The end user who has access to a set of resources.| A Getty Images or Thinkstock end user.|
| Protected Resource | Resource, stored on or provided by a server, that requires authorization to access it. | Images, videos, lightboxes |
| Authorization Server | Entity that protects resources and validates credentials before authorizing a client application to take any action on behalf of an end user (such as search, lightbox, or download). | Getty Images’ OAuth server |
| Client Application | Application using the Connect API. | Connect API client | 
| Client Credentials | API key and secret for the client application. | | 
| Access Token | Token provided by the authorization server to the client application to authorize access to resources.||
| Token Revocation | Means of revoking an access token. Getty Images or a user can revoke an access token if suspicious activity is detected. | |
| Client Type | A client type is assigned to a client application based on their ability to authenticate securely with the authorization server. | Public or confidential (see <a href="http://tools.ietf.org/html/rfc6749#section-2.1">OAuth2 RFC</a> for more info) |

Authorization Grant Flows
--------------------------
Summarized below are the four authorization grant flows in OAuth 2.0. 

| Authorization Grant | Client Environment | Entities Required |
|:--------------------|:-------------------|:------------------|
| Implicit Grant | Client-side application, where the application cannot secure the API secret | API key, User ID and password | 
| Resource Owner Password Credentials | Resource owner has high degree of trust with the client application. | API key and secret, User ID and password |
| Client Credentials | Client application is also the resource owner. | API key and secret | 
| Authorization Code\*  | Hosted web application, where client credentials are stored on the web server | API key and secret, User ID and password | 
\* Connect currently supports Implicit Grant, Resource Owner Password Credentials, and Client Credentials flows.  Authorization Code flow support may be added at a later time.

### Implicit Grant Flow ###
#### Summary ####
http://tools.ietf.org/html/rfc6749#section-4.2  
Getty Images requires this flow for 3rd party client applications. In this flow, the user authorizes the application to access their protected resources using the Getty Images authorization server. Developers follow these steps to get an access token for their application:

1. Client application calls the Auth endpoint (e.g., https://connect.gettyimages.com/oauth2/auth/) and passes in the following information:
  * API key / client ID
  * redirect uri that has been registered with Connect (parameters may be added that are not registered)
  * response type of "token"
  * state (optional)

2. Client application redirects to our sign-in page, whose location is provided in the response to step 1.

3. End user signs in with their Getty Images or Thinkstock credentials, and clicks Authorize.

4. Connect verifies the client and user credentials and then redirects to the client application with a long-lived access token.

#####Example request:

        GET https://connect.gettyimages.com/oauth2/auth/?response_type=token&client_id=s6BhdRkqt3&state=xyz&redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb HTTP/1.1

#####Example response:

        HTTP/1.1 302 Found
        Location: https://client.example.com/cb#access_token=2YotnFZFEjr1zCsicMWpAA&state=xyz&token_type=bearer

#### Token Expiration and Revocation ####
Some resources accept longer-lived access tokens, depending on the sensitivity of the resource. For instance, search functionality accepts long-lived tokens (i.e., one year), whereas download functionality is protected by a shorter access token lifetime (i.e., one week). 

Once an access token is no longer valid (has expired) for a given resource, a new access token must be retrieved to access that resource. The Implicit Grant flow does not support access token refresh. New access tokens must be retrieved via the Implicit Grant flow.

Access tokens can also be revoked when the user changes their password. Revoked tokens cannot be used for any API access.

### Resource Owner Flow ###
#### Summary ####
http://tools.ietf.org/html/rfc6749#section-4.3  
The resource owner flow is only for Getty Images and Getty Images partner applications. This grant type is suitable for clients capable of obtaining the resource owner's credentials. It is also used to migrate existing clients using direct authentication schemes such as HTTP Basic or Digest authentication to OAuth by converting the stored credentials to an access token.

1. Client application calls the token endpoint and includes the following information in the request:
  * grant type of "password"
  * username
  * password
  * client ID / API key
  * client secret

2. Client receives the following information as a response:
  * access token
  * refresh token
  * expiration value (in seconds)
  * token type of "bearer"

Notes: 
  * The access token is good for 30 minutes
  * The refresh token is good for one year and can be used to retrieve another 30-minute access token by calling the token endpoint with a grant type of 'refresh_token'.

#####Example request:
        
        POST /token HTTPS/1.1
        Host: connect.gettyimages.com/oauth2/token/
        Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW
        Content-Type: application/x-www-form-urlencoded

        client_id=TestClientId&client_secret=TestSecret&grant_type=password&username=johndoe&password=A3ddj3w

#####Example response:

        HTTPS/1.1 200 OK
        Content-Type: application/json;charset=UTF-8
        Cache-Control: no-store
        Pragma: no-cache

        {
                "access_token":"2YotnFZFEjr1zCsicMWpAA",
                "token_type":"Bearer",
                "expires_in":1800,
                "refresh_token":"tGzv3JOkF0XG5Qx2TlKWIA"
        }

#####Example refresh request:

        POST /token HTTPS/1.1
        Host: connect.gettyimages.com/oauth2/token/
        Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW
        Content-Type: application/x-www-form-urlencoded
        
        grant_type=token_refresh&client_id=TestClientId&client_secret=TestSecret&refresh_token=tGzv3JOkF0XG5Qx2TlKWIA

#### Token Expiration and Revocation ####
The resource owner flow grants a 30-minute access token. If the client application needs to access content for the user longer that 30 minjutes, it can use the refresh token to get a new access token that will also be valid for 30 minutes. The refresh token is valid for one year and can be used as many times as needed within that one year to get a new access token. The refresh token cannot be used for API access. 

Refresh tokens can be revoked when the user changes their password. Revoked tokens cannot be used for any API access.

### Client Credentials Flow  ###
#### Summary ####
http://tools.ietf.org/html/rfc6749#section-4.4  
Client Credentials flow is for client applications that will not have individual users. An application token is created and limits the client application to operations that do not need user credentials. A Sandbox application (for trial development and without a licensing agreement) can only use Client Credential flow.

1. Client application calls the token endpoint with the following information in the request:
  * grant type of "client_credentials"
  * client ID / API key
  * client secret

2. Client receives the following information as a response:
  * access token
  * expiration value (in seconds)
  * token type of 'bearer'

Note: The access token is good for 30 minutes

#####Example request:
        
        POST /token HTTPS/1.1
        Host: connect.gettyimages.com/oauth2/token/
        Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW
        Content-Type: application/x-www-form-urlencoded

        client_id=TestClientId&client_secret=TestSecret&grant_type=client_credential

#####Example response:

        HTTPS/1.1 200 OK
        Content-Type: application/json;charset=UTF-8
        Cache-Control: no-store
        Pragma: no-cache

        {
                "access_token":"2YotnFZFEjr1zCsicMWpAA",
                "token_type":"Bearer",
                "expires_in":1800,
        }

#### Token Expiration and Revocation ####
The client credential flow grants a 30 minute access token.  Once the token has expired, a call for a new access token is required.

References
----------
OAuth2 Specification - http://tools.ietf.org/html/rfc6749
