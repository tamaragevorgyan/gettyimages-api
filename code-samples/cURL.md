
#cURL
---
### Authentication 

    client_id = Mashery API Key
    client_secret = Mashery API Secret
    
    curl -d 'grant_type=client_credentials&client_id={apikey}&client_secret={apisecret}' https://connect.gettyimages.com/oauth2/token

#### Operation Header Definitions
Api-Key header is needed to go through Mashery and will allow you to do read only type operations. The following header is required for all operations:

    -H "Api-Key:{Your API Key}"

Authorization header is required to perform download operations, as well as getting certain user specific fields in searches. The input after **Bearer** is the token received from the oauth2/token call. 

    -H "Authorization: Bearer {Your Token}"
### Search
##### Images
    curl {headers} https://connect.gettyimages.com/v3/search/images?phrase=kitties
##### Images Creative
    curl {headers} https://connect.gettyimages.com/v3/search/images/creative?phrase=kitties
##### Images Editorial
    curl {headers} https://connect.gettyimages.com/v3/search/images/editorial?phrase=kitties
##### Paging Results
    curl {headers} https://connect.gettyimages.com/v3/search/images?phrase=kitties&page=1&page-size=10
### Image Metadata
NOTE: Some shells may require you to quote the url

    curl {headers} https://connect.gettyimages.com/v3/images/83454811,186239980
### Downloads
NOTE: This operation requires an Authorization Header

	curl -H "Api-Key:{mashery_apikey}" -H "Authorization: Bearer {access_token}" https://connect.gettyimages.com/v3/downloads/83454811 -d "'" -L -o 83454811.jpg

