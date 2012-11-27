CreateCustomer
-------------
The CreateCustomer call creates a new customer in the Getty Images system. 
Note that the new user created by the CreateCustomer operation is created with marketing email opt-out selected. 
Also, this operation supports being called with an anonymous system Token created by [CreateApplicationSession][].

This operation is not publicly available at this time. Please contact your Getty Images Account Manager if you need more information.

###Endpoint
Use the following endpoint to access this operation:

	https://connect.gettyimages.com/v1/account/CreateCustomer
	
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
| Token          | String      | Required     | Specify the authentication token provided by [CreateSession][] or [CreateApplicationSession][].   | 
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
| BillingCountryChar3Iso | String | Required | Specifies the 3 character Country Code for Billing. Note that valid values for this field can be retrieved via the [GetCountries][] operation. |

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

| Field            | Type        | Description                                                                                                                   |
|:-----------------|:------------|:------------------------------------------------------------------------------------------------------------------------------|
| Status           | String      | Indicates the overall operation processing status notification. Possible values are: <br>� Success <br>� Error <br>� Warning  | 
| StatusList       | Collection  | Contains a _Status_ entry for each detailed processing status notification.                                                   |
| Status _entry_   | Object      | Contains the details of a status notification                                                                                 |
| _Status_.Type    | String      | Indicates the type, or severity, of the status notification. Possible values are: <br>� Information <br>� Warning <br>� Error |
| _Status_.Code    | String      | Identifies the category of the status notification. See [StatusCodes][] for explanations of the codes.   				     |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |


###Workflow Example
1. Call either [CreateSession][] or [CreateApplicationSession][] to create an authentication token.
2. Call CreateCustomer via HTTPS and using the authentication token to create a new Customer with provided values.



[StatusCodes]: ../../appendix/StatusCodes.md
[CreateCustomer]: ../account/CreateCustomer.md
[CreateSession]: ../session/CreateSession.md
[CreateApplicationSession]: ../session/CreateApplicationSession.md
[GetCountries]: ../data/GetCountries.md
[AddItemsToLightbox]: ../lightbox/AddItemsToLightbox.md
[DeleteItemsFromLightbox]: ../lightbox/DeleteItemsFromLightbox.md
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

