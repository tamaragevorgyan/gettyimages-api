## Release Notes

Getty Images Connect API Version 3.0

### New Features

- Simplified authentication and authorization. Client applications no longer need to maintain session tokens. Instead, applications identify themselves on every call to Connect with an Api-Key. Resources that require or support authorization based on user identity will accept OAuth2 access tokens in addition to the application’s Api-Key.
- RESTful API for working with image and metadata resources leveraging HTTP verbs and returning standard HTTP Status codes.
- Simplified image download process by providing direct download links in search and metadata resources.
- Interative documentation that is always up-to-date and in sync with our latest API functionality.

### Additional Notes

- This release provides a simplified download process. Prior Connect versions required at least two extra steps between receiving search results and downloading an image. Now clients can simply call the `https://connect.gettyimages.com/v3/downloads/{id}` endpoint with any valid image id and get back the largest available size of the image the user is authorized to receive.
- This release provides the following RESTful endpoints. These endpoints require SSL security. Visit the [interactive documentation](https://connect.gettyimages.com/swagger/ui/index.html) for more information.
	- Use these endpoints to search for images.
	    - `https://connect.gettyimages.com/v3/search/images?phrase={phrase}`
	    - `https://connect.gettyimages.com/v3/search/images/creative?phrase={phrase}`
	    - `https://connect.gettyimages.com/v3/search/images/editorial?phrase={phrase}`
    - Use this endpoint to retrieve metadata for a specific image.
    	- `https://connect.gettyimages.com/v3/images/{id}`
	- Use this endpoint to download an image. The largest available image file will be returned.
	    - `https://connect.gettyimages.com/v3/downloads/{id} endpoint to download images.`
        	- Additional parameters can be provided to specify the download size and product type to download against.
        	- The client application must provide an access token to authorize the download.
        	- You may not have authorization to download for some images in this release, as described above. In this case, v3 responds with HTTP status code 403 Forbidden and an empty response body.
