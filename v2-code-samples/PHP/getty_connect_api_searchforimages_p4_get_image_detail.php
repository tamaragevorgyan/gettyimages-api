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
 			"ItemCount" => 1, // get only one image for this example
 			"ItemStartNumber" => 1
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

// endpoint url for GetImageDetails
$imagedetails_endpoint = "http://connect.gettyimages.com/v1/search/GetImageDetails";

// iterate through the array of image stdObjects
foreach ($images as $image) {

	// get the image ID
	$imageId = $image->ImageId;

	// build array to query api for images
	$imageDetailsArray = array (
		"RequestHeader" => array (
			"Token" => $token // Token received from a CreateSession/RenewSession API call
		),
		"GetImageDetailsRequestBody" => array (
			"CountryCode" => "USA", // http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3#Current_codes
 			"ImageIds" => array($imageId) // specify the image ID to get details from
 		)
	);

	// encode
	$json = json_encode($imageDetailsArray);

	// dispatch search, get body of response
	$imageDetailsBody = dispatchRequest($imagedetails_endpoint, $json);

	// dump contents of image details to the console for sake of example
	print_r($imageDetailsBody);
}

// ALTERNATIVELY, IF THERE IS MORE THAN 1 IMAGE

$imageIdArray = array();

foreach ($images as $image) {

	// get the image ID
	$imageIdArray[] = $image->ImageId;
}

// build array to query api for images
$imageDetailsArray = array (
	"RequestHeader" => array (
		"Token" => $token // Token received from a CreateSession/RenewSession API call
	),
	"GetImageDetailsRequestBody" => array (
		"CountryCode" => "USA", // http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3#Current_codes
 		"ImageIds" => $imageIdArray // specify the image ID to get details from
 	)
);

// encode
$json = json_encode($imageDetailsArray);

// dispatch search, get body of response
$imageDetailsBody = dispatchRequest($imagedetails_endpoint, $json);

// dump contents of image details to the console for sake of example
print_r($imageDetailsBody);
?>