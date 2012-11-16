AddItemsToLightbox
-------------
The AddItemsToLightbox operation allows you to add items to a specific lightbox. These items can be any of the supported types of assets; images, videos, etc.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/lightbox/AddItemsToLightbox


###Request
The AddItemsToLightbox JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "AddItemsToLightboxRequestBody": {
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
| Token          | String      | Required     | Specify the authentication token provided by CreateSession or CreateApplicationSession.   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####AddItemsToLightboxRequestBody Fields
The AddItemsToLightboxRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																	|
|:--------------|:----------|:----------|:------------------------------------------------------------------------------|
| LightboxId	| int 		| Required 	| The ID of the Lightbox you wish to add items to.								|
| AssetIds		| Collection | Required	| List of strings that contain Asset IDs of items to put in the lightbox.		|


###Response
The AddItemsToLightbox JSON response has this format:

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

[statuscodes]: ../../appendix/StatusCodes.md

###Workflow Example
1. Call [CreateSession] to create an authentication token.
2. Call CreateLightbox to create a new blank lightbox.
3. Search for items to add to the lightbox (Example: SearchForImages), note the Asset IDs of the items you want in your lightbox.
4. Call AddItemsToLightbox with the ID from step 2 and the AssetIds from step 3 to populate your lightbox.


