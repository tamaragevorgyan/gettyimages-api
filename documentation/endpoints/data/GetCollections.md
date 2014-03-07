GetCollections
-------------
The GetCollections call retrieves a list of collections that are specific to your user name.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/data/GetCollections


###Request
The GetCollections JSON request has this format:

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
The GetCollections JSON response has this format:

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
	  "GetCollectionsResult": {
	    "Collections": [
		  {
		    "Name": "",
		    "ImageFamily": "",
		    "LicenseType": "",
		    "Id": int,
		    "ProductOfferings": [""]
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


####GetCollectionsResult Fields
The GetCollectionsResult contains the response data.

| Field                | Type        | Description																											 	 |
|:---------------------|:------------|:--------------------------------------------------------------------------------------------------------------------------|
| Collections	       	   | Collection  | Contains a list of _Collection_ results for the query.							                                             |
| Collection _entry_   		| Object	| The Collection object that contains the name, image family, licence type, id, and product offerings of the collection.  				 |
| _Collection_.Name	| String    | Contains the name of the collection. 															 |
| _Collection_.ImageFamily | String    | Contains the image family of the collection. Example: "Creative".    |
| _Collection_.LicenseType 	| String    | Contains the abbreviation of the license type for the collection. Example: "RF". 														 |
| _Collection_.Id 	| Int    | Contains id of the collection. Example: 100. 														 |
| _Collection_.ProductOfferings 	| Collection    | Contains a list of product offerings to which the collection belongs. Possible values are: <br>• PremiumAccess <br>• EasyAccess <br>• EditorialSubscription <br>• RoyaltyFreeSubscription <br>• ImagePack|


###Workflow Example
1. Call [CreateSession][] to create an authentication token.
2. Call GetCollections to get a list of collections that are specific to your user name.

[StatusCodes]: ../../appendix/StatusCodes.md
[CreateCustomer]: ../account/CreateCustomer.md
[CreateSession]: ../session/CreateSession.md
[CreateApplicationSession]: ../session/CreateApplicationSession.md
[GetCountries]: ../data/GetCountries.md
[GetCollections]: ../data/GetCollections.md
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


