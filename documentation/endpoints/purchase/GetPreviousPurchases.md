GetPreviousPurchases
---------------------
The GetPreviousPurchases call returns information about a customer's previously
purchased assets.

###Endpoint
Use the following endpoint to access this operation:

	https://connect.gettyimages.com/v1/purchase/GetPreviousPurchases

###Request
The GetPreviousPurchases JSON request has this form:

	{
  		"RequestHeader": {
    	  		"Token": "",
    	  		"CoordinationId": ""
  		},
  		"GetPreviousPurchasesRequestBody": {
			"ItemCount": int,
			"ItemStartNumber": int,
			"ItemSortType": string,
			"Filter": {
				"SearchCriteria": "".
				"SearchCriteriaType": ""
				}
			}
		}
	}
####RequestHeader Fields
The RequestHeader specifies metadata about the request..

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the secure authentication token provided by [CreateSession][].                        | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####GetPreviousPurchasesRequestBody Fields
The GetPreviousPurchasesRequestBody contains the request arguments.

| Field          				| Type 		| Use          | Description 																	|
|:------------------------------|:----------|:-------------|:-------------------------------------------------------------------------------|
| ItemCount| Integer | Required | Specify the count of previous purchases to return in the response. | 
| ItemStartNumber | Integer | Required | Specify the (1-based) index of the first previous purchase to return in the response. Use with ItemCount to support pagination. ItemStartNumber should be the index of the first result to return, based on the specified ItemCount. For example, assuming a specified ItemCount of 25, the following values for ItemStartNumber would be used: 1 (1st page), 26 (2nd page), 51 (3rd page), and so forth. |
| ItemSortType | String | Optional | Specifies sorting to be used in the previous purchase results. Possible values are: <br>• AssetIdAscending <br>• AssetIdDescending <br>• ClientNameAscending <br>• ClientNameDescending <br>• CollectionNameAscending <br>• CollectionNameDescending <br>• OrderDateAscending <br>• OrderDateDescending <br>• PurchaseOrderNumberAscending <br>• PurchaseOrderNumberDescending |
| Filter | Object | Optional | Specifies an instance to filter the response. |
| SearchCriteria | String | Optional | Specifies the value to use to filter the previous purchase results. |
| SearchCriteriaType | String | Optional | Specifies the field that the SearchCriteria filter should target. Possible values are: <br>• AssetId <br>• ClientName <br>• JobReferenceNumber <br>• OrderId <br>• PurchaseOrderNumber |

###Response
The GetPreviousPurchases JSON response has this form:

	{
		"ResponseHeader": {
			"Status": "success",
			"StatusList": []
		},
		"GetPreviousPurchasesResultBody": {
			"PreviousPurchases": [
				{
        				"AssetId": "",
        				"DatePurchased": "",
        				"OrderId": "",
        				"UrlThumb": ""
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

####GetPreviousPurchasesResultBody Fields
The GetPreviousPurchasesResultBody contains these fields

| Field 						| Type 			| Description 																							|
|:------------------------------|:--------------|:------------------------------------------------------------------------------------------------------|
| PreviousPurchases | Collection | Contains an entry for each previous purchase. |
| PreviousPurchases _entry_ | Object | Contains the details for a previous purchase. |
| _PreviousPurchase_.AssetId | String | Identifies the purchased asset. |
| _PreviousPurchase_.DatePurchased | String | Identifies the date of the purchase. Dates are in the <a href="http://www.w3.org/TR/NOTE-datetime">ISO 8601 format</a> (i.e. YYYY-MM-DDThh:mm:ssTZD where TZD is the time zone designation).
| _PreviousPurchases_.OrderId | String | Identifies the order containing the purchased asset. |
| _PreviousPurchase_.UrlThumb | String | Identifies the URL of the image purchased, sized for a results grid. |
| ItemCount | Integer | Indicates the count of matching images returned in the response. Used with ItemStartNumber to support pagination. |
| ItemStartNumber | Integer | Indicates the (1-based) index of the first image returned in response. Used with ItemCount to support pagination. |
| ItemTotalCount | Integer | Indicates the total number of images matching the query, including those not returned with this response. |

###Workflow Example
1. Call [CreateSession][] with system and user credentials to create an authentication token.
2. Call GetPreviousPurchases.
5. The collection of previous purchases is returned.

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
[CreatePurchaseRequest]: ../purchase/CreatePurchaseRequest.md
[GetImagePurchaseAuthorizations]: ../purchase/GetImagePurchaseAuthorizations.md
[GetLargestImagePurchaseAuthorizations]: ../purchase/GetLargestImagePurchaseAuthorizations.md
[GetEventDetails]: ../search/GetEventDetails.md
[GetImageDetails]: ../search/GetImageDetails.md
[SearchForImages]: ../search/SearchForImages.md
[SearchForVideos]: ../search/SearchForVideos.md
