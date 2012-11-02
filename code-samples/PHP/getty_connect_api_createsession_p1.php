<?php

/**
 * Requires Zend library
 */

// set params
$endpoint = "https://connect.gettyimages.com/v1/session/CreateSession";
$systemId = "systemId";
$systemPassword = "systemPassword";
$userName = "userName";
$userPassword = "userPassword";
$token = null;

// create array of data for request
$createSessionArray = array(
	"RequestHeader" => array(
		"Token" => "",
		"CoordinationId" => ""
	),
	"CreateSessionRequestBody" => array(
		"SystemId" => $systemId,
		"SystemPassword" => $systemPassword,
		"UserName" => $userName,
		"UserPassword" => $userPassword,
		"RememberedUser" => "false"
	)
);

// encode data to json (requires PHP 5.2 or greater, if using earlier use PEAR's Service_JSON)
$json = json_encode($createSessionArray);

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
	$token = $body->CreateSessionResult->Token;

	// or retrieve secure token
	$token = $body->CreateSessionResult->SecureToken;
}

return $token;
?>
