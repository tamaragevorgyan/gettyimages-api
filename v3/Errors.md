
## Errors ##

***todo: describe getty error cases (4xx vs 5xx), mimetype, and special cases (e.g. non-mimetype).  Use specific examples!***

This section documents the HTTP status codes returned by the Connect V3 API and 
provides the most likely cause and resolution for the cause.

Errors is grouped into two sections:  Endpoint Errors documents the status codes returned by each of the V3 endpoints

### Endpoint Errors ###

This section documents the standard HTTP status codes returned by API Connect V3 for each endpoint.  Each entry below describes the end point and lists the possible error codes and the meaning of the status code with in the context of the endpoint.


A numerically sorted list of status codes returned by Connect V3 is found in the 
section HTTP/1.1 Status Codes, below.

#### /v3/downloads/{id} ####

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

#### /v3/images/ ####
##### /v3/downloads/{id} #####
##### /v3/images/ #####
##### /v3/images/{id} #####
##### /V3/search/images #####
##### /search/images/creative #####
##### /search/images/editorial #####

***TODO***

#### /v3/images/{id} ####
##### /v3/downloads/{id} #####
##### /v3/images/ #####
##### /v3/images/{id} #####
##### /V3/search/images #####
##### /search/images/creative #####
##### /search/images/editorial #####

***TODO***

#### /V3/search/images ####
##### /v3/downloads/{id} #####
##### /v3/images/ #####
##### /v3/images/{id} #####
##### /V3/search/images #####
##### /search/images/creative #####
##### /search/images/editorial #####

***TODO***

#### /search/images/creative ####
##### /v3/downloads/{id} #####
##### /v3/images/ #####
##### /v3/images/{id} #####
##### /V3/search/images #####
##### /search/images/creative #####
##### /search/images/editorial #####


***TODO***

#### /search/images/editorial ####
##### /v3/downloads/{id} #####
##### /v3/images/ #####
##### /v3/images/{id} #####
##### /V3/search/images #####
##### /search/images/creative #####
##### /search/images/editorial #####


***TODO***

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


 


