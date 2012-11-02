<?php

// search string, let's look up "tree"
$searchPhrase = "tree";

// build array to query api for images
$searchImagesArray = array (
	"RequestHeader" => array (
		"Token" => $token // Token received from a CreateSession/RenewSession API call
	),
	"SearchForImages2RequestBody" => array (
 		"Query" => array (
			"SearchPhrase" => $searchPhrase
 		),
 		"ResultOptions" => array (
			"IncludeKeywords" => "false",
 			"ItemCount" => 25, // return 25 items
 			"ItemStartNumber" => 26 // 1-based int, start on the 2nd page
 		)
	)
);

// encode to json
$json = json_encode($searchImagesArray);

$endpoint = "http://connect.gettyimages.com/v1/search/SearchForImages";

// create client and set json data and datatype
$httpClient = new Zend_Http_Client($endpoint);
$httpClient->setRawData($json, 'application/json');
$httpClient->setMethod(Zend_Http_Client::POST); // all getty api requests are POST

// returns Zend_Http_Response
$response = $httpClient->request();

$body = null;

// evaluate for success response
if ($response->isSuccessful()) {
	$body = json_decode($response->getBody()); // returns stdObject
} else {
	// report error
}

// retrieves the image array of stdObjects
$images = $body->SearchForImagesResult->Images;

// iterate through the array of image stdObjects
foreach ($images as $image) {

	// get the image ID
	$imageId = $image->ImageId;

	// get caption of image
	$caption = $image->Caption;

	// get url of the image comp
	$urlComp = $image->UrlComp;

	// get the url of the image thumbnail
	$urlThumb = $image->UrlThumb;

	// print the values for sake of example
	echo "Caption: " . $caption . PHP_EOL;
	echo "Url Comp: " . $urlComp . PHP_EOL;
	echo "Url Thumb: " . $urlThumb . PHP_EOL;
}

?>