CreateApplicationSession
-------------
The CreateApplicationSession call starts a Getty Images Connect API anonymous application session via HTTPS.

###Endpoint
Use the following endpoint to access this operation:

	https://connect.gettyimages.com/v1/session/CreateApplicationSession

Note that this call must be made with the HTTPS protocol.
	
###Request
The CreateApplicationSession JSON request has this form:

	{
	  "RequestHeader": {
    	"Token": null,
    	"CoordinationId": null
  		},
  	  "CreateApplicationSessionRequestBody": {
    	"SystemId": "",
    	"SystemPassword": "",
  		}
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                                                   |
|:---------------|:------------|:-------------|:--------------------------------------------------------------------------------------------------------------|
| Token          | String      | Nil          | Unused for this operation. CreateApplicationSession and CreateSession are the only operations that do not require an authentication token. | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses.                     |

####CreateApplicationSessionRequestBody Fields
The CreateApplicationSessionRequestBody contains the request arguments.

| Field          | Type        | Use          | Description                                                                                               |
|:---------------|:------------|:-------------|:----------------------------------------------------------------------------------------------------------|
| SystemId       | String      | Required     | Specifies the numeric participant system ID assigned to you by Getty Images.                              | 
| SystemPassword | String      | Required     | Specifies the password associated with the specified participant system.                                  |

###Response
The CreateApplicationSession JSON response has this form:

	{
	    "ResponseHeader": {
	        "Status": "",
	        "StatusList": [],
	        "CoordinationId": ""
	    },
	    "CreateApplicationSessionResult": {
	        "Token": "",
	        "TokenDurationMinutes": int
	    }
	}

####ReponseHeader Fields
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

####CreateApplicationSessionResult Fields
The CreateApplicationSessionResult contains these fields.

| Field                | Type        | Description																														|
|:---------------------|:------------|:---------------------------------------------------------------------------------------------------------------------------------|
| Token                | String      | Provides a system authentication token for use with anonymous operations.														|
| TokenDurationMinutes | int      	 | Indicates for how many minutes the token is valid. Use the endpoint, RenewSession operation, to extend the duration of a token.	|	

###Workflow Example
1. Call CreateApplicationSession with your system ID and password in order to receive a application token for use in operations allowing anonymous authentication.