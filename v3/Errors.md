
## Errors ##

***todo: describe getty error cases (4xx vs 5xx), mimetype, and special cases (e.g. non-mimetype).  Use specific examples!***

Introductory remarks describing error codes, end points and the intersection of errors and status codes.

### Endpoint Errors and Status Codes ###

This section documents the standard HTTP status codes returned by API Connect V3 for each endpoint.  Each entry below describes the end point and lists the possible error codes and the meaning of the status code with in the context of the endpoint.


A numerically sorted list of status codes returned by Connect V3 is found in the 
section HTTP/1.1 Status Codes, below.

### /v3/downloads/{id} ###

The Connect V3 downloads endpoint returns these success and error status codes:

*  302 Redirect, aka 302 Found
*  400 Bad Request
*  403 Forbidden
*  404 Image Not Found

#### 302 Found ####
Connect V3 returns 302 to indicate to the client applications that their request 
is being redirected to a different endpoint for downloading the requested image.

The image download will not display in the Swagger tools.
##### Example #####
    https://connect.gettyimages.com:443/v3/search/images?phrase=flowers 
	https://connect.gettyimages.com:443/v3/downloads/123533904
	/* The 302 response 
	http://delivery.gettyimages.com/xa/123533904.jpg

#### 400 Bad Request ####
#### 403 Forbidden ####
#### 404 Image Not Found


### /images/ ###

***TODO***

### /images/{id}

***TODO***

### /search/images ###

***TODO***

### /search/images/creative ###

***TODO***

### /search/images/editorial ###

***TODO***

### HTTP 1.1 Status Codes Summary ###

This section summarizes the HTTP status codes returned by Connect V3 endpoints in 
numeric order.  The summary includes the definition of the status code as 
specified by RFC-2616 and a list in alphabetic order of the end points and any exceptions to variation from the standard.


5. [Errors](https://github.com/nskirov/connect#errors)
#### 302 Found ####

RFC 2616, Fielding, et al, states 
***LINK***
 under which the request was issued.

