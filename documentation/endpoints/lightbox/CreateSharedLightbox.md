CreateSharedLightbox
-------------
The CreateSharedLightbox operation is only availalbe to applications working with the Thinkstock product. If you are unsure of your status, please contact us via our API site. 

The CreateSharedLightbox call creates a copy of an existing lightbox (that the user owns) in order to share the contents of the lightbox with other users. Note that the shared lightbox that is created from this operation is read-only and can no longer be edited by any user.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/lightbox/CreateSharedLightbox


###Request
The CreateSharedLightbox JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "CreateSharedLightboxRequestBody": {
		"LightboxId": int
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by [CreateSession][]. 							  | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####CreateSharedLightboxRequestBody Fields
The CreateSharedLightboxRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																					|
|:--------------|:----------|:----------|:----------------------------------------------------------------------------------------------|
| LightboxId	| Int	 	| Required 	| ID of the lightbox to copy into a Shared Lightbox. The current user must own this lightbox.	|

###Response
The CreateSharedLightbox JSON response has this format:

	{
	  "ResponseHeader": {
	    "Status": "",
	    "StatusList": [
	      {
	        "Type": "",
	        "Code": "",
	        "Message": ""
	      }
	    ],
	    "CoordinationId": ""
	  },
	  "CreateSharedLightboxResult": {
		"SharedLightboxId": int
	  }
	}

####ResponseHeader Fields
The ResponseHeader contains metadata about the operation execution and response.

| Field            | Type        | Description                                                                                                                   |
|:-----------------|:------------|:------------------------------------------------------------------------------------------------------------------------------|
| Status           | String      | Indicates the overall operation processing status notification. Possible values are: <br>� Success <br>� Error <br>� Warning  | 
| StatusList       | Collection  | Contains a _Status_ entry for each detailed processing status notification.                                                   |
| Status _entry_   | Object      | Contains the details of a status notification                                                                                 |
| _Status_.Type    | String      | Indicates the type, or severity, of the status notification. Possible values are: <br>� Information <br>� Warning <br>� Error |
| _Status_.Code    | String      | Identifies the category of the status notification. See [StatusCodes][] for explanations of the codes.        |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |


####CreateSharedLightboxResult Fields
The CreateSharedLightboxResult contains the response data.

| Field          | Type        | Description																											 	 		|
|:---------------|:------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| SharedLightboxId | Int       | The ID of the Shared Lightbox that was created by the request.									|


###Workflow Example
1. Call [CreateSession][] to create an authentication token.
2. Call [CreateLightbox][] to create a new blank lightbox or call [GetLightboxHeaders][] to find ID of existing lightbox.
3. Search for items to add to the lightbox (Example: [SearchForImages][]), note the Asset IDs of the items you want in your lightbox.
4. Call [CreateLightboxItems][] with the lightbox ID from step 2 and the AssetIds from step 3 to populate your lightbox.
5. Call CreateSharedLightbox with the lightbox ID from step 2 to create a shared lightbox that is a copy of the original lightbox.


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
