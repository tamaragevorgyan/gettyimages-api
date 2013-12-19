GetAssetChanges
-------------
The GetAssetChanges call returns a list of changed assets relative to a local store of Getty Images assets. <b>Note that you must call [ConfirmAssetChanges][] operation</b> after every GetAssetChanges request. Doing so will clear the most recent set of images from our database, enabling you to call for the next set. If you do not call ConfirmAssetChanges, you will get the same list of images in every GetAssetChanges request.

This operation is not publicly available at this time. Please contact your Getty Images Account Manager if you need more information.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/partnerassetingestion/GetAssetChanges


###Request
The GetAssetChanges JSON request has this format:

	{
  		"RequestHeader": {
    		"Token": "",
    		"CoordinationId": ""
  		},
  		"GetAssetChangesRequestBody": {
    		"ChannelId": int,
    		"ItemCount": int
  		}
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by [CreateSession][].                           | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####GetAssetChangesRequestBody Fields
The GetAssetChangesRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																						|
|:--------------|:----------|:----------|:--------------------------------------------------------------------------------------------------|
| ChannelId		| Integer 	| Required 	| Specify the channel of content for the GetAssetChanges request. Each channel contains changed assets based on criteria such as asset family, changed asset metadata, or the type of change to the asset (i.e. new, deleted, updated)|
| ItemCount		| Integer 	| Optional 	| Number of assets to return in the response. Default is 10; maximum is 500.						|



###Response
The GetAssetChanges JSON response has this format:

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
		"GetAssetChangesResponseBody": {
    		"ChangedAssets": [
      			{
        		"AssetChangedDateTimeUtc": "/Date(1364949101417-0700)/",
        		"AssetId": "",
        		"AssetLifecycle": "",
        		"AssetType": "",
        		"ChangedProperties": [""],
        		"Url": ""
      			}
    		],
 			"TransactionId": ""
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


####GetAssetChangesResponseBody Fields
The GetAssetChangesResponseBody contains the response data.

| Field                					   	| Type      | Description																						|
|:------------------------------------------|:----------|:--------------------------------------------------------------------------------------------------|
| ChangedAssets	          					| Collection| Contains a list of _ChangedAssets_ results for the query. 										|
| ChangedAssets _entry_   					| Object	| The ChangedAssets object that contains information about the asset change. 						|
| _ChangedAssets_.AssetChangedDateTimeUtc	| String    | Contains the date of the asset change.															|
| _ChangedAssets_.AssetId 					| String	| Contains the AssetId for the asset change.    													|
| _ChangedAssets_.AssetLifecycle 			| String	| Contains the type of change this asset change is. (i.e. "New," "Updated" or "Deleted")			|
| _ChangedAssets_.AssetType 				| String    | Contains the type of asset this asset change is (i.e. "Image"). 									|
| _ChangedAssets_.ChangedProperties			| Collection| Contains a list of the metadata fields updated for assets with an AssetLifecycle of "Updated." 	|
| ChangedProperties._entry_					| String	| Contains the name of an updated metadata field for the changed asset.							 	|
| _ChangedAssets_.Url						| String	| Contains the asset download URL for assets with an AssetLifecycle of "New."					 	|
| TransactionId								| String	| Contains the identifier for the GetAssetChanges request/response. Passed into [ConfirmAssetChanges][] requests to confirm receipt of the asset changes in the response.|


###Workflow Example
1. Call either [CreateSession][] to create an authentication token.
2. Call GetAssetChanges to get a list of changed assets for a channel to which you are subscribed.
3. Call [ConfirmAssetChanges][] with the resulting TransactionId to confirm you have received and processed the asset changes.
4. Repeat steps 2 and 3 until all asset changes for the channel are received.


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
[ConfirmAssetChanges]: ../partnerassetingestion/ConfirmAssetChanges.md



