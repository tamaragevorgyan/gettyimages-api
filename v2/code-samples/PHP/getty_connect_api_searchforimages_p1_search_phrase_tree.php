<?php

	$url = "http://connect.gettyimages.com/v1/search/SearchForImages";

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
	       "ItemStartNumber" => 1 // 1-based int, start at the first page
	     )
	  )
	);


	$content = json_encode($searchImagesArray);

	$curl = curl_init($url);
	curl_setopt($curl, CURLOPT_HEADER, false);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_HTTPHEADER,
	        array("Content-type: application/json"));
	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $content);

	$json_response = curl_exec($curl);

	$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);

	if ( $status != 201 ) {
	    die("Error: call to URL $url failed with status $status, response $json_response, curl_error " . curl_error($curl) . ", curl_errno " . curl_errno($curl));
	}


	curl_close($curl);

	$response = json_decode($json_response, true);
?>
