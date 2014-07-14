#### Getty Images Connect Version 3 provides four new features: ####

- A simplified image downloads process.
- A simplified API for working with image and metadata resources using RESTful concepts such as leveraging HTTP verbs and returning standard HTTP Status codes.
- Simplified authentication and authorization. Client applications no longer need to maintain session tokens. Instead, applications identify themselves on every call to Connect with an api key, and resources that require or support authorization based on user identity will accept OAuth2 access tokens in addition to the application’s api key.
- A Swagger page for documenting and interactively demonstrating the results of RESTful actions.  Swagger is always up-to-date and in sync with our latest API functionality.

#### Notes: ####

- Version 3  provides a simplified download process. The prior process required at least two extra steps between receiving search results and downloading an image. Now clients can simply call the /downloads/{image-id} endpoint with any valid image id and get back the largest available size of the image the user is authorized to receive.
- Version 3 provides the following RESTful endpoints. These endpoints require SSL security. Visit the Swagger page https://connect.gettyimages.com/swagger/ui/index.html for more information.
- Images Resource
	- Use the https://connect.gettyimages.com/cr1/images?phrase= endpoint to search for images.
	- Use the https://connect.gettyimages.com/cr1/images/{id} endpoint to retrieve metadata for a specific image.
	- This release does not yet support user authorization context on these two endpoints. Consequently, image search may return results for which the user is not authorized to download.
- Downloads Resource
	- Use the https://connect.gettyimages.com/cr1/downloads/{id} endpoint to download images. The largest available image file will be returned.
	- The client application must provide an access token to authorize the download.
	- You may not have authorization to download for some images in this release, as described above. In this case, v3 responds with HTTP status code 403 Forbidden and an empty response body.
