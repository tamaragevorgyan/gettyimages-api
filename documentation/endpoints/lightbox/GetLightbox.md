GetLightbox
-------------
The GetLightbox operation allows you to retrieve a single lightbox by ID along with specifying item view options.

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
| Token          | String      | Required     | Specify the authentication token provided by CreateSession or CreateApplicationSession.   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####GetLightboxRequestBody Fields
The GetLightboxRequestBody contains the request arguments.

| Field 							| Type			| Use 	 	| Description 																	|
|:----------------------------------|:--------------|:----------|:------------------------------------------------------------------------------|
| LightboxId						| int 			| Required 	| 										|
| LightboxItemsViewOptions 			| Object		| Required 	| 										|
| _LightboxItemsViewOptions_.ItemCount | int 		| Required 	| 										|
| _LightboxItemsViewOptions_.ItemStartNumber | int 	| Required	| 										|


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
| _Status_.Code    | String      | Identifies the category of the status notification. See [Status Codes](#statuscodes) for an explanations of the codes.        |
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
| LightboxItems 				| Collection 	|     	|
| LightboxItem _entry_			| Object 		| 		|
| _LightboxItem_.AssetId		| string 		| 		|
| _LightboxItem_.Comment		| string 		| 		|
| _LightboxItem_.DateCreated	| string 		| 		|
| _LightboxItem_.DateModified	| string 		| 		|
| _LightboxItem_.ItemPosition	| string 		| 		|
| _LightboxItem_.LightboxItemId	| string 		| 		|
| _LightboxItem_.Urls			| Object 		| 		|
| _LightboxItem_._Urls_.Preview	| string 		| 		|
| _LightboxItem_._Urls_.SmallThumb | string 	| 		|
| _LightboxItem_._Urls_.Thumb 	| string 		| 		|
| _LightboxItem_._Urls_.WatermarkPreview | string | 		|


###Workflow Example
1. Call either CreateSession or CreateApplicationSession to create an authentication token.
2. Call CreateLightbox with the authentication token to create a new blank lightbox.
2. Call GetLightbox with the 


