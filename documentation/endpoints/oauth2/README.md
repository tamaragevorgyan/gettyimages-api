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


Authorization Grant Flows
--------------------------
Summarized below are the four authorization grant flows in OAuth 2.0. Connect will initially support the Implicit flow, adding in other flows over time. 

| Authorization Grant | Client Environment | Entities Required |
|:--------------------|:-------------------|:------------------|
| Authorization Code  | Hosted web application, where client credentials are stored on the web server | API key and secret, User ID and password | 
| Implicit Grant | Client-side application, where the application cannot secure the API secret | API key, User ID and password | 
| Resource Owner Password Credentials | Resource owner has high degree of trust with the client application. | API key and secret, User ID and password |
| Client Credentials | Client application is also the resource owner. | API key and secret | 

### Implicit Grant Flow ###
#### Summary ####
Getty Images requires this flow for 3rd party client applications that are unable to secure their client credentials (for example, on a secure server). In this flow, the user authorizes the application to access their protected resources using the Getty Images authorization server. Developers follow these steps to get an access token for their application:

1. Client application calls the Auth endpoint (e.g., https://connect.gettyimages.com/oauth2/auth/) and passes in their API key.
2. Client application redirects to our sign-in page whose location is provided in the response to step 1.
3. End user signs in with their Getty Images or Thinkstock credentials and clicks Authorize.
4. Connect verifies the client and user credentials and redirects to the client application with an access token.

#### Token Expiration and Revocation ####
Some resources accept longer-lived access tokens, depending on the sensitivity of the resource. For instance, search functionality accepts long-lived tokens (e.g., one year), whereas download functionality is protected by a shorter access token lifetime (e.g., one week). 

Once an access token is no longer valid (has expired) for a given resource, a new access token must be retrieved to access that resource. The implicit grant flow does not support access token refresh. New access tokens must be retrieved via the implicit grant flow.

Access tokens can be also be revoked when the user changes their password. Revoked tokens cannot be used for any API access.

References
----------
OAuth2 Specification - http://tools.ietf.org/html/rfc6749
