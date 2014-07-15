
#cURL
---

### Authentication

An Api-Key header is needed authenticate to the API and will allow you access to read-only operations. The curl option for setting the Api-Key header is:

    -H "Api-Key:{Your API Key}"

### Authorization 

An Authorization header is required to perform download operations. The format of the header is the word **Bearer** followed by the token received from a call to oauth2/token as follows:
	
	curl -d 'grant_type=client_credentials&client_id={ApiKey}&client_secret={ApiSecret}' https://connect.gettyimages.com/oauth2/token

The curl option for setting the Authorization header is:
    
	-H "Authorization: Bearer {Your Token}"

### Search

Use the authentication/authorization header option in the operations below depending on the operation used:

##### Images
    curl {headers} https://connect.gettyimages.com/v3/search/images?phrase=kitties
##### Images Creative
    curl {headers} https://connect.gettyimages.com/v3/search/images/creative?phrase=kitties
##### Images Editorial
    curl {headers} https://connect.gettyimages.com/v3/search/images/editorial?phrase=kitties
##### Paging Results
    curl {headers} https://connect.gettyimages.com/v3/search/images?phrase=kitties&page=1&page-size=10
### Image Metadata
NOTE: Some command line tools may require you to quote the url

    curl {headers} https://connect.gettyimages.com/v3/images/83454811,186239980
### Downloads
NOTE: This operation requires an Authorization Header

	curl -H "Api-Key:{Your API key}" -H "Authorization: Bearer {Your Token}" https://connect.gettyimages.com/v3/downloads/83454811 -d "'" -L -o 83454811.jpg