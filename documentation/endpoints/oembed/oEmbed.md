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

The oEmbed request returns JSON. If the *optional* "format" parameter is used it must contain the value "json". Other formats are not supported and using another value such as "xml" will result in a 501 (Not Implemented) error.

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
	  "height": int,
	  "thumbnail_url": string,
	  "thumbnail_height": int,
	  "thumbnail_width": int,
	  "terms_of_use_url": string
	}

Example response:

	{
		"type": "rich",
		"version": "1.0",
		"height": 643,
		"width": 395,
		"html": "\u003cdiv style=\"background-color:#fff;display:inline-block;font-family:'Helvetica Neue',Arial,sans-serif;color:#a7a7a7;font-size:11px;width:100%;max-width:395px;min-width:300px;\"\u003e\u003cdiv style=\"overflow:hidden;position:relative;height:0;padding:150.379747% 0 49px 0;width:100%;\"\u003e\u003ciframe src=\"//localhost:3000/embed/74917285?et=GCDFoeg3T3xB1L6jmY5dDQ\u0026sig=mXFz-gxQc_lIp2nmITlHtjjKIvYL1UD6e5yjuPDQ9FU=\" width=\"395\" height=\"643\" scrolling=\"no\" frameborder=\"0\" style=\"display:inline-block;position:absolute;top:0;left:0;width:100%;height:100%;\"\u003e\u003c/iframe\u003e\u003c/div\u003e\u003cp style=\"margin:0;\"\u003e\u003c/p\u003e\u003cdiv style=\"padding:0;margin:4px 0 0 10px;text-align:left;\"\u003e\u003ca href=\"http://www.gettyimages.com/detail/74917285\" target=\"_blank\" style=\"color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;\"\u003e#74917285\u003c/a\u003e / \u003ca href=\"http://www.gettyimages.com\" target=\"_blank\" style=\"color:#a7a7a7;text-decoration:none;font-weight:normal !important;border:none;display:inline-block;\"\u003egettyimages.com\u003c/a\u003e\u003c/div\u003e\u003c/div\u003e",
		"title": "Model Released Basketball",
		"caption": "Model Released: Two young men outdoors, one man holding basketball, portrait (Photo by Black 100/Getty Images)",
		"photographer": "Black 100",
		"collection": "Allsport Concepts",
		"thumbnail_url": "http://delivery.candidate-gettyimages.com/xt/74917285.jpg?v=1\u0026g=fs2|0|editorial3|17|285\u0026s=1",
		"thumbnail_height": "170",
		"thumbnail_width": "113",
		"terms_of_use_url": "http://www.gettyimages.com/Corporate/Terms.aspx"
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
