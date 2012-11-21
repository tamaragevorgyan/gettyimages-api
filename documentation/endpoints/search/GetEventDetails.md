GetEventDetails
---------------
The GetEventDetails call returns detailed event metadata for all specified events.

###Endpoint
Use the following endpoints to access this operation:

	http://connect.gettyimages.com/v1/search/GetEventDetails

###Request
The GetEventDetails JSON request has this form:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "GetEventDetailsRequestBody": {
	    "EventIds": [
	      int
	    ],
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the secure authentication token provided by CreateSession.                        | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####GetEventDetailsRequestBody Fields
The GetEventDetailsRequestBody contains the request arguments.

| Field 			| Type 		 | Use 		| Description 																				|
|:------------------|:-----------|:---------|:------------------------------------------------------------------------------------------|
| EventIds 			| Collection | Required	| Adds an EventId entry for each event for which you want details in the result.			|
| EventId _entry_ 	| Integer	 | Required	| Specifies the ID entry of an event for which you want details in the result.				|

###Response
The GetEventDetails JSON response has this form:

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
	  "GetEventDetailsResult": {
	     "EventResult": [
	        {
	            "Event": {
	               "ChildEventCount": int,
	               "EditorialSegments": [
	                  ""
	               ],
	               "EventId": int
	               "EventName": "",
	               "ImageCount": int,
	               "Location": {
	                  "City": "",
	                  "Country": "",
	                  "StateProvince": "",
	                  "Venue": ""
	               },
	               "RepresentativeImageId": "",
	               "StartDate": "\/Date(1328860800000-0800)\/"
	            },
	            "EventId": int,
	            "Status": ""
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
| _Status_.Code    | String      | Identifies the category of the status notification. See [Status Codes](#statuscodes) for an explanations of the codes.        |
| _Status_.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |

####GetEventDetailsResults Fields
The GetEventDetailsResults contains these fields:

| Field 						| Type 		 | Description 																						|
|:------------------------------|:-----------|:-------------------------------------------------------------------------------------------------|
| EventResult 					| Collection | Contains an EventResult entry for each requested event.											|
| Event _entry_ 				| Object 	 | Contains details of the specific matching event.													|
| _Event_.ChildEventCount 		| Integer 	 | Number of child events associated with the event, where the requested event is a parent event.	|
| _Event_.EditorialSegment 		| Collection | Contains an entry for each editorial segment or event category to which the event belongs.		|
| EditorialSegments _entry_ 	| Integer 	 | Indicates the event category to which the image belongs.											|
| _Event_.EventId 		 		| Integer	 | Identifies the event.																			|
| _Event_.EventName		 		| String	 | A human readable display name for the event.														|
| _Event_.ImageCount			| Integer	 | The number of image assets associated with the event.											|
| _Event_.Location 				| Collection | Contains the location details of the event.														|
| Location _entry_ 				| Object 	 | Contains metadata on event location.																|
| _Location_.City 				| String 	 | City where the event took place.																	|
| _Location_.Country			| String 	 | Country where the event took place.																|
| _Location_.StateProvince		| String 	 | State or province where the event took place.													|
| _Location_.Venue 				| String 	 | Venue where the event took place.																|
| Event.RepresentativeImageId 	| String 	 | A thumbnail image selected to represent the event.												|
| Event.StartDate 			 	| DateTime 	 | The date the event began.																		|
| Event.Status 	 			 	| String 	 | Indicates the image size status notification. Possible values are: <br>• Success <br>• Not Found	|

###Workflow Example
1. Call CreateSession with system and user credentials to create an authentication token.
2. Call SearchForImages to find images.
3. Call GetEventDetails providing EventIds from search results, to retrieve event details for the specified events.




