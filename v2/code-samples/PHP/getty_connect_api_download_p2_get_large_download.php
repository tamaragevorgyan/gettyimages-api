<?php

$imageIdArray = array();

// assume we have "images", collect the imageIds in an array of associated arrays, labeled explicitely "ImageId"
foreach ($images as $image) {
	$imageIdArray[] = array("ImageId" => $image->ImageId);
}

// build request to get largest available download of this image
$endpoint_largest_auth = "http://connect.gettyimages.com/v1/download/GetLargestImageDownloadAuthorizations";

// build array to query api for images
$imageAuthorizationArray = array (
	"RequestHeader" => array (
		"Token" => $token
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

// dump the data to console for examination
print_r($largeDownloadAuthBody);

?>