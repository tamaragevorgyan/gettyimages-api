CreateDownloadRequest
---------------------
The CreateDownloadRequest call returns download URLs and related data for 
images or videos the customer is authorized to download. It can only be called via HTTPS.

###Download Limits
Most product offerings have enforced periodic download limits such as monthly, 
weekly, and daily. When this operation executes, the count of allowed downloads is 
decremented by one for the product offering identified by the DownloadToken. Once 
the download limit is reached for a given product offering, no further downloads 
may be requested for that product offering until the next download period.

The download limit for a given download period is covered in your product 
agreement established with Getty Images.

###Endpoint
Use the following endpoint (HTTPS only) to access this operation:

	https://connect.gettyimages.com/v1/download/CreateDownloadRequest

###Request
The CreateDownloadRequest JSON request has this form:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "CreateDownloadRequestBody": {
	    "DownloadItems": [
	      {
	        "DownloadToken": ""
	      }
	    ]
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request..

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the secure authentication token provided by [CreateSession][].                        | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####CreateDownloadRequestBodyRequest Fields
The CreateDownloadRequestBodyRequest contains the request arguments.

| Field          				| Type 		| Use          | Description 																	|
|:------------------------------|:----------|:-------------|:-------------------------------------------------------------------------------|
| DownloadItems 				| Collection| Required     | Adds a DownloadItem entry for each image or video for which a download is requested. 	| 
| DownloadItem _entry_			| Object	| Required     | Contains download arguments. 													|
| _DownloadItem_.DownloadToken	| String	| Required     | Specifies the token authorizing the customer to download the image or video. Use the DownloadToken value provided by [GetLargestImageDownloadAuthorizations][] or [GetImageDownloadAuthorizations][] for image. Use the DownloadToken value provided by [SearchForVideos][] for video.|

###Response
The CreateDownloadRequest JSON response has this form:

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
	  "CreateDownloadRequestResult": {
	    "DownloadUrls": [
	      {
	        "ImageId": "",
	        "SizeName": "",
	        "Status": "",
	        "UrlAttachment": ""
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
| _Status_.Code    | String      | Identifies the category of the status notification. See [StatusCodes][] for an explanations of the codes.        |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |

####CreateDownloadRequestResult Fields
The CreateDownloadRequestResult contains these fields

| Field 						| Type 			| Description 																							|
|:------------------------------|:--------------|:------------------------------------------------------------------------------------------------------|
| DownloadUrls 					| Collection	| Contains a DownloadUrl entry for each image or video for which a download is requested.						|
| DownloadUrl _entry_ 			| Object		| Contains the details for downloading an image or video.														|
| _DownloadUrl_.ImageId 		| String		| Identifies the image or video. Note that video files will reference AssetId instead of ImageId.																					|
| _DownloadUrl_.SizeName 		| String		| Identifies size of the image or video that will be downloaded. Currently Null and will be renamed to SizeKey.	|
| _DownloadUrl_.Status 			| String		| Indicates the download availability of the image or video. Possible values are: <br>• NoAccess <br>• Success <br>• Unavailable <br>• ExpiredToken <br>• InvalidToken|
| _DownloadUrl_.UrlAttachment 	| String		| Identifies the URL the client uses to download the image or video. The HTTP response to a GET of this URL specifies a MIMETYPE, causing a browser to popup a save dialog.	|

###Image Workflow Example
1. Call [CreateSession][] with system and user credentials to create an authentication token.
2. Call [SearchForImages][] to find images that are available for download by checking the ApplicableProductOfferings.
3. Call [GetLargestImageDownloadAuthorizations][] to get the DownloadTokens that authorize download access to the desired images.
4. Call CreateDownloadRequest, providing the DownloadTokens in the request.
5. The collection of DownloadUrls is returned. The UrlAttachment field has a value if the Status is "Available" and the customer is authorized to download the image.

###Video Workflow Example
1. Call [CreateSession][] with system and user credentials to create an authentication token.
2. Call [SearchForVideos][] to find videos that are available for download by checking the ApplicableProductOfferings.
4. Call CreateDownloadRequest, providing the DownloadTokens in the request.
5. The collection of DownloadUrls is returned. The UrlAttachment field has a value if the Status is "Available" and the customer is authorized to download the image.


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
