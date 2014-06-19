ReportUsage
===========

Usage Reporting Concepts
------------------------

### API Details
Much like the rest of the Connect API, ReportUsage requests are supported via HTTP POST only to the endpoints listed below. Request and response payloads are in JSON. 

### Unique Transaction IDs
Each ReportUsage request must contain a TransactionId value that is unique per request within the scope of your application's SystemID. Using a UUID or GUID is a best practice for ensuring unique IDs. Any ReportUsage requests submitted with a previously submitted TransactionId will result in a warning and usage report will not be recorded.

### Batching of ReportUsage Data
The ReportUsage operation will accept up to 1000 AssetUsage items in a single submission. Each AssetUsage item should contain a valid ImageId, a number of usages, and the date of those usages. ImageIds within a ReportUsage request need not be unique. Given the atomic nature of the operation, all ImageIds included in a request must be valid for the ReportUsage request to succeed and be recorded. ReportUsage requests containing an invalid ImageId will cause the operation to fail and return an error response, which means none of the reported usages have been recorded. In order to successfully record the reported usages, the failed request must be resubmitted (minus the invalid ImageIds or after correcting them) with a new TransactionId.

### Tokens
All ReportUsage operation calls require a valid authentication token (generated using the Connect API's CreateSession operation) to be included in the RequestHeader. Tokens expire after 30 minutes, so new tokens should regularly be requested via CreateSession to prevent ReportUsage requests from failing due to expired tokens. For more details on how to call CreateSession, please review the Connect API documentation found at http://api.gettyimages.com.

###Endpoint
Use the following endpoint to access this operation.

    https://connect.gettyimages.com/v1/usage/ReportUsage


Request
--------
Populate and submit the following JSON representation of the ReportUsage request. Fields are explained below. 

        {
            "RequestHeader": {
                "Token": token,
                "Detail": "",
                "CoordinationId": ""
            },
            "ReportUsageRequestBody": {
             "TransactionId": "string",
	            "AssetUsages": [
		            {
        		    "AssetId": "1234567890",
        		    "Quantity": 2,
        		    "UsageDate": "2014-01-14"
        		    }
                ]
            }
        }


###RequestHeader Fields
The RequestHeader specifies metadata about the request. Required fields are indicated; all others are optional.

| Field          | Type        | Use          | Description                                                                                                         |
|:---------------|:------------|:-------------|:--------------------------------------------------------------------------------------------------------------------|
| Token	         | String      | Required     | Specify the standard authentication token provided by CreateSession.                                                |
| CoordinationId | String      | Optional     | Specify a value that will be echoed in the response; can be used to track requests and their associated responses.  |

###ReportUsageRequestBody Fields
The ReportUsageRequestBody contains the request arguments. Required fields are indicated; all others are optional.

| Field          | Type        | Use          | Description                                                                                                         |
|:---------------|:------------|:-------------|:--------------------------------------------------------------------------------------------------------------------|
| TransactionId  | String      | Required     | Specify an identifier unique to this instance of the ReportUsage request.                                           |
| AssetUsages _entry_ | Object      | Required     | Object containing the asset usages being reported.  |
| AssetUsages._AssetId_ | String      | Required     | Specify the GettyImages asset/image ID used.  |
| AssetUsages._Quantity_ | Integer      | Required     | Number of usages of the asset/image ID being reported.  |
| AssetUsages._UsageDate_ | String      | Required     | Identifies the date the asset/image was used. Dates should be submitted in <a href="http://www.w3.org/TR/NOTE-datetime">ISO 8601 format</a> (i.e., YYYY-MM-DD).|

Response
---------
The operation returns the following JSON representation of the response. Fields are explained below.

        {
            "ResponseHeader": {
                "Status": "success",
                "StatusList": [],
                "CoordinationId": ""
            },
            "ReportUsageResponseBody":  {
    		"TotalAssetUsagesProcessed": 2
		}
        }

###ResponseHeader Fields
The ResponseHeader contains metadata about the operation execution and response.

| Field            | Type        | Description                                                                                                                   |
|:-----------------|:------------|:------------------------------------------------------------------------------------------------------------------------------|
| Status	       | String      | Indicates the overall operation processing status notification. Possible values are: success, error, warning.                 |
| StatusList	   | Collection  | Contains a Status entry for each detailed processing status notification.                                                     |
| Status _entry_   | Object      | Object containing the details of a status notification.                                                                       |
| Status._Type_    | String      | Indicates the type, or severity, of the status notification. Possible values are: Information, Warning, Error.                |
| Status._Code_	   | String      | Identifies the category of the status notification. See Error! Reference source not found. for explanations of codes.         |
| Status._Message_ | String      | Provides a human readable explanation of the status notification.                                                             |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |

###ReportUsageResponseBody Fields
The ReportUsageResponseBody contains the response data.

| Field            | Type        | Description                                                     |
|:-----------------|:------------|:----------------------------------------------------------------|
| TotalAssetUsagesProcessed	   | Int  | Quantity of successfully recorded usages.  |  
| InvalidAssets	   | Collection  | List of invalid ImageIds submitted in the ReportUsage request.  |                        

