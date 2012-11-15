GetLightboxHeaders
-------------
The GetLightboxHeaders operation allows you to retrieve the Header data for multiple lightboxes.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/lightbox/GetLightboxHeaders


###Request
The GetLightboxHeaders JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "GetLightboxHeadersRequestBody": {
		"ResultsViewOptions": {
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

####GetLightboxHeadersRequestBody Fields
The GetLightboxHeadersRequestBody contains the request arguments.

| Field 							| Type		| Use 	 	| Description 																	|
|:----------------------------------|:----------|:----------|:------------------------------------------------------------------------------|
| ResultsViewOptions 				| Object	| Required 	| 										|
| _ResultsViewOptions_.ItemCount 	| int 		| Required 	| 										|
| _ResultsViewOptions_.ItemStartNumber | int	| Required	| 										|


###Response
The GetLightboxHeaders JSON response has this format:

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
	  "GetLightboxHeadersResult": {
		"LightboxHeaders": [ 
		  {
			"LightboxId": "",
			"LightboxName": "",
			"ClientName": "",
			"ProjectName": "",
			"DateCreated": "",
			"DateModified": "",
			"LightboxItemCount": "",
			"LightboxUrl": "",
			"Notes": ""
		  }
		],
		"TotalLightboxHeaderCount": int
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

####GetLightboxHeadersResult Fields
The GetLightboxHeadersResult contains the response data.

| Field                			| Type        	| Description																			|
|:------------------------------|:--------------|:--------------------------------------------------------------------------------------|
| LightboxHeaders				| Collection	| List of LightboxHeader objects representing a lightbox.								|
| LightboxHeader _entry_		| Object 		| LightboxHeader object which contains the descriptive metadata for the lightbox. 		|
| _LightboxHeader_.LightboxId	| string		| Unique ID of the lightbox.															|
| _LightboxHeader_.LightboxName	| string		| Name of the lightbox. Note that the name is not required to be unique.				|
| _LightboxHeader_.ClientName	| Object 		| Name of the client the lightbox is for.  												|
| _LightboxHeader_.ProjectName	| string		| Name of the project the lightbox is for.												|
| _LightboxHeader_.DateCreated	| string		| Date that the lightbox was created.													|
| _LightboxHeader_.DateModified	| string		| Date that the lightbox was last modified.												|
| _LightboxHeader_.LightboxItemCount | string	| Count of items that the lightbox contains.											|
| _LightboxHeader_.LightboxUrl	| string		| URL that will show the user interface for the lightbox.								|
| _LightboxHeader_.Notes		| string		| Notes for further description of the lightbox and its contents.						|



###Workflow Example
1. Call either CreateSession or CreateApplicationSession to create an authentication token.
2. Call CreateLightbox with the authentication token to create a new blank lightbox.
2. Call GetLightboxHeaders 


