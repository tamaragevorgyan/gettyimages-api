GetCountries
-------------
The GetCountries call retrieves a list of countries that are valid for the given language code.
This operation supports being called with an anonymous system Token created by [CreateApplicationSession].

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/data/GetCountries


###Request
The GetCountries JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "GetCountriesRequestBody": {
		"Language": ""
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by CreateSession or CreateApplicationSession.   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####GetCountriesRequestBody Fields
The GetCountriesRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																	|
|:--------------|:----------|:----------|:------------------------------------------------------------------------------|
| Language		| String 	| Optional 	| Language code for which to retrieve Countries for. Defaults to "en-US".		|


###Response
The GetCountries JSON response has this format:

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
	  "GetCountriesResult": {
	    "Countries": [
		  {
		    "CountryChar2ISO": "",
		    "CountryChar3ISO": "",
		    "CountryName": ""
		  }
	    ]
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


####GetCountriesResult Fields
The GetCountriesResult contains the response data.

| Field                | Type        | Description																											 	 |
|:---------------------|:------------|:--------------------------------------------------------------------------------------------------------------------------|
| Countries	       	   | Collection  | Contains a list of _Country_ results for the query.							                                             |
| Country _entry_   		| Object	| The Country object that contains two and three character country codes as well as name of the country.  				 |
| _Country_.CountryChar2ISO	| String    | Contains the two character ISO Country Code. Example: "US". 															 |
| _Country_.CountryChar3ISO | String    | Contains the three character ISO Country Code, which can be used in the [CreateCustomer] operation. Example: "USA".    |
| _Country_.CountryName 	| String    | Contains the full name of the country. Example: "United States". 														 |


###Workflow Example
1. Call either CreateSession or CreateApplicationSession to create an authentication token.
2. Call GetCountries to get the countries that are valid for the preferred language code.




