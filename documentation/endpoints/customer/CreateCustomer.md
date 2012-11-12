CreateCustomer
-------------
The Create Customer call creates a new customer in the Getty Images system. Note that the new user created by the CreateCustomer operation is created with marketing email opt-out selected.

###Endpoint
Use the following endpoint to access this operation:

	https://connect.gettyimages.com/v1/CreateCustomer
	
Note that this call must be made with the HTTPS protocol.

###Request
The CreateCustomer JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "CreateCustomerRequestBody": {
		"UserName": "",
		"Password": "",
		"EmailAddress": "",
		"FirstName": "",
		"LastName": "",
		"MiddleName": "",
		"BillingCountryChar3Iso": ""
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by CreateSession or CreateApplicationSession.   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####CreateCustomerRequestBody Fields
The CreateCustomerRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																	|
|:--------------|:----------|:----------|:------------------------------------------------------------------------------|
| UserName  	| String 	| Required 	| UserName for the customer to log in with. This must be a unique name.			|
| Password  	| String 	| Required 	| Password for the customer's login. This password cannot be the same as the UserName field and must be longer than 3 characters.	|
| EmailAddress  | String 	| Required 	| Email address for the customer.												|
| FirstName     | String 	| Required 	| First name of the customer. 													|
| LastName  	| String 	| Required 	| Last name of the customer.													|
| MiddleName	| String 	| Optional 	| Middle name of the customer. Optional.										|
| BillingCountryChar3Iso | String | Required	| Specifies the 3 character Country Code for Billing. 					|

###Response
The CreateCustomer JSON response has this format:

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

| Field         | Type      | Description                                                                                                   |
|:--------------|:----------|:--------------------------------------------------------------------------------------------------------------|
| Status		| String	| Indicates the overall operation processing status notification. Possible values are: <br>• Success <br>• Error <br>• Warning|
| StatusList	| Collecton	| Contains a Status entry for each detailed processing status notification.										|
| Status entry	| Object	| Contains the details of a status notification.																|
| _Status_.Type	| String	| Indicates the type, or severity, of the status notification. Possible values are: <br>• Information <br>• Warning <br>• Error|
| _Status_.Code	| String	| Identifies the category of the status notification. See Status Codes for an explanations of codes.			|
| _Status_.Message| String	| Provides a human readable explanation of the status.															|
| CoordinationId| String	| Indicates the CoordinationId value provided in the triggering request.										|

###Workflow Example
1. Call either CreateSession or CreateApplicationSession to create an authentication token.
2. Call CreateCustomer via HTTPS and using the authentication token to create a new Customer with provided values.




