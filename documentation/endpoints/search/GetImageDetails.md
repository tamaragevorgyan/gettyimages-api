GetImageDetails
---------------
The GetImageDetails call returns the detailed image metadata for all specified images.

###GetImageDetails vs. [SearchForImages][]
You may wonder why [SearchForImages][] returns only a subset of the image 
metadata available from GetImageDetails. The differences in the two calls are 
intended to support the most common user workflow. [SearchForImages][] supports 
finding an image that matches the selected criteria. GetImageDetails assumes you 
have found some possible matches via [SearchForImages][], but you want to know 
more about a particular image to help you decide whether to download it.

###Image Sizes 
Due to a wide variety of available image resolutions, the images are grouped into a 
handful of size categories for simplicity. This operation returns size information 
about each image, including a sizekey which you can use used when requesting 
authorization to download the image.

###Endpoint
Use the following endpoint to access this operation:

	http://connect.gettyimages.com/v1/search/GetImageDetails

###Request
The GetImageDetails JSON request has this form:

	{
	  "RequestHeader": {
	    "Token": "",
	    "CoordinationId": ""
	  },
	  "GetImageDetailsRequestBody": {
	    "ImageIds": [
	      ""
	    ],
	    "Language": ""
	  }
	}

####RequestHeader Fields
The RequestHeader specifies metadata about the request.

| Field          | Type        | Use          | Description                                                                               |
|:---------------|:------------|:-------------|:------------------------------------------------------------------------------------------|
| Token          | String      | Required     | Specify the secure authentication token provided by [CreateSession][].                        | 
| CoordinationId | String      | Optional     | Specify a value to echo in the response to track requests and their associated responses. |

####GetImageDetailsRequestBody Fields
The GetImageDetailsRequestBody contains the request arguments.

| Field 		| Type		| Use 	 	| Description 																	|
|:--------------|:----------|:----------|:------------------------------------------------------------------------------|
| ImageId 		| Collection| Required 	| Specifies the Id entry of an event for which you want details in the result. 	|
| ImageId entry | String 	| Required 	| Adds an ImageId entry for each image for which details are in the results.	|
| Language 		| String 	| Optional 	| Specifies an IETF RFC 5646 compliant language tag to determine the language used for localizable strings returned in the response. Defaults to “en-US” if no value provided.|

###Response
The GetImageDetails JSON response has this form:

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
	  "GetImageDetailsResult": {
	    "Images": [
	      {
	        "ApplicableProductOfferings": [
	          ""
	        ],
	        "Artist": "",
	        "ArtistTitle": "",
	        "Caption": "",
	        "City": "",
	        "CollectionId": "",
	        "CollectionName": "",
	        "ColorType": "",
	        "Copyright": "",
	        "Country": "",
	        "CreditLine": "",
	        "DateCreated": "\/Date(1297286970531-0800)\/",
	        "DateSubmitted": "\/Date(1297286970531-0800)\/",
	        "EditorialSegments": [
	          ""
	        ],
	        "EditorialSourceId": "",
	        "EditorialSourceName": "",
	        "EventId": int,
	        "EventIds": [
	          int
	        ],
	        "GraphicStyle": "",
	        "ImageFamily": "",
	        "ImageId": "",
	        "Keywords": [
	          {
	            "Id": "",
	            "Text": ""
	          }
	        ],
	        "LicensingModel": "",
	        "QualityRank": int,
	        "ReferralDestinations": [
          		{
            	  "SiteName": "",
             	  "Url": ""
          		}
        	],
	        "ReleaseMessage",
	        "Restrictions": [
	          ""
	        ],
	        "SizesDownloadableImages": [
	          {
	            "FileSizeInBytes": int,
	            "InchesHeight": double,
	            "InchesWidth": double,
	            "PixelHeight": int,
	            "PixelWidth": int,
	            "ResolutionDpi": int,
	            "SizeKey": ""
	          }
	        ],
	        "StateProvince": "",
	        "Title": "",
	        "UrlComp": "",
	        "UrlPreview": "",
	        "UrlThumb": "",
	        "UrlWatermarkComp": "",
	        "UrlWatermarkPreview": ""
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

####GetImageDetailsResult Fields 
The GetImageDetailsResult contains these fields.

| Field 			| Type        	 | Description                                                                                                                   |
|:------------------|:---------------|:------------------------------------------------------------------------------------------------------------------------------|
| Images							 | Collection	| Contains an image entry for each matching image found.														|
| Image _entry_						 | Object 		| Contains details of the specific matching image.																|
| _Image_.ApplicableProductOfferings | Collection 	| Contains an ApplicableProductOffering entry for each of the customer’s product offerings that authorize access to the image. If empty, the customer is not authorized to access the image. <br>**Note:** Also check the AuthorizationConstraints collection for possible image specific limitations to the authorization. |
| ApplicableProductOffering _entry_	| String | Indicates a customer’s product offering that authorizes access to the image. Possible values are: <br>• EasyAccess <br>• EditorialSubscription <br>• PremiumAccess <br>• RoyaltyFreeSubscription <br>• Imagepack |
| _Image_.Artist |	String 	| Identifies the image creator. |
| _Image_.Caption |	String 	| Describes the image.|
| _Image_.City |	String 	| Indicates the city where the image was created.|
| _Image_.CollectionID | String 	| Identifies a collection to which the image belongs. |
| _Image_.CollectionName | String 	| Identifies the name of the collection to which the image belongs. |
| _Image_.ColorType | String 	| Indicates where the image is color or black and white. Possible values are: <br>• color <br>• black/white |
| _Image_.Copyright | String 	| Indicates copyright of the image. |
| _Image_.Country | String 	| Indicates the country where the image was created. |
| _Image_.CreditLine | String 	| Indicates the credit line of the image. |
| _Image_.DateCreated | String 	| Identifies the date the image was created. Date is in the format described at http://weblogs.asp.net/bleroy/archive/2008/01/18/dates-and-json.aspx. |
| _Image_.DateSubmitted | String 	| Identifies the date the image was created. Date is in the format described at http://weblogs.asp.net/bleroy/archive/2008/01/18/dates-and-json.aspx.|
| _Image_.EditorialSegments | Collection 	| Contains an EditorialSegment entry for each editorial category to which the image belongs, if the image is in the editorial image family. |
| EditorialSegment_entry_ | String 	| Indicates the editorial category to which the image belongs, if the image is in the editorial image family. Possible values are: <br>• News <br>• Sport <br>• Entertainment <br>• Contour <br>• Travel <br>• Publicity <br>• Royalty <br>• Archival |
| _Image_.EditorialSourceId | String 	| Identifies the source of the image, if the image is in the editorial image family.|
| _Image_.EditorialSourceName | String 	| The source name of the image, if the image is in the editorial image family.|
| _Image_.EventId | Integer 	| DEPRECATED: The primary EventId associated with the image. Please use EventIds instead. |
|_Image_.EventIds|Collection|Contains an EventId entry for each event associated with the image. All editorial image family images have event Ids. Some creative image family images may have event Ids.|
| _Image_.GraphicStyle | String 	| Indicates the graphic style of the image. Possible values are: <br>• Photograph <br>• Illustration|
| _Image_.ImageFamily | String 	| Indicates the image family classification. Possible values are: <br>• Creative <br>• Editorial |
| _Image_.ImageId | String 	| Identifies the image. |
| _Image_.Keywords | Collection 	| Contains a keyword entry for each keyword related to the image. |
| Keyword _entry_ | Object 	| Contains keyword details. |
| Keyword.Id | String 	| Identifies the keyword. |
| Keyword.Text | String 	| Provides localized text of the keyword. |
| Keyword.Type | String 	| Identifies the type of keyword. Possible values are: <br>• Unknown <br>• Specific people <br>• Ethnicity <br>• Age <br>• Gender <br>• Number of People <br>• Concept <br>• Location <br>• Viewpoint <br>• Image technique <br>• Composition <br>• Color <br>• Additional Info <br>• Candidate Term <br>• Fashion Phrases <br>• Entertainment |
| _Image_.LicensingModel | String 	| Identifies a licensing model for the image. Possible values are: <br>• RoyaltyFree <br>• RightsManaged |
| _Image_.QualityRank | Integer 	| Assigned to editorial images to rank their relevance to the event they belong to. This number has no relevance for creative images even though it does appear in the metadata. Possible values are: <br>• 1  -  most  relevant <br>• 2 - tells story from a wider perspective <br>• 3 - stock/repeats/less important |
| _Image_.ReferralDestinations | Collection 	| Contains a ReferralDestination entry for each of the sites on which the image can be found. |
| SiteName _entry_ | String 	| Indicates the name of the website on which the image can be found. Possible values are: <br>• gettyimages <br>• thinkstock <br>• jupiterimages <br>• photos |
| Url _entry_ | String 	| Indicates the specific URL for the page on which the images can be found. |
| _Image_.ReleaseMessage | String 	| Provides a localized message indicating the release or commercial use status of the image.|
| _Image_.Restrictions | Collection 	| Contains a Restriction entry for each image usage restriction, if any.|
| Restriction _entry_ | String 	| Indicates a usage restriction. |
| _Image_.SizesDownloadableImages | Collection 	| Contains an ImageSize entry for each downloadable image size. |
| _Image_.SizesDownloadableImages | Collection 	| Contains an ImageSize entry for each downloadable image size. |
| _Image_.Title |	String 	| Indicates the image title given by the artist.|
| _ImageSize_.FileSizeInBytes | Integer | Indicates the image file size in bytes. |
| _ImageSize_.InchesHeight | Double | Indicates the image height in inches when the image is rendered at the indicated ResolutionDpi. |
| _ImageSize_.InchesWidth | Double | Indicates the image width in inches when the image is rendered at the indicated ResolutionDpi. |
| _ImageSize_.PixelHeight | Integer | Indicates the image pixel height. |
| _ImageSize_.PixelWidth | Integer | Indicates the image pixel width. |
| _ImageSize_.ResolutionDpi | Integer | Indicates the image DPI for the assumed target presentation format such as print vs. web. |
| _ImageSize_..SizeKey | String | Provides the key values to specify the image size to authorize for download. Used when calling GetImageDownloadAuthorizations.|
| _Image_.StateProvince | String 	| Indicates the state or province where the image was created. |
| _Image_.Title | String 	| Indicates the image title. |
| _Image_.UrlComp | String 	| Identifies the URL of the image, sized for layout composition. Comp images are larger than preview and thumbnail but not full sized. |
| _Image_.UrlPreview | String 	| Identifies the URL of the image, sized for pop-up previews. Preview images are larger than thumbnail but smaller than comp. |
| _Image_.UrlThumb | String 	| Identifies the URL of the image, sized for a results grid. Thumbnail images are smaller than preview and comp. |
| _Image_.UrlWatermarkComp | String 	| Identifies the URL of the image, sized for layout composition, with a Getty Images watermark. Comp images are larger than preview and thumbnail, but not full-sized.|
| _Image_.UrlWatermarkPreview | String 	| Identifies the URL of the image, sized for pop-up previews, with a Getty Images watermark.  Preview images are larger than thumbnail, but smaller than comp.|

###Workflow Example
1. Call [CreateSession][] with system and user credentials to create an authentication token.
2. Call [SearchForImages][] to find images.
3. Call GetImageDetails, providing ImageIds from search results, to retrieve image details for the specified images.


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

