SearchForVideos
---------------
The SearchForVideos call returns video metadata for all videos matching a specified search query or set of asset IDs.

###Search Queries and Filters
**SearchForVideos** partitions a search into a query and an optional set of filters. At least one query must be provided. All filters are optional. 
This partitioning supports the scenario where the client submits a query and the server responds with suggested possible modifications to that query, in addition to the initial results. 
The client can then resubmit the original query and provide any of the suggested modifications as filters. 
It enables clients to create workflows that allow users to interactively modify their search in response to suggestions that can improve the quality of matches.

###Search Pagination
Clients can control the subset of matching videos returned in a response. This feature supports pagination scenarios. The subset, or "page" of videos returned is specified by the client 
with an index: ItemStartNumber, and offset: ItemCount.

###Search Hide/Block
Hide/Block restricts the items returned in a search result set to conform to legal requirements and comply with video partner contracts based on the end user's billing country.

###Endpoint
Use the following endpoint to access this operation:

	https://connect.gettyimages.com/v1/search/SearchForVideos

###Request
The **SearchForVideos** JSON request has this form:

	{
	  "RequestHeader": {
		"Token": "",
		"CoordinationId": ""
	  },
	  "SearchForVideosRequestBody": {
		"Filter": {
		  "AssetFamilies": [""],
		  "ClipType": "",
		  "Collections": {
			"Ids": [],
			"Mode": ""
		  },
		  "ExcludeNudity": "",
		  "Formats": []
		},
		"Language": "",
		"Query": {
		  "AssetIds": [],
		  "KeywordIds": [],
		  "SearchPhrase": "",
		  "EntityUris": []

		},
		"ResultOptions": {
		  "ItemCount": int,
		  "ItemStartNumber": int,
		  "SortOrder": ""
		}
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                                                   |
|:---------------|:------------|:-------------|:--------------------------------------------------------------------------------------------------------------|
| Token          | String      | Nil          | Specify the standard authentication token provided by [CreateSession][] | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####SearchForVideosRequestBody Fields
The SearchForVideosRequestBody contains the request arguments.

| Field                           | Type        | Use          | Description                                                                                  |
|:--------------------------------|:------------|:-------------|:---------------------------------------------------------------------------------------------|
| AssetFamilies                   | Collection  | Optional     | Adds an AssetFamily entry for each asset family filter to apply to the query results. A null field is equivalent to an AssetFamilies field with entries for all possible values. |
| AssetFamily *entry*             | String      | Optional     | Specifies the asset family filter to apply to the query results. Possible values are:<br>• Creative<br>• Editorial |
| ClipType *entry*                | String      | Optional     | Specifies the clip type filter to apply to the query results for the Editorial AssetFamily only. Possible values are:<br>• Produced<br>• Raw |
| Collections                     | Object      | Optional     | Contains details for filtering search results by specific CollectionIds. |
| *Collections*.Ids               | Collection  | Optional     | Adds a CollectionId entry for each collection id filter to apply to the query results on either an include or exclude basis. |
| Id *entry*                      | String      | Optional     | Specifies the CollectionId filter to apply to the query results on either an include or exclude basis. |
| *Collections*.Mode              | String      | Optional     | Specifies whether the CollectionIds are being included or excluded from the search results possible values are:<br>• Include<br>• Exclude |
|ExcludeNudity|Boolean|Optional|To filter out images of nudity and related subjects, set to "true". To not filter these images, set to "false". Leaving the filter out of your request has the effect of "false".|
| Filter                          | Object      | Optional     | Specifies an instance to filter the query results. |
| Formats                         | Collection  | Optional     | Adds a Format entry for each format filter to apply to the query results. A null field is equivalent to a Formats field with entries for all possible values. |
| Format *entry*                  | String      | Optional     | Specifies the formats filter to apply to the query results. Possible values are:<br>• HD<br>• SD |
| Language                        | String      | Optional     | Specifies an IETF RFC 5646 compliant language tag to determine the language used for localizable strings returned in the response. Defaults to "en-US" if no value is provided. |
| Query                           | Object      | Required     | Specifies an instance to provide the search query. |
| *Query*.AssetIds                | Collection  | Optional     | Adds an AssetId entry of each video for which you want metadata in the results. Specifying AssetIds overrides all Filter settings and all other Query settings. AssetIds supports a maximum of 500 entries.  |
| AssetId *entry*                 | Object      | Optional     | Specifies the ID entry of a video for which you want metadata in the results. |
| *Query*.KeywordIds              | Collection  | Optional     | Adds a KeywordId entry for each keyword id to query the videos that match all the specified KeywordIds. It is the logical "AND" of all the specified KeywordIds.  |
| KeywordId  *entry*              | String      | Optional     | Specifies a KeywordId to query the videos by. |
| *Query*.SearchPhrase            | String      | Optional     | Specifies the search phrase. |
|*Query*.EntityUris|Collection|Optional|Contains a list of linked data entity uris. Supported providers are: <br>• Freebase<br>• Dbpedia<br>• Musicbrainz<br> For more information about contructing the URIs and searching for people and other entities, see the <a href="https://github.com/gettyimages/connect/blob/master/documentation/appendix/entitysearch.md">Searching for Specific People or Other Entities</a> appendix.|
| ResultOptions                   | Object      | Required     | Specifies an instance to control paging, sorting, or other result options. |
| *ResultOptions*.ItemCount       | Integer     | Required     | Specifies the count of matching videos to return in the response. Use with the item start number to support pagination. Valid values are: 1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 25, 30, 50, 60, 75, 90 |
| *ResultOptions*.ItemStartNumber | Integer     | Required     | Specifies the (1-based) index of the first video to return the response. Use with item count to support pagination. ItemsStartNumber should be the index of the first result to return, based on the specified ItemCount. For example, assuming a specified ItemCount of 25, the following values of ItemStartNumber would be used: 1 (1st page), 26 (2nd page), 51 (3rd page), and so forth. |
| *ResultOptions*.SortOrder       | String      | Optional     | Specifies the order by which to sort the results. SortOrder may be specified when a single AssetFamily has been specified.<br>Possible values for Creative AssetFamily are:<br>• MostRecent<br>• BestMatch<br>Possible values for Editorial AssetFamily are:<br> • MostRecent<br> • MostPopular<br> • Trending |

###Response
The **SearchForVideos** JSON response has this form:

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
	  "SearchForVideosResult": {
		"Videos": [
		  {
			"AspectRatios": [""],
			"AssetFamily": "",
			"AssetId": "",
			"AuthorizationConstraints": [""],
			"Caption": "",
			"ClipLength": "",
			"CollectionId": "",
			"CollectionName": "",
			"Color": "",
			"Copyright": "",
			"DateCreated": "\/Date(1294868991374-0800)\/",
			"DownloadSizes": [
				{
					"Description": "",
					"Name": "",
					"DownloadAuthorizations": [
						{						
							"DownloadToken": ""
							"ProductOfferingInstanceId": ""
							"ProductOfferingType": ""
						}
					]
				}
			],
			"Era": "",
			"FilmMaker": "",
			"Keywords": [
			  {
				"KeywordId": "",
				"KeywordWeight": int,
				"Text": "",
				"Type": ""
			  }
			],
			"LicenseType": "",
			"MasteredTo": "",
			"OriginallyShotOn": "",
			"Release": "",
			"Restrictions": [""],
			"ShotSpeed": "",
			"Source": "",
			"Urls": {
			  "Comp": "",
			  "FlashPreview": "",
			  "StoryBoard": [
				{
					"ImageUrl": "",
					"SequenceNumber": int
				}
			  ],
			  "Thumb": ""
			}
		  }
		],
		"ItemCount": int,
		"ItemStartNumber": int,
		"ItemTotalCount": int,
	  }
	}

####ReponseHeader Fields
The ResponseHeader contains metadata about the operation execution and response.

| Field            | Type        | Description                                                                                                                   |
|:-----------------|:------------|:------------------------------------------------------------------------------------------------------------------------------|
| Status           | String      | Indicates the overall operation processing status notification. Possible values are: <br>• Success <br>• Error <br>• Warning  | 
| StatusList       | Collection  | Contains a *Status* entry for each detailed processing status notification.                                                   |
| Status *entry*   | Object      | Contains the details of a status notification                                                                                 |
| *Status*.Type    | String      | Indicates the type, or severity, of the status notification. Possible values are: <br>• Information <br>• Warning <br>• Error |
| *Status*.Code    | String      | Identifies the category of the status notification. See [StatusCodes][] for an explanations of the codes.        |
| *Status*.Message | String      | Provides a human readable explanation of the status.                                                                          |
| CoordinationId   | String      | Indicates the CoordinationId value provided in the triggering request.                                                        |

####SearchForVideosResult Fields
The SearchForVideosResult contains these fields.

| Field                                             | Type        | Description                                                                                  |
|:--------------------------------------------------|:------------|:---------------------------------------------------------------------------------------------|
| Videos                                            | Collection  | Contains a *Video* entry for each matching video found. | 
| Video *entry*                                     | Object      | Contains details of the specific matching video. | 
| *Video*.AspectRatios                              | Collection  | Contains an aspect ratio entry for each aspect ratio available for the video. | 
| AspectRatio *entry*                               | String      | Identifies the aspect ratio of the video. Possible values are:<br> • 16:9<br> • 4:3 | 
| *Video*.AssetFamily                               | String      | Identifies the asset family classification. Possible values are:<br> • Creative<br> • Editorial | 
| *Video*.AssetId                                   | String      | Identifies the video. | 
| *Video*.AuthorizationConstraints                  | Collection  | Contains an AuthorizationConstraint entry for each category of possible video-specific limitations to authorization. Authorization constraints occur when a video that would normally be authorized by a customer's agreement has additional limitations. |
| AuthorizationConstraint *entry*                   | String      | Contains an AuthorizationConstraint describing video-specific limitations to authorization. |
| *Video*.Caption                                   | String      | Describes the video. | 
| *Video*.ClipLength                                | String      | The length of the video. | 
| *Video*.CollectionId                              | String      | Identifies a collection to which the video belongs. | 
| *Video*.CollectionName                            | String      | Identifies the name of the collection to which the video belongs. | 
| *Video*.Color                                     | String      | Indicates where the video is color or black and white. Possible values are:<br>• Color<br>• BlackAndWhite | 
| *Video*.Copyright                                 | String      | Contains the copyright information of the video. | 
| *Video*.DateCreated                               | String      | Identifies the date the video was created. Date is in the format described at http://weblogs.asp.net/bleroy/archive/2008/01/18/dates-and-json.aspx. | 
| *Video*.DownloadSizes                             | Collection  | Contains a *DownloadSize* entry for each download size available for the video. | 
| DownloadSize *entry*                              | Object      | Contains DownloadSize details. | 
| *DownloadSize*.Description                        | String      | Describes the download size. | 
| *DownloadSize*.Name                               | String      | Identifies the name of the download size. | 
| *DownloadSize*.DownloadAuthorizations             | Collection  | Contains a *DownloadAuthorization* entry for each download authorization available for the download size. | 
| DownloadAuthorization *entry*                     | Object      | Contains authorization details specific to a product offering. | 
| *DownloadAuthorization*.DownloadToken             | String      | Provides the token needed to authorize the creation of a download request against the associated product offering. Use when calling CreateDownloadRequest. | 
| *DownloadAuthorization*.ProductOfferingInstanceId | String      | Identifies the product offering instance that authorizes the customer to download the video. Some products cannot have multiple instances, in which case this field has no value. | 
| *DownloadAuthorization*.ProductOfferingType       | String      | Identifies the category to which the product offering belongs. | 
| *Video*.Era                                       | String      | Identifies the era of the video. Possible values are:<br> • Archival<br> • Contemporary | 
| *Video*.FilmMaker                                 | String      | Identifies the video creator. | 
| *Video*.Keywords                                  | Collection  | Contains a *Keyword* entry for each keyword related to the video. |
| Keyword *entry*                                   | Object      | Contains keyword details. |
| *Keyword*.Id                                      | String      | Identifies the keyword. |
| *Keyword*.Text                                    | String      | Provides localized text of the keyword. |
| *Keyword*.Type                                    | String      | Identifies the type of keyword. |
| *Keyword*.Weight                                  | String      | Identifies the weight of the keyword. |
| *Video*.LicenseType                               | String      | Identifies a licensing model for the video. Possible values are:<br> • RightsManaged<br> • RightsReady<br> • RoyaltyFree | 
| *Video*.MasteredTo                                | String      | Identifies the media format, display resolution and frame rate that the video was shot on. | 
| *Video*.OriginallyShotOn                          | String      | Identifies the media format, bit rate, compression, display resolution and frame rate that the video was mastered to. | 
| *Video*.Release                                   | String      | Identifies the release information for the video. Possible values are:<br> • ModelAndPropertyReleased<br> • ModelReleased<br> • NoReleaseRequired<br> • NotReleased<br> • PartiallyReleased<br> • PropertyReleased | 
| *Video*.Restrictions                              | Collection  | Contains a Restriction entry for each video usage restriction, if any. | 
| Restriction *entry*                               | String      | Indicates a usage restriction. | 
| *Video*.ShotSpeed                                 | String      | Identifies the shot speed of the video. Possible values are:<br> • RealTime<br> • SlowMotion<br> • TimeLapse | 
| *Video*.Source                                    | String      | Identifies the source of the video. Source is only provided for Editorial videos. | 
| *Video*.Urls                                      | Object      | Contains URLs for the video. | 
| *Urls*.Thumb                                      | String      | Identifies the URL of the video, sized for a results grid. Thumbnail videos are smaller than preview and comp. | 
| *Urls*.FlashPreview                               | String      | Identifies the URL of the video in Flash format, sized for pop-up previews. Preview videos are larger than thumbnail but smaller than comp. | 
| *Urls*.Comp                                       | String      | Identifies the URL of the video, sized for layout composition. Comp videos are watermarked and are larger than preview and thumbnail, but not full-sized. We do not have non-watermarked comp videos at this time. | 
| *Urls*.StoryBoard                                 | Collection  | Contains a *StoryBoardItem* entry for each story board image available for the video. | 
| StoryBoardItem *entry*                            | Object      | Contains StoryBoardItem details for the story board image. | 
| *StoryBoardItem*.ImageUrl                         | String      | Identifies the image URL of the story board image item. | 
| *StoryBoardItem*.SequenceNumber                   | Integer     | Identifies the sequence number of the story board image item. | 
| ItemCount                                         | Integer     | Indicates the count of matching videos returned in the response. Use with ItemStartNumber to support pagination. | 
| ItemStartNumber                                   | Integer     | Indicates the (1-based) index of the first video returned in response. Used with ItemCount to support pagination. | 
| ItemTotalCount                                    | Integer     | Indicates the total number of videos matching the query, including those not returned with this response. | 


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

