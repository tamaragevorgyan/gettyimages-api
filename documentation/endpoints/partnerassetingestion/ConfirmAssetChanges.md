ConfirmAssetChanges
-------------
The ConfirmAssetChanges call acknowledges receipt of asset changes contained in a [GetAssetChanges][] response. Until a GetAssetChanges response is confirmed, the response will continue to return the same batch of asset changes for the given ChannelId.

This operation is not publicly available at this time. Please contact your Getty Images Account Manager if you need more information.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/partnerassetingestion/ConfirmAssetChanges


###Request
The ConfirmAssetChanges JSON request has this format:

    {
      "RequestHeader": {
        "Token": "",
        "CoordinationId": ""
      },
      "ConfirmAssetChangesRequestBody": {
        "TransactionId": ""
      }
    }

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the authentication token provided by [CreateSession][].                           | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####ConfirmAssetChangesRequestBody Fields
The ConfirmAssetChangesRequestBody contains the request arguments.

| Field 		    | Type		| Use     | Description 																						                                               |
|:--------------|:--------|:--------|:-------------------------------------------------------------------------------------------------------|
| TransactionId	| String 	| Required| Specify the TransactionId associated with a [GetAssetChanges][] response whose receipt you want to confirm.|


###Response
The ConfirmAssetChanges JSON response has this format:

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
      "ConfirmAssetChangesResponseBody": {}
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


####ConfirmAssetChangesResponseBody Fields
The ConfirmAssetChangesResponseBody contains no response data.

###Workflow Example
1. Call either [CreateSession][] to create an authentication token.
2. Call [GetAssetChanges][] to get a list of changed assets for a channel to which you are subscribed.
3. Call ConfirmAssetChanges with the resulting TransactionId to confirm you have received and processed the asset changes.
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
[GetAssetChanges]: ../partnerassetingestion/GetAssetChanges.md



