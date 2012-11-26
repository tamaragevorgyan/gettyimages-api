DeleteItemsFromLightbox
-------------
The DeleteItemsFromLightbox operation allows you to delete items from a specific lightbox. These items can be any of the supported types of assets; images, videos, etc. 
Note that these items do not get deleted from the Getty Images system, just removed from the list of items in your lightbox. This operation should only be called by the owner of the lightbox.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/lightbox/DeleteItemsFromLightbox


###Request
The DeleteItemsFromLightbox JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "DeleteItemsFromLightboxRequestBody": {
		"LightboxId": int,
		"AssetIds": [
		  ""
		]
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by [CreateSession][].   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####DeleteItemsFromLightboxRequestBody Fields
The DeleteItemsFromLightboxRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																		|
|:--------------|:----------|:----------|:----------------------------------------------------------------------------------|
| LightboxId	| int 		| Required 	| The ID of the Lightbox you wish to remove items from.								|
| AssetIds		| Collection | Required	| List of strings that contain Asset IDs of items to remove from the lightbox.		|


###Response
The DeleteItemsFromLightbox JSON response has this format:

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
| _Status_.Code    | String      | Identifies the category of the status notification. See [StatusCodes][] for explanations of the codes.        |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |


###Workflow Example
1. Call [CreateSession][] to create an authentication token.
2. Call [CreateLightbox][] to create a new blank lightbox or call [GetLightboxHeaders][] to find ID of existing lightbox.
3. Search for items to add to the lightbox (Example: [SearchForImages][]), note the Asset IDs of the items you want in your lightbox.
4. Call [AddItemsToLightbox][] with the lightbox ID from step 2 and the Asset IDs from step 3 to populate your lightbox.
5. Call [GetLightbox][] and note Asset IDs within the LightboxItem collection for an item to remove from the lightbox.
6. Call DeleteItemsFromLightbox with the lightbox ID from step 2 and the Asset IDs from step 5 to remove unwanted items from your lightbox.

[StatusCodes]: ../../appendix/StatusCodes.md
[CreateCustomer]: ../account/CreateCustomer.md
[CreateSession]: ../session/CreateSession.md
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
