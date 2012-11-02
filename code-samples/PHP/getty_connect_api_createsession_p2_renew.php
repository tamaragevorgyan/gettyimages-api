<?php

/**
 * Requires Zend library
 */

// set params
$endpoint = "https://connect.gettyimages.com/v1/session/RenewSession";
$systemId = "systemId";
$systemPassword = "systemPassword";
$oldToken = "oldToken";
$newToken = null;

// create array of data for request
$renewSessionArray = array(
	"RequestHeader" => array(
		"Token" => $oldToken,
		"CoordinationId" => ""
	),
	"RenewTokenRequestBody" => array(
		"SystemId" => $systemId,
		"SystemPassword" => $systemPassword
	)
);

// encode array to json
$json = json_encode($renewSessionArray);

// create Zend_Http_Client, set JSON data and type, set method to POST
$httpClient = new Zend_Http_Client($endpoint);
$httpClient->setRawData($json, 'application/json');
$httpClient->setMethod(Zend_Http_Client::POST); // all getty api requests are POST

// Dispatch request, returns Zend_Http_Response
$response = $httpClient->request();

// evaluate for success response
if ($response->isSuccessful()) {
	$body = json_decode($response->getBody()); // returns stdObject array
}

if ($body) {
	// retrieve normal token
	$newToken = $body->RenewSessionResult->Token;

	// or retrieve secure token
	$newToken = $body->RenewSessionResult->SecureToken;
}

return $newToken;

?>