CreateLightbox
-------------
The CreateLightbox call creates a new empty lightbox for a user.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/lightbox/CreateLightbox


###Request
The CreateLightbox JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "CreateLightboxRequestBody": {
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

####CreateLightboxRequestBody Fields
The CreateLightboxRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																					|
|:--------------|:----------|:----------|:----------------------------------------------------------------------------------------------|
| LightboxName	| String 	| Required 	| Name of the lightbox. Note that the name is not required to be unique.						|
| ClientName	| String 	| Optional 	| Name of the client that the lightbox is being created for. Optional.							|
| ProjectName	| String 	| Optional 	| Name of the project the lightbox is for. Optional.											|
| Notes			| String 	| Optional 	| Notes for further description of the lightbox and its contents. Optional.						|


###Response
The CreateLightbox JSON response has this format:

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
	  "CreateLightboxResult": {
		"LightboxId": int
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


####CreateLightboxResult Fields
The CreateLightboxResult contains the response data.

| Field                | Type        | Description																											 	 |
|:---------------------|:------------|:--------------------------------------------------------------------------------------------------------------------------|
| LightboxId   	   | int         | The ID of the lightbox that was created by the request. This ID is required in order to perform other operations on the lightbox.	|


###Workflow Example
1. Call either CreateSession to create an authentication token.
2. Call CreateLightbox with the authentication token to create a new blank lightbox.


