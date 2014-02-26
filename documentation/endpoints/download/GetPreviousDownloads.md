GetPreviousDownloads
---------------------
The GetPreviousDownloads call returns information about a customer's previously
downloaded assets.

###Endpoint
Use the following endpoint to access this operation:

	https://connect.gettyimages.com/v1/download/GetPreviousDownloads

###Request
The GetPreviousDownloads JSON request has this form:

	{
  		"RequestHeader": {
    	  		"Token": "",
    	  		"CoordinationId": ""
  		},
  		"GetPreviousDownloadsRequestBody": {
			"ItemCount": int,
			"ItemStartNumber": int,
			"Filter": {
				"DateRange": {
					"Start": "",
					"End": ""
				},
				"ProductOffering": ""
			}
		}
	}
####RequestHeader Fields
The RequestHeader specifies metadata about the request..

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the secure authentication token provided by [CreateSession][].                        | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####GetPreviousDownloadsRequestBody Fields
The GetPreviousDownloadsRequestBody contains the request arguments.

| Field          				| Type 		| Use          | Description 																	|
|:------------------------------|:----------|:-------------|:-------------------------------------------------------------------------------|
| ItemCount| Integer | Required | Specify the count of previous downloads to return in the response. | 
| ItemStartNumber | Integer | Required | Specify the (1-based) index of the first previous download to return in the response. Use with ItemCount to support pagination. ItemStartNumber should be the index of the first result to return, based on the specified ItemCount. For example, assuming a specified ItemCount of 25, the following values for ItemStartNumber would be used: 1 (1st page), 26 (2nd page), 51 (3rd page), and so forth. |
| Filter | Object | Optional | Specifies an instance to filter the response. |
| DateRange | Object | Optional | Specifies an instance to filter on the download date. |
| StartDate | String | Optional | Specifies a date and time so that images downloaded after that date are to be included in the response. Dates should be submitted in the <a href="http://www.w3.org/TR/NOTE-datetime">ISO 8601 format</a> (i.e. YYYY-MM-DDThh:mm:ssTZD where TZD is the time zone designation). Note that specifying a StartDate requires that an EndDate is specified as well. |
| EndDate | String | Optional | Specifies a date and time so that images downloaded up to that date are to be included in the response. Dates should be submitted in the <a href="http://www.w3.org/TR/NOTE-datetime">ISO 8601 format</a> (i.e. YYYY-MM-DDThh:mm:ssTZD where TZD is the time zone designation). Note that specifying an EndDate requires that a StartDate is specified as well. |
| ProductOffering | String | Optional | Specifies product offerings to be included in the previous download results. Possible values are: <br>• All <br>• EditorialSubscription <br>• EasyAccess <br>• LegacyRfSubscription <br>• PremiumAccess <br>• RoyaltyFreeSubscription <br>• ImagePack |

###Response
The GetPreviousDownloads JSON response has this form:

	{
		"ResponseHeader": {
			"Status": "success",
			"StatusList": []
		},
		"GetPreviousDownloadsResultBody": {
			"PreviousDownloads": [
				{
        				"AssetId": "",
        				"DateDownloaded": "",
        				"ThumbnailImageUrl": "",
        				"ProductOffering": ""
				}
			],
			"ItemCount": int,
			"ItemStartNumber": int,
			"ItemTotalCount": int
		}
	}

####ResponseHeader Fields
The ResponseHeader contains metadata about the operation execution and response.

| Field            | Type        | Description                                                                                                                   |
|:-----------------|:------------|:------------------------------------------------------------------------------------------------------------------------------|
| Status           | String      | Indicates the overall operation processing status notification. Possible values are: <br>• Success <br>• Error | 
| StatusList       | Collection  | Contains a _Status_ entry for each detailed processing status notification.                                                   |
| Status _entry_   | Object      | Contains the details of a status notification                                                                                 |
| _Status_.Type    | String      | Indicates the type, or severity, of the status notification. Possible values are: <br>• Information <br>• Error |
| _Status_.Code    | String      | Identifies the category of the status notification. See [StatusCodes][] for an explanations of the codes.        |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |

####GetPreviousDownloadsResultBody Fields
The GetPreviousDownloadsResultBody contains these fields

| Field 						| Type 			| Description 																							|
|:------------------------------|:--------------|:------------------------------------------------------------------------------------------------------|
| PreviousDownloads | Collection | Contains an entry for each previous download. |
| PreviousDownloads _entry_ | Object | Contains the details for a previous download. |
| _PreviousDownload_.AssetId | String | Identifies the download. |
| _PreviousDownload_.DateDownloaded | String | Identifies the date of the download. Dates are in the <a href="http://www.w3.org/TR/NOTE-datetime">ISO 8601 format</a> (i.e. YYYY-MM-DDThh:mm:ssTZD where TZD is the time zone designation).
| _PreviousDownload_.UrlThumb | String |Identifies the URL of the image downloaded, sized for a results grid. |
| _PreviousDownloads_.ProductOffering | String | Indicates a customer's product offering that authorized access to the asset. Possible values are: <br>• All <br>• EditorialSubscription <br>• EasyAccess <br>• LegacyRfSubscription <br>• PremiumAccess <br>• RoyaltyFreeSubscription <br>• ImagePack |
| ItemCount | Integer | Indicates the count of matching images returned in the response. Used with ItemStartNumber to support pagination. |
| ItemStartNumber | Integer | Indicates the (1-based) index of the first image returned in response. Used with ItemCount to support pagination. |
| ItemTotalCount | Integer | Indicates the total number of images matching the query, including those not returned with this response. |

###Workflow Example
1. Call [CreateSession][] with system and user credentials to create an authentication token.
2. Call GetPreviousDownloads.
5. The collection of previous downloads is returned.

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
