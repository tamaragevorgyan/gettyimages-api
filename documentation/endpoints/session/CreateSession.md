CreateSession
-------------
The CreateSession call starts a Getty Images Connect API session via HTTPS.

###Endpoint
Use the following endpoint to access this operation:

	https://connect.gettyimages.com/v1/session/CreateSession

###Request
The CreateSession JSON request has this form:

	{
	  "RequestHeader": {
    	"Token": null,
    	"CoordinationId": null
  		},
  	  "CreateSessionRequestBody": {
    	"SystemId": "",
    	"SystemPassword": "",
    	"UserName": "",
    	"UserPassword": "",
  		}
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                                                   |
|:---------------|:------------|:-------------|:--------------------------------------------------------------------------------------------------------------|
| Token          | String      | Nil          | Unused for this operation. CreateSession is the only operation that does not require an authentication token. | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses.                     |

####CreateSessionRequestBody Fields
The CreateSessionRequestBody contains the request arguments.

| Field          | Type        | Use          | Description                                                                                               |
|:---------------|:------------|:-------------|:----------------------------------------------------------------------------------------------------------|
| SystemId       | String      | Required     | Specifies the participant system ID assigned to you by Getty Images.                                      | 
| SystemPassword | String      | Required     | Specifies the password associated with the specified participant system.                                  |
| UserName       | String      | Required     | Specify the username of a GettyImages.com user you are making requests on the behalf of.                  |
| UserPassword   | String      | Required     | Specify the password associated with the specified user. Only required when you have set the UserId field.|

###Response
The CreateSession JSON response has this form:

	{
	    "ResponseHeader": {
	        "Status": "",
	        "StatusList": [],
	        "CoordinationId": ""
	    },
	    "CreateSessionResult": {
	        "SecureToken": "",
	        "Token": "",
	        "TokenDurationMinutes": int
	    }
	}

####ReponseHeader Fields
The ResponseHeader contains metadata about the operation execution and 
response.

| Field            | Type        | Description                                                                                                                   |
|:-----------------|:------------|:------------------------------------------------------------------------------------------------------------------------------|
| Status           | String      | Indicates the overall operation processing status notification. Possible values are: <br>• Success <br>• Error <br>• Warning  | 
| StatusList       | Collection  | Contains a _Status_ entry for each detailed processing status notification.                                                   |
| Status _entry_   | Object      | Contains the details of a status notification                                                                                 |
| _Status_.Type    | String      | Indicates the type, or severity, of the status notification. Possible values are: <br>• Information <br>• Warning <br>• Error |
| _Status_.Code    | String      | Identifies the category of the status notification. See [StatusCodes][] for an explanations of the codes.        |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |

####CreateSessionResult Fields
The CreateSessionResult contains these fields.

| Field                | Type        | Description																														|
|:---------------------|:------------|:---------------------------------------------------------------------------------------------------------------------------------|
| AccountId            | String      | Identifies the account associated with the provided credentials.																	| 
| SecureToken          | String      | Provides a secure authentication token. For use only with secure operations via HTTPS. 											|
| Token                | String      | Provides a standard authentication token for use with standard operations.														|
| TokenDurationMinutes | String      | Indicates for how many minutes the token is valid. Use the endpoint, [RenewSession][] operation, to extend the duration of a token.	|	



[StatusCodes]: ../../appendix/StatusCodes.md
[CreateCustomer]: ../account/CreateCustomer.md
[CreateSession]: ../session/CreateSession.md
[RenewSession]: ../session/RenewSession.md
[CreateApplicationSession]: ../session/CreateApplicationSession.md
[GetCountries]: ../data/GetCountries.md
[AddItemsToLightbox]: ../lightbox/AddItemsToLightbox.md
[DeleteItemsFromLightbox]: ../lightbox/DeleteItemsFromLightbox.md
[CreateLightbox]: ../lightbox/CreateLightbox.md
[DeleteLightbox]: ../lightbox/DeleteLightbox.md
[GetLightbox]: ../lightbox/GetLightbox.md
[GetLightboxHeaders]: ../lightbox/GetLightboxHeaders.md
[UpdateLightboxHeader]: ../lightbox/UpdateLightboxHeader.md
[CreateDownloadRequest]: ../download/CreateDownloadRequest.md
[GetImageDownloadAuthorizations]: ../download/GetImageDownloadAuthorizations.md
[GetLargestImageDownloadAuthorizations]: ../download/GetLargestImageDownloadAuthorizations.md
[GetEventDetails]: ../search/GetEventDetails.md
[GetImageDetails]: ../search/GetImageDetails.md
[SearchForImages]: ../search/SearchForImages.md
[SearchForVideos]: ../search/SearchForVideos.md
