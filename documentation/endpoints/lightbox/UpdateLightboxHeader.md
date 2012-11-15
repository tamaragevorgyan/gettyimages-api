UpdateLightboxHeader
-------------
The UpdateLightboxHeader operation allows you to update the lightbox header details that were specified when the lightbox was created.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/lightbox/UpdateLightboxHeader


###Request
The UpdateLightboxHeader JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "UpdateLightboxHeaderRequestBody": {
		"LightboxId": int,
		"LightboxName": "",
		"ClientName": "",
		"ProjectName": "",
		"Notes": ""
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by CreateSession or CreateApplicationSession.   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####UpdateLightboxHeaderRequestBody Fields
The UpdateLightboxHeaderRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																					|
|:--------------|:----------|:----------|:----------------------------------------------------------------------------------------------|
| LightboxId	| int 		| Required 	| ID of the lightbox to update.																	|
| LightboxName	| String 	| Required 	| Name of the lightbox. Note that the name is not required to be unique.						|
| ClientName	| String 	| Optional 	| Name of the client that the lightbox is created for. Optional.							|
| ProjectName	| String 	| Optional 	| Name of the project the lightbox is for. Optional.											|
| Notes			| String 	| Optional 	| Notes for further description of the lightbox and its contents. Optional.						|


###Response
The UpdateLightboxHeader JSON response has this format:

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
2. Call CreateLightbox with the authentication token to create a new blank lightbox. Note the Lightbox ID in the response.
3. Call UpdateLightboxHeader with the lightbox ID in Step 2 with the new values for it's header.


