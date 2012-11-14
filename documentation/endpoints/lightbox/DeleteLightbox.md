DeleteLightbox
-------------
The DeleteLightbox operation allows a user to delete a lightbox they have created.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/lightbox/DeleteLightbox


###Request
The DeleteLightbox JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "DeleteLightboxRequestBody": {
		"LightboxId": int
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by CreateSession or CreateApplicationSession.   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####DeleteLightboxRequestBody Fields
The DeleteLightboxRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																	|
|:--------------|:----------|:----------|:------------------------------------------------------------------------------|
| LightboxId	| int 		| Required 	| ID of the lightbox to delete.													|


###Response
The DeleteLightbox JSON response has this format:

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
| _Status_.Code    | String      | Identifies the category of the status notification. See [Status Codes](#statuscodes) for an explanations of the codes.        |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |


###Workflow Example
1. Call CreateSession to create an authentication token.
2. Call CreateLightbox to create a new lightbox. Note the ID that was returned in the response of this operation.
3. Call DeleteLightbox with the lightbox ID that was returned in Step 2 to delete it.


