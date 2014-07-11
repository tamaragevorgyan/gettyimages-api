<?php

// grab  editorial "angelina jolie" image for this example
$endpoint_search = "http://connect.gettyimages.com/v1/search/SearchForImages";

// build array to query api for images
$searchImagesArray = array (
	"RequestHeader" => array (
		"Token" => $token
	),
	"SearchForImages2RequestBody" => array (
 		"Query" => array (
			"SearchPhrase" => "angelina jolie" // search for angelina jolie
 		),
 		"Filter" => array(
 			"ImageFamilies" => array("editorial") // specify only editorial image family here
 		),
  		"ResultOptions" => array (
			"IncludeKeywords" => "false",
 			"ItemCount" => 1, // return only 25 items
 			"ItemStartNumber" => 1 // 1-based int, start at the first image
 		)
	)
);

// encode
$json = json_encode($searchImagesArray);

$httpClient = new Zend_Http_Client($endpoint_search);
$httpClient->setRawData($json, 'application/json');
$httpClient->setMethod(Zend_Http_Client::POST); // all getty api requests are POST

// Zend_Http_Response
$response = $httpClient->request();

// evaluate for success response
if ($response->isSuccessful()) {
	$body = json_decode($response->getBody()); // returns stdObject
}

// get image array from the stdObject
$images = $body->SearchForImagesResult->Images;

// for each image (in this case, 1), pull the image details from the api and get the size key to send for authorizations
foreach ($images as $image) {
	$imageId = $image->ImageId;

	// build call for this image's details, where sizeKey resides
	$endpoint_imagedetails = "http://connect.gettyimages.com/v1/search/GetImageDetails";

	// build array to query api for images
	$imageDetailsArray = array (
		"RequestHeader" => array (
			"Token" => $token
		),
		"GetImageDetailsRequestBody" => array (
			"CountryCode" => "USA", // http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3#Current_codes
 			"ImageIds" => (is_array($imageId) ? $imageId : array($imageId)) // specify the image ID to get details from
 		)
	);

	// encode
	$json_imagedetails = json_encode($imageDetailsArray);

	// dispatch search, get body of response
	$imageDetailsBody = dispatchRequest($endpoint_imagedetails, $json_imagedetails);

	// get size key from the image details stdObject
	$imageDetails = $imageDetailsBody->GetImageDetailsResult->Images[0];
	$imageSizeKey = $imageDetails->SizesDownloadableImages[0]->SizeKey;

	// build request to download authorizations
	$endpoint_download_auth = "http://connect.gettyimages.com/v1/download/GetImageDownloadAuthorizations";

	// build array to query api for images
	$imageAuthorizationArray = array (
		"RequestHeader" => array (
			"Token" => $token
		),
		"GetImageDownloadAuthorizationsRequestBody" => array (
	 		"ImageSizes" => array(array (
				"ImageId" => $imageId,
				"SizeKey" => $imageSizeKey
	 		))
		)
	);

	// encode
	$json_download_auth = json_encode($imageAuthorizationArray);

	$httpClient = new Zend_Http_Client($endpoint_download_auth);
	$httpClient->setRawData($json_download_auth, 'application/json');
	$httpClient->setMethod(Zend_Http_Client::POST); // all getty api requests are POST

	// Zend_Http_Response
	$response = $httpClient->request();

	// evaluate for success response, get the body of data returned for download authorization
	if ($response->isSuccessful()) {
		$imageDownloadAuthBody = json_decode($response->getBody()); // returns stdObject
	}

	print_r($imageDownloadAuthBody);
}
?>