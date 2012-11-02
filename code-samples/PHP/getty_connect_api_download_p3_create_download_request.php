<?php

// image ID for an angelina jolie image we know exists in the system
$imageIdArray = array(array("ImageId" => 137912016));

// build request to get largest available download of this image
$endpoint_largest_auth = "http://connect.gettyimages.com/v1/download/GetLargestImageDownloadAuthorizations";

// build array to query api for images
$imageAuthorizationArray = array (
	"RequestHeader" => array (
		"Token" => $secureToken
	),
	"GetLargestImageDownloadAuthorizationsRequestBody" => array (
 		"Images" => $imageIdArray
	)
);

// encode
$json = json_encode($imageAuthorizationArray);

$httpClient = new Zend_Http_Client($endpoint_largest_auth);
$httpClient->setRawData($json, 'application/json');
$httpClient->setMethod(Zend_Http_Client::POST); // all getty api requests are POST

// Zend_Http_Response
$response = $httpClient->request();

// evaluate for success response, get the body of data returned for download authorizatio
if ($response->isSuccessful()) {
	$largeDownloadAuthBody = json_decode($response->getBody()); // returns stdObject
}

// get the zero index image authorization item for the large download
$authorizationObject = $largeDownloadAuthBody->GetLargestImageDownloadAuthorizationsResult->Images[0]->Authorizations[0];
$downloadToken = $authorizationObject->DownloadToken;

$endpoint_create_download = "https://connect.gettyimages.com/v1/download/CreateDownloadRequest";

// build array to query api for images
$createDownloadArray = array (
	"RequestHeader" => array (
		"Token" => $secureToken // *NOTE: ensure a secure token is passed into this request
	),
	"CreateDownloadRequestBody" => array (
 		"DownloadItems" => array(array (
			"DownloadToken" => $downloadToken
 		))
	)
);

// encode
$json = json_encode($createDownloadArray);

$httpClient = new Zend_Http_Client($endpoint_create_download);
$httpClient->setRawData($json, 'application/json');
$httpClient->setMethod(Zend_Http_Client::POST); // all getty api requests are POST

// Zend_Http_Response
$response = $httpClient->request();

// evaluate for success response
if ($response->isSuccessful()) {
	$createDownloadBody = json_decode($response->getBody()); // returns stdObject
}

// get first download item for this example
$resourceUrl = $createDownloadBody->CreateDownloadRequestResult->DownloadUrls[0]->UrlAttachment;

// identify a resource to save the image to
$img = "newAsset_123.jpg";

// put the url contents into the image labeled above
file_put_contents($img, file_get_contents($resourceUrl));

?>