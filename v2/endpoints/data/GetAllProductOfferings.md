GetAllProductOfferings
-------------
The GetAllProductOfferings operation returns a list of all royalty free product offerings (i.e. Image Pack and Subscription), including expired and fulfilled products, given a session token. Product offerings are based on the user specified in the CreateSession call.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/data/GetAllProductOfferings


###Request
The GetAllProductOfferings JSON request has this format:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by [CreateSession][].   | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

###Response
The GetAllProductOfferings JSON response has this format:

	{
	  "ResponseHeader": {
	    "Status": "success",
	    "StatusList": []
	  },
	  "GetAllProductOfferingsResult": {
	    "ProductOfferings": [
	      {
	        "ProductOfferingInstanceId": int,
	        "ApplicationWebsite": "",
	        "ProductOfferingType": "",
	        "Name": "",
	        "DownloadLimit": int,
	        "DownloadLimitDuration": "",
	        "Status": "",
	        "ExpirationUtc": "",
	        "DownloadsRemaining": int,
	        "DownloadLimitResetUtc": "" 
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
| _Status_.Code    | String      | Identifies the category of the status notification. See [StatusCodes][] for explanations of the codes.        				 |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |


####GetAllProductOfferingsResult Fields
The GetAllProductOfferingsResult contains the response data.

| Field                			              | Type        | Description																																																															| Usage				|
|:--------------------------------------------|:------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|
| ProductOfferings				              | Collection	| List of ProductOffering objects						.																																																				| All				|
| ProductOffering _entry_		              | Object 		| ProductOffering object which contains the descriptive metadata for the product offering. 																																												| All				|
| _ProductOffering_.ProductOfferingInstanceId | int			| Unique ID of the product offering instance.																																																							| All				|
| _ProductOffering_.ApplicationWebsite		  | string		| The name of the application for which the product was ordered.																																																		| All				|
| _ProductOffering_.ProductOfferingType		  | string 		| Type of product offering. Possible values are: <br>• ImagePack <br>• Subscription 																																													| All				|
| _ProductOffering_.Name					  | string		| Name of the product offering.																																																											| All				|
| _ProductOffering_.DownloadLimit			  | int			| The maximum number of downloads allowed against this product.																																																			| All				|
| _ProductOffering_.DownloadLimitDuration	  | string		| The time duration to which the download limit applies.																																																				| Subscription Only |
| _ProductOffering_.Status					  | string		| Status of the product offering. Possible values are: <br>•  Active <br>•  Cancelled <br>•  Expired <br>•  Fulfilled [ImagePack only] <br>•  Inactive [Subscription Only] <br>•  Pending [Subscription Only] <br>•  Suspended <br>•  Unspecified <br>•  Unsupported	| All				|
| _ProductOffering_.ExpirationUtc 			  | string		| Date the product expires																																																												| All				|
| _ProductOffering_.DownloadsRemaining		  | int			| The number of downloads remaining for the product																																																						| All				|
| _ProductOffering_.DownloadLimitResetUtc	  | string		| Date and time	that the DownloadsRemaining will reset to the DownloadLimit																																																| Subscription Only |

###Workflow Example
1. Call [CreateSession][] to create an authentication token.
2. Call GetAllProductOfferings to get a list of all royalty free product offerings for the user.


[StatusCodes]: ../../appendix/StatusCodes.md
[CreateCustomer]: ../account/CreateCustomer.md
[CreateSession]: ../session/CreateSession.md
[CreateApplicationSession]: ../session/CreateApplicationSession.md
[GetCountries]: ../data/GetCountries.md
[CreateLightboxItems]: ../lightbox/CreateLightboxItems.md
[DeleteLightboxItems]: ../lightbox/DeleteLightboxItems.md
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


