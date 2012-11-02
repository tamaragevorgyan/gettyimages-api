SearchForImages
-------------
The SearchForImages call returns image metadata for all images matching a
specified search query.

###Search Queries and Filters
SearchForImages partitions a search into a query and an optional set of filters. At
least one query must be provided. All filters are optional. This partitioning supports
the scenario where the client submits a query and the server responds with
suggested possible modifications to that query, in addition to the initial results. The
client can then resubmit the original query and provide any of the suggested
modifications as filters. It enables clients to create workflows that allow users to
interactively modify their search in response to suggestions that can improve the
quality of matches.

###Search Pagination
Clients can control the subset of matching images returned in a response. This
feature supports pagination scenarios. The subset, or "page" of images returned is
specified by the client with an index: ItemStartNumber, and offset: ItemCount.

###Search Hide/Block
Hide/Block restricts the items returned in a search result set to conform to legal
requirements and comply with image partner contracts based on the end user's
billing country.

###Endpoint
Use the following endpoint to access this operation

	http://connect.gettyimages.com/v1/search/SearchForImages

###Request
The SearchForImages JSON request has this form:

	{
	  "RequestHeader": {
	  "Token": "",
	  "CoordinationId": ""
	  },
	  "SearchForImages2RequestBody": {
	    "Filter": {
	      "Collections":{
	      "Ids": [""],
	      "Mode": ""
	      },
	      "EditorialSegments": [
	        ""
	      ],
	      "EditorialSources": {
	        "Ids": [""],
	        "Mode": ""
	      }
	      "FileTypes": [
	        ""
	      ],
	      "GraphicStyles": [
	        ""
	      ],
	      "ImageFamilies": [
	        ""
	      ],
	      "LicensingModels": [
	        ""
	      ],
	      "Orientations": [
	        ""
	      ],
	      "ProductOfferings": [
	        ""
	      ],
	      "Refinements": [
	        {
	          "Category": "",
	          "Id": ""
	        }
	      ]
	    },
	  "Language": "",
	  "Query": {
	    "DateCreatedRange": {
	      "EndDate": "\/Date(1315586894349-0700)\/",
	      "StartDate": "\/Date(1315586894349-0700)\/"
	    },
	    "EventId": 1,
	    "SearchPhrase": "",
	    "KeywordIds": [
	      ""
	    ],
	    "SpecificPersons": [
	      ""
	    ]
	  },
	  "ResultOptions": {
	    "IncludeKeywords": boolean,
	    "ItemCount": int,
	    "ItemStartNumber": int,
	    "RefinementOptionsSet": ""
	    "EditorialSortOrder": ""
	  }
	}

###RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                                                   |
|:---------------|:------------|:-------------|:--------------------------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the standard authentication token provided by CreateSession.                                          |
| CoordinationId |String       |Optional      |Specify a value to echo in the response to track requests and their associated responses.                      |
|Collections     |Object       |Optional      |Contains details for filtering search results by specific CollectionIds.                                       |
|*Collections*.Ids|Collection  |Optional      |Specifies one or more CollectionIds by which to filter search results either on an include or exclude basis.   |
|*Collections*.Mode|String|Optional|Specifies whether the Collection.Ids are being included or excluded from the search results possible values are: <br>• include <br>• exclude
|
|EditorialSegments|Collection|Optional|Specifies a segment of Editorial Image search results being filtered on. Possible values are:
- News
- Sports
- Entertainment
- Publicity
- Royalty
- Archival|
|EditorialSources|Object|Optional|Specifies editorial source Ids to exclude or include from search results.|
|*EditorialSources*.Ids|Collection|Optional|List of editorial source IDs by which to filter.|
|*EditorialSources*.Mode|String|Optional|Specifies whether the EditorialSources are being included or excluded from the search result. Possible values are:

- include

- exclude|
|Filter|Object|Optional|Specifies an instance to filter the query results.|
|DateCreatedRange|Object|Optional|Specifies an instance to query on the images creation date. This query only applies to images when the ImageFamilies filter is null or has an “editorial” ImageFamily entry.|
|EditorialSortOrder|String|Optional|Specifies a sort order for the results of an editorial image search. Note that an entry of "editorial" for the "ImageFamilies" filter must be used for the sort order to take effect. Possible values are:
- Null (order by DateCreated, Date-submitted, ImageId descending)
- MostRecent (order by DateSubmitted descending)
- MostPopular (order by relevancy as determined from data gathered from customer interactions on Getty Images websites)
- Trending (not available)|
|EndDate|String|Optional|Specifies a date that images created prior to that date are to be included in the format described at http://weblogs.asp.net/bleroy/archive/2008/01/18/dates-andjson.
aspx.|
|StartDate|String|Optional|Specifies a date that images created after that date are to be included in the format described at http://weblogs.asp.net/bleroy/archive/2008/01/18/dates-andjson.
aspx.|
|EventId|Integer|Optional|Specifies an eventId to include imagesonly for that event.|
|FileTypes|Collection|Optional|Adds a FileType entry for each file type. These entries are used to filter results.|
|FileType *entry*|String|Optional|Specifies a file type. Possible valuesare:
- eps
- jpg|
|GraphicStyles|Collection|Optional|Adds a GraphicStyle entry for each type of graphics file. These entries are used to filter results.|
|GraphicStyles *entry*|String|Optional|Specifies a type of graphic style. Use to filter results. Possible values are:
- Photography
- Illustration|
|ImageFamilies|Collection|Optional|Adds an ImageFamily entry for each image family filter to apply to the query results. A null field is equivalent to an ImageFamilies field with entries for all possible values.|
|ImageFamily *entry*|String|Optional|Specifies the image family filter to apply to the query results. Possible values are:
- Creative
- Editorial|
|ItemCount|Integer|Required|Specifies the count of matching images returning response. Use with the item start number to support pagination. Valid values are: 1,2,3,4,5,6,10,12,15,20,25,30, 50, 60,75|
|ItemStartNumber|Integer|Required|Specifies the (1-based) index of the first image to return the response. Use with item count to support pagination. ItemsStartNumber should be the index of the first result to return, based on the specified ItemCount. For example, assuming a specified ItemCount of 25, the following values of ItemStartNumber would be used: 1 (1st page), 26 (2nd page), 51 (3rd page), and so forth.|
|IncludeKeywords|Boolean|Optional|To include keywords in the response, set to “true”. Set to “false” otherwise.|
|KeywordIds|Collection|Optional|Specifies the KeywordIds to query the images that match all the specified KeywordIds. It is the logical “AND” of all the specified KeywordIds.|
|Language|String|Optional|Specifies an IETF RFC 5646 compliant language tag to determine the language used for localizable strings returned in the response. Defaults to “en-US” if no value is provided.|
|LicensingModels|Collection|Optional|Adds a LicensingModel entry for each type of license. Use to filter results.|
|LicensingModel *entry*|String|Optional|Specifies the type of license to filter results by. Possible values are:
- RoyaltyFree
- RightsManaged|
|Orientations|Collection|Optional|Adds an orientation entry for each type of orientation. These entries are used to filter results.|
|Orientations *entry*|String|Optional|Specifies image orientations to be included in search results. Possible values are:
- Horizontal
- Vertical
- Panoramichorizontal
- Panoramicvertical
- Square|
|Product Offerings|Collection|Optional|Adds a ProductOfferings entry for each type of product offering. Use to filter results.|
|Product Offerings *entry*|String|Optional|Specifies product offerings to be included in search results. Possible values are:
- PremiumAccess
- EditorialSubscription
- EasyAccess|
|Query|Object|Required|Specifies an instance to provide the
search query.|
|Refinements|Collection|Optional|Adds a Refinement entry for each refinement filter to apply to the query results. This functionality supports “drill down” style filtering of a prior search query. Thus the applicable refinement filters for a query are provided in the search responses RefinementOptions
collection.|
|Refinement *entry*|Object|Optional|Contains the details for specific refinement
filter.|
|Refinement.Category|String|Conditional|Required when providing a Refinement entry. Specifies the category of the refinement filter. Use the RefinementOption.Category value for the desired refinement option in the response.|
|Refinement.Id|String|Conditional|Required when providing a Refinement entry. Specifies the identifier of the refinement filter. Use the Refinement Option.Id value from the desire refinement
option in the response.|
|RefinementOptionsSet|String|Optional|Specifies a profile that activates a custom set of available refinement options. If no value is provided, defaults to Getty Images standard refinement options.
Possible values are client specific and are communicated by our product owner after analysis.|
|ResultOptions|Object|Required|Specifies an instance to control paging,
sorting or other result options.|
|SearchPhrase|String|Optional|Specifies the search phrase.|
|SpecificPersons|Collection|Optional|Specifies the personalities to query the images that match all the specified personalities. It is the logical AND of all specified personalities.|

###Response
The SearchForImages JSON response has this form:

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
	  "SearchForImagesResult": {
	    "Images": [
	      {
	        "ApplicableProductOfferings": [
	          ""
	        ],
	        "Artist": "",
	        "AuthorizationConstraints": [
	          ""
	        ],
	        "Caption": "",
	        "CollectionId": "",
	        "CollectionName": "",
	        "ColorType": "",
	        "DateCreated": "\/Date(1294868991374-0800)\/",
	        "DateSubmitted": "\/Date(1294868991390-0800)\/",
	        "EditorialSegments": [
	          ""
	        ],
	        "EditorialSourceId": "",
	        "EditorialSourceName": "",
	        "EventIds": [
	          int
	        ],
	        "GraphicStyle": "",
	        "ImageFamily": "",
	        "ImageId": "",
	        "Keywords": [
	          {
	            "Id": "",
	            "Text": "",
	            "Type": "",
	            "VisualProminence": ""
	          }
	        ]
	        "LicensingModel": "",
	        "Orientations": [
	          ""
	        "QualityRank": int,
	        "ReferralDestinations": [
	          {
		        "SiteName": "",
		        "Url": ""
	          }
	        ],
	        "Title": "",
	        "UrlComp": "",
	        "UrlPreview": "",
	        "UrlThumb": "",
	        "UrlWatermarkComp": "",
	        "UrlWatermarkPreview": ""
	      }
	    ],
	    "EditorialSortOrder": "",
	    "ItemCount": int,
	    "ItemStartNumber": int,
	    "ItemTotalCount": int,
	    "RefinementOptions": [
	      {
	        "Category": "",
	        "Id": "",
	        "ImageCount": int,

###ResponseHeader Fields
The ResponseHeader contains metadata about the operation execution and response.

| Field          | Type        | Description                                                                                                   |
|:---------------|:------------|:--------------------------------------------------------------------------------------------------------------|
|Status|String|Indicates the overall operation processing status notification. Possible values are:
- Success
- Error
- Warning|
|StatusList|Collecton|Contains a Status entry for each detailed processing status notification.|
|Status entry|Object|Contains the details of a status notification.|
|Status.Type|String|Indicates the type, or severity, of the status notification. Possible values are:

- Information
- Warning
- Error|
|*Status*.Code|String|Identifies the category of the status notification. See Status Codes for an explanations of codes.|
|*Status*.Message|String|Provides a human readable explanation of the status.|
|CoordinationId|String|Indicates the CoordinationId value provided in the triggering request.|

###SearchForImagesResult Fields
The SearchForImagesResult contains these fields.

| Field          | Type        | Description                                                                                                   |
|:---------------|:------------|:--------------------------------------------------------------------------------------------------------------|
|Images|Collection|Contains an image entry for each matching image found.|
|Image *entry*|Object|Contains details of the specific matching image.|
|*Image* ApplicableProductOfferings|Collection Contains an ApplicableProductOffering entry for each of the customer’s product offerings that
authorize access to the image. If empty, the customer is not authorized to access the image. Note: Also check the AuthorizationConstraints
collection for possible image specific limitations to the authorization.|
|ApplicableProductOffering *entry*|String|Indicates a customer’s product offering that authorizes access to the image. Possible values are:

- EasyAccess
- EditorialSubscription
- PremiumAccess
- RoyaltyFreeSubscription
- Imagepack|

|*Image*.Artist|String|Identifies the image creator.
|Image.AuthorizationConstraints|Collection|Contains an AuthorizationConstraint entry for each category of possible image-specific limitations to authorization. Authorization constraints occur when an image that would normally be authorized by a customer’s agreement has additional limitations.|
|AuthorizationConstraint *entry*|String|Indicates the category of possible image-specific limitations to authorization. Possible values are:

- CallForImage 

See Authorization Constraints for an explanation of constraint categories.|
|*Image*.Caption|String|Describes the image.|
|*Image*.CollectionId|String|Identifies a collection to which the image belongs.|
|*Image*.CollectionName|String|Identifies the name of the collection to which the image belongs.|
|*Image*.ColorType|String|Indicates where the image is color or black and white. Possible values are:

- Color
- Black/White|

|*Image*.DateCreated|String|Identifies the date the image was created. Date is in the format described at http://weblogs.asp.net/bleroy/archive/2008/01/18/dates-and-json.aspx.|
|*Image*.DateSubmitted|String Identifies the date the image was created. Date is in the format described at http://weblogs.asp.net/bleroy/archive/2008/01/18/dates-and-json.aspx.|
|*Image*.EditorialSegments|Collection|Contains an EditorialSegment entry for each editorial category to which the image belongs, if the image is in the editorial image family.|
|EditorialSegment *entry*|String|Indicates the editorial category to which the image belongs, if the image is in the editorial image family. Possible values are:

- News
- Sport
- Entertainment
- Contour
- Travel
- Publicity
- Royalty
- Archival|

|EditorialSortOrder|String|Identifies the sort order applied to an editorial search in the SearchForImages request. Possible values are:

- Default
- MostRecent
- Trending (not available until September, 2012)
- MostPopular|

|*Image*.editorialSourceId|String|Identifies the source of the image, if the image is in the editorial image family.|
|*Image*.EditorialSource-Name|String|The source name of the image, if the image is in the editorial image family. **Note**: This field is not yet being populated.|
|*Image*.EventIds|Collection|Contains an EventId entry for each event associated with the image. All editorial image family images have event Ids. Some creative image family images may have event Ids.|
|EventID *entry*|String|Specifies the Id of an event associated with the image. All editorial image family images have EventIds. Some creative image family images have EventIds.|
|*Image*.GraphicStyle|String|Indicates the graphic style of the image. Possible values are:

- Photography
- Illustration|

|Image.ImageFamily|String|Indicates the image family classification. Possible values are:

- Creative
- Editorial|

|*Image*.ImageId|String|Identifies the image.|
|Image.Keywords|Collection|Contains a keyword entry for each keyword related to the image.|
|Keyword entry|Object|Contains keyword details.|
|Keyword.Id|String|Identifies the keyword.|
|Keyword.Text|String|Provides localized text of the keyword.|
|Keyword.Type|String|Identifies the type of keyword. Possible values are:

- Unknown
- Specific people
- Ethnicity
- Age
- Gender
- Number of People
- Concept
- Location
- Viewpoint
- Image technique
- Composition
- Color
- Additional Info
- Candidate Term
- Fashion Phrases
- Entertainment|

|Keyword.VisualProminence|String|In "Specific people" keywords, identifies the visual prominence of that person in the image. Possible values are:

- Unknown
- Medium
- High
- VeryHigh|

|Image.Licensing Model|String|Identifies a licensing model for the image. Possible values are:

- RoyaltyFree
- RightsManaged|

|Image.Orientations|Collection|Contains an Orientation entry for each of the available orientations of the image. Orientation entry String Indicates available orientations of the image. Possible values are:

- Horizontal
- Vertical
- Square
- Panoramic|

|Image.QualityRank|Integer|Assigned to editorial images to rank their relevance to the event they belong to. This number has no relevance for creative images eventhough it does appear in the metadata. Possible values are:

- 1 most relevant
- 2 tells story from a wider perspective
- 3 stock/repeats/less important|

|Image.ReferralDestinations|Collection|Contains a ReferralDestination entry for each of the sites on which the image can be found.|
|SiteName *entry*|String|Indicates the name of the website(s) on which the image can be found. Possible values are:

- gettyimages
- thinkstock
- jupiterimages
- photos|

|Url *entry*|String|Indicates the specific URL for the page on which the images can be found.|
|*Image*.Title|String|Indicates the image title.|
|*Image*.UrlComp|String|Identifies the URL of the image, sized for layout composition. Comp images are larger than preview and thumbnail, but not full sized.|
|*Image*.UrlPreview|String|Identifies the URL of the image, sized for popup previews. Preview images are larger than thumbnail but smaller than comp.|
|*Image*.UrlThumb|String|Identifies the URL of the image, sized for a results grid. Thumbnail images are smaller than preview and comp.|
|*Image*.UrlWatermarkComp|String|Identifies the URL of the image, sized for layout composition, with a Getty Images watermark. Preview images are larger than thumbnail, but smaller than comp.|
|ItemCount|Integer|Indicates the count of matching images returned in the response. Use with ItemStartNumber to support pagination.|
|ItemStartNumber|Integer|Indicates the (1-based) index of the first image returned in response. Used with ItemCount to support pagination.|
|ItemTotalCount|Integer|Indicates the total number of images matching the query, including those not returned with this response.|
|RefinementOptions|Collection|Contains a RefinementOption entry for each refinement that can be applied to the query to filter results on a subsequent search.|
|RefinementOption *entry*|Object|Contains details about a refinement.|
|*RefinementOption*.Category|String|Identifies the category of refinement. See Available Refinements for descriptions of each restriction category.|
|*RefinementOption*.Id|String|Identifies a refinement.|
|*RefinementOption*.ImageCount|Integer|Indicates the count of images to return if the query is filtered with this refinement.|
|*RefinementOption*.Text|String|Provides localized name of the refinement.|

####Workflow Example: Initial Search
1. Call CreateSession with system and user credentials to create an authentication token.
2. Call SearchForImages, providing the authentication token in the request header and
specifying the query in the request body.
3. For an initial search, populate the following fields:
- Query.SearchPhrase
- ResultOptions.ItemCount
- ResultOptions.ItemStartNumber
- Leave Filter undefined.
4. Retrieve image metadata from the Images entries.
5. Retrieve refinement filters from the RefinementOptions entries if a refined search will be
supported.

###Workflow Example: Refined Search
Call SearchForImages, providing the same request as in the initial search, but with
the following modification.

1. Add an entry to Filter.Refinements for desired refinement options.
2. Populate each Refinements entry's fields from the corresponding fields from the desired
RefinementOptions entry.
3. Retrieve image metadata from the Images entries.
4. Retrieve refinement filters from the RefinementOptions entries if an additional refined
search is supported.