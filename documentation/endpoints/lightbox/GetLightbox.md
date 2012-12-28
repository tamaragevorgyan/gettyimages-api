GetLightbox
-------------
The GetLightbox operation allows you to retrieve a single lightbox by ID along with specifying item view options.
Note that while creating a lightbox requires a user authentication token, this call can be made with an anonymous token created by calling [CreateApplicationSession][].

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/lightbox/GetLightbox


###Request
The GetLightbox JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "GetLightboxRequestBody": {
		"LightboxId": int,
		"LightboxItemsViewOptions": {
		  "ItemCount": int,
		  "ItemStartNumber": int
		}
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by [CreateSession][] or [CreateApplicationSession][].   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####GetLightboxRequestBody Fields
The GetLightboxRequestBody contains the request arguments.

| Field 							| Type			| Use 	 	| Description 																	|
|:----------------------------------|:--------------|:----------|:------------------------------------------------------------------------------|
| LightboxId						| int 			| Required 	| The unique ID of the lightbox to retrieve.									|
| LightboxItemsViewOptions 			| Object		| Required 	| Contains the options the user has for viewing the return data for Items.		|
| _LightboxItemsViewOptions_.ItemCount | int 		| Required 	| Number of Items to return for this query, can be used for paging. 			|
| _LightboxItemsViewOptions_.ItemStartNumber | int 	| Required	| Number to start retrieval of Items in the lightbox, can be used for paging.	|


###Response
The GetLightbox JSON response has this format:

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
	  "GetLightboxResult": {
		"Lightbox": {
		  "LightboxHeader": {
			"LightboxId": "",
			"LightboxName": "",
			"ClientName": "",
			"ProjectName": "",
			"DateCreated": "",
			"DateModified": "",
			"LightboxItemCount": "",
			"LightboxUrl": "",
			"Notes": ""
		  },
		  "LightboxItems": [ 
		    {
			  "AssetId": "",
			  "Comment": "",
			  "DateCreated": "",
			  "DateModified": "",
			  "ItemPosition": int,
			  "LightboxItemId": int,
			  "Urls": {
				"Preview": "",
				"SmallThumb": "",
				"Thumb": "",
				"WatermarkPreview": ""
			  }
		    }
		  ]
		}
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


####GetLightboxResult Fields
The GetLightboxResult contains the response data.

| Field                			| Type        	| Description																			|
|:------------------------------|:--------------|:--------------------------------------------------------------------------------------|
| Lightbox 						| Object 		| The object containing all of the data for a lightbox									|
| LightboxHeader 				| Object 		| LightboxHeader object which contains the descriptive metadata for the lightbox. 		|
| _LightboxHeader_.LightboxId	| string		| Unique ID of the lightbox.															|
| _LightboxHeader_.LightboxName	| string		| Name of the lightbox. Note that the name is not required to be unique.				|
| _LightboxHeader_.ClientName	| Object 		| Name of the client the lightbox is for.  												|
| _LightboxHeader_.ProjectName	| string		| Name of the project the lightbox is for.												|
| _LightboxHeader_.DateCreated	| string		| Date that the lightbox was created.													|
| _LightboxHeader_.DateModified	| string		| Date that the lightbox was last modified.												|
| _LightboxHeader_.LightboxItemCount | string	| Count of items that the lightbox contains.											|
| _LightboxHeader_.LightboxUrl	| string		| URL that will show the user interface for the lightbox.								|
| _LightboxHeader_.Notes		| string		| Notes for further description of the lightbox and its contents.						|
| LightboxItems 				| Collection 	| List of Items in the lightbox.    													|
| LightboxItem _entry_			| Object 		| Object containing metadata about the lightbox Item.									|
| _LightboxItem_.AssetId		| string 		| Original ID of the Item.																|
| _LightboxItem_.Comment		| string 		| Contains any comments that have been made on the Item.								|
| _LightboxItem_.DateCreated	| string 		| Date that the Item was added to the lightbox. 										|
| _LightboxItem_.DateModified	| string 		| Date that the item was last modified in this lightbox.								|
| _LightboxItem_.ItemPosition	| string 		| Position in the list of items in the lightbox.										|
| _LightboxItem_.LightboxItemId	| string 		| ID of this object, the instance of this Item in the lightbox.							|
| _LightboxItem_.Urls			| Object 		| Object containing the URLs related to the Item.										|
| _LightboxItem_._Urls_.Preview	| string 		| URL for the preview of the item.														|
| _LightboxItem_._Urls_.SmallThumb | string 	| URL for the small thumbnail image for the item.										|
| _LightboxItem_._Urls_.Thumb 	| string 		| URL for the thumbnail image for the item.												|
| _LightboxItem_._Urls_.WatermarkPreview | string | URL for the preview of the item with a watermark.									|


###Workflow Example
1. Call [CreateSession][] or [CreateApplicationSession][] to create an authentication token.
2. Call [CreateLightbox][] with the authentication token to create a new blank lightbox or call [GetLightboxHeaders][] to find ID of existing lightbox.
3. Call GetLightbox with the ID of the lightbox identified in Step 2.


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

