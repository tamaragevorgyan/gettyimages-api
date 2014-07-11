GetActiveProductOfferings
-------------
The GetActiveProductOfferings operation returns a list of active product offering types (i.e. PremiumAccess, EasyAccess, EditorialSubscription) given a session token. Product offerings are based on the user specified in the CreateSession call.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/data/GetActiveProductOfferings


###Request
The GetActiveProductOfferings JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by [CreateSession][].   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

###Response
The GetActiveProductOfferings JSON response has this format:

	{
	  "ResponseHeader": {
	    "Status": "",
	    "StatusList": [],
	    "CoordinationId": ""
	  },
	  "GetActiveProductOfferingsResult": {
	    "ActiveProductOfferings": [
	    	""
	    ]
	  }
	}

####ResponseHeader Fields
The ResponseHeader contains metadata about the operation execution and response.

| Field            | Type        | Description                                                                                                                   |
|:-----------------|:------------|:------------------------------------------------------------------------------------------------------------------------------|
| Status           | String      | Indicates the overall operation processing status notification. Possible values are: <br>• Success <br>• Error <br>• Warning  | 
| StatusList       | Collection  | Contains a _Status_ entry for each detailed processing status notification.                                                   |
| Status _entry_   | Object      | Contains the details of a status notification                                                                                 |
| _Status_.Type    | String      | Indicates the type, or severity, of the status notification. Possible values are: <br>• Information <br>• Warning <br>• Error |
| _Status_.Code    | String      | Identifies the category of the status notification. See [StatusCodes][] for explanations of the codes.        				 |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |


####GetActiveProductOfferingsResult Fields
The GetActiveProductOfferingsResult contains the response data.

| Field                		| Type        | Description																		  |
|:--------------------------|:------------|:----------------------------------------------------------------------------------|
| ActiveProductOfferings 	| Collection  | Contains a list of product offerings for the user specified in [CreateSession][]. Possible values are: <br>• PremiumAccess <br>• EasyAccess <br>• EditorialSubscription|


###Workflow Example
1. Call [CreateSession][] to create an authentication token.
2. Call GetActiveProductOfferings to get a list of active product offerings for the user.


[StatusCodes]: ../../appendix/StatusCodes.md
[CreateCustomer]: ../account/CreateCustomer.md
[CreateSession]: ../session/CreateSession.md
[CreateApplicationSession]: ../session/CreateApplicationSession.md
[GetCountries]: ../data/GetCountries.md
[CreateLightboxItems]: ../lightbox/CreateLightboxItems.md
[DeleteLightboxItems]: ../lightbox/DeleteLightboxItems.md
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


