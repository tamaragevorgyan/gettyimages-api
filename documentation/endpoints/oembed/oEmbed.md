Getty Images Embed using oEmbed
================================

What is oEmbed?
--------------
oEmbed is a format for allowing an embedded representation of a URL on third party sites. The simple API allows a website to display embedded content (such as photos or videos) when a user posts a link to that resource, without having to parse the resource directly.

Full documentation and various client libraries for the oEmbed specification can be found here: http://oembed.com


###Endpoint
Use the following endpoints to access this operation:

	http://embed.gettyimages.com/oembed


###Request
The oEmbed request is a GET with the following required parameter. Note: URL encode query string parameters.

	url: http://gty.im/[asset-id]

In addition, you should use the optional caller parameter, providing descriptive value identifying your application.

	caller: example.com

The oEmbed request returns JSON. If the following *optional* parameter is used it must contain the value "json". Other formats are not supported and using another value will result in a 501 (Not Implemented) error.

Example request:

	http://embed.gettyimages.com/oembed?url=http%3a%2f%2fgty.im%2f74917285&caller=example.com


###Response
The oEmbed JSON response has this form, per the oEmbed specification:

	{
	  "type": string,
	  "version": string,
	  "title": string,
	  "caption": string,
	  "photographer": string,
	  "collection": string,
	  "html": string,
	  "width": int,
	  "height": int
	}

Example response:

	{
		"type": "rich",
		"version": "1.0",
		"height": 671,
		"width": 395,
		"html": "\u003ciframe src=\"//embed.gettyimages.com/embed/74917285?et=Sy31TwnCsUidwFt4lNEpsg\u0026sig=kTSM-y0tMHIhx5WddhODZxKSHZtb7M7ApI0fOBx9nkA=\" width=\"400\" height=\"671\" frameborder=\"0\" scrolling=\"no\"\u003e\u003c/iframe\u003e",
		"title": "Model Released Basketball",
		"caption": "Model Released: Two young men outdoors, one man holding basketball, portrait (Photo by Black 100/Getty Images)",
		"photographer": "Black 100",
		"collection": "Allsport Concepts"
	}

####Workflow example: oEmbed
1. Find embeddable images on www.gettyimages.com (see embed.gettyimages.com for more information)
2. Call oEmbed using the asset id of the embeddable image that you wish to use.

####Workflow example: Connect client using oEmbed
1. Call [CreateSession][] or [OAuth][] with system/key and user credentials to create an authentication token.
2. Call [SearchForImages][] to find images specifying the search is for embeddable images only, by adding the Filter property EmbedContentOnly (boolean) within the SearchForImagesRequestBody.
3. Call oEmbed with each of the asset ids of the embeddable images that you wish to use.

[CreateSession]: ../session/CreateSession.md
[CreateApplicationSession]: ../session/CreateApplicationSession.md
[SearchForImages]: ../search/SearchForImages.md
[OAuth]: ../oauth2/README.md
