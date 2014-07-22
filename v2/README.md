Getty Images Connect API
========================
Our set of APIs enable seamless integration of Getty Images' expansive content, powerful search 
and rich metadata directly into your internal workflows, products and services. With Connect's API 
solutions, you can fully control, customize and scale as you grow.

The Connect API uses JSON over HTTP POST to allow you to build applications capable of search and 
download on Getty Images using an active download agreement.

##Steps to Get Started
1. [Register for API credentials](https://api.gettyimages.com/member/register) via our portal.
2. Familiarize yourself with the [core concepts] (#core-concepts) and the API operations.
3. Begin developing your application, using the [Client Credentials flow] (../oauth2.md#client-credentials-flow) on the OAuth 2 endpoint.

We will reach out to you concerning commercialization of your application.

##Endpoints

###Session operations
- **[<code>POST</code> OAuth 2.0] (endpoints/oauth2/README.md)**
- **[<code>POST</code> CreateSession](endpoints/session/CreateSession.md)**
- **[<code>POST</code> RenewSession](endpoints/session/RenewSession.md)**

###Search operations
- **[<code>POST</code> SearchForImages](endpoints/search/SearchForImages.md)**
- **[<code>POST</code> GetImageDetails](endpoints/search/GetImageDetails.md)**
- **[<code>POST</code> GetEventDetails](endpoints/search/GetEventDetails.md)**
- **[<code>POST</code> SearchForVideos](endpoints/search/SearchForVideos.md)**

###Download operations
- **[<code>POST</code> GetImageDownloadAuthorizations](endpoints/download/GetImageDownloadAuthorizations.md)**
- **[<code>POST</code> GetLargestImageDownloadAuthorizations](endpoints/download/GetLargestImageDownloadAuthorizations.md)**
- **[<code>POST</code> CreateDownloadRequest](endpoints/download/CreateDownloadRequest.md)**

###Lightbox operations
- **[<code>POST</code> CreateLightbox] (endpoints/lightbox/CreateLightbox.md)**
- **[<code>POST</code> GetLightbox] (endpoints/lightbox/GetLightbox.md)**
- **[<code>POST</code> CreateLightboxItems] (endpoints/lightbox/CreateLightboxItems.md)**
- **[<code>POST</code> DeleteLightboxItems] (endpoints/lightbox/DeleteLightboxItems.md)**
- **[<code>POST</code> DeleteLightbox] (endpoints/lightbox/DeleteLightbox.md)**
- **[<code>POST</code> GetLightboxHeaders] (endpoints/lightbox/GetLightboxHeaders.md)**
- **[<code>POST</code> UpdateLightboxHeader] (endpoints/lightbox/UpdateLightboxHeader.md)**

##Core Concepts

###Authentication
All operations in the Getty Images Connect API require an access token 
argument provided in the RequestHeader. Authorization is granted and an access token based on application and user credentials. The access token securely identifies the caller of an operation. When called, an operation checks the validity of the token before executing the request. A malformed, invalid, or expired token causes an operation to fail.

Clients get access tokens by authenticating themselves using one of the OAuth2 authorization flows.
(Before OAuth2, tokens were retrieved by calling the CreateSession operation.) Most client applications are required to provide the API credentials and a specific user's credentials. For more information, see our [OAuth2 documentation] (../oauth2.md).

###Secure-Only Operations
Some operations are secure only. These operation must be called over an SSL 
connection with a secure token. They include OAuth2, CreateSession, RenewSession, and 
CreateDownloadRequest.

The required combination of passing a secure token over SSL prevents a "man-in-the-middle" 
exploitation where an attacker sniffs tokens from a non-SSL connection, then uses the token 
to impersonate the client, thereby possibly gaining access to sensitive information or 
processes. Operations that could expose sensitive data only accept secure tokens 
over SSL. As long as these tokens are always and only passed over SSL, attackers can 
never acquire a secure token with which to impersonate a valid customer.

Secure authentication tokens are provided by CreateSession operation. Secure 
tokens are essentially the same as standard tokens, with the difference that secure 
tokens can only be used over SSL connections. Calling any operation with a secure 
token over a non-SSL connection will result in an error.

###Token Expiration and Renewal
Access tokens expire after 30 minutes. Depending on the OAuth2 authorization flow, you may receive a refresh token as part of the OAuth2 response that you can use to refresh the session. 

If you are calling CreateSession, you can renew a token before it expires by using 
the RenewSession operation, without having to provide credentials again. 

We recommend clients track each token's time-to-expiration and proactively use the refresh token or call  
RenewSession prior to the token's expiration.
