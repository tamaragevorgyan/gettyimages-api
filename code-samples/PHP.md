#PHP
---
### Note on this sample code

Please note the sample code assumes the following properties are set:

    $rootEndpoint = "https://connect.gettyimages.com";
    $client_key = "{Your Api Key}";
    $client_secret = "{Your Api Secret}";

The code also utilizes the [helper functions](#helper-functions) at the bottom of this file.  

### Authentication

An Api-Key header is needed to authenticate to the Api and will allow you access to read-only operations. The helper function to set the Api-Key header is:

    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

### Authorization

An Authorization header is required to perform download operations. The format of the header is the word **Bearer** followed by the token received from a call to oauth2/token as follows:

    /**
     * Authenticate with the OAuth2 client credentials flow
     */

    echo "**********Authenticate Client Credentials**********\n\n";
    $endpoint = $rootEndpoint."/oauth2/token";
    $curl = getCurlForFormPost($endpoint);
    setFormData($curl, array("grant_type" => "client_credentials",
                             "client_id" => $client_key,
                             "client_secret" => $client_secret));

    $resultObj = executeCurl($curl);
    $response = json_decode($resultObj['body'],true);

    $token = $response["access_token"];
    $tokenType = $response["token_type"];

    echo "Token Response: $token\n";

### Search

Use the authentication/authorization header option in the operations below depending on the operation used:

##### Images

    echo "**********Search For Images**********\n\n";
	$rootEndpoint = "https://connect.gettyimages.com";
    $endpoint = $rootEndpoint."/v3/search/images";
    $queryParams = array("phrase" => "kitties");
    $endpoint = $endpoint. (strpos($endpoint, '?') === FALSE ? '?' : ''). http_build_query($queryParams);

    $curl = getCurl($endpoint);
    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

    $response = json_decode(executeCurl($curl)['body'],true);

    echo "Images returned ". json_encode($response["images"]) . "\n\n\n";

##### Images Creative

    echo "**********Search For Images Creative**********\n\n";
	$rootEndpoint = "https://connect.gettyimages.com";
    $endpoint = $rootEndpoint."/v3/search/images/creative";
    $queryParams = array("phrase" => "kitties");
    $endpoint = $endpoint. (strpos($endpoint, '?') === FALSE ? '?' : ''). http_build_query($queryParams);

    $curl = getCurl($endpoint);
    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

    $response = json_decode(executeCurl($curl)['body'],true);

    echo "Images returned ". json_encode($response["images"]) . "\n\n\n";

##### Images Editorial

    echo "**********Search For Images Editorial**********\n\n";
	$rootEndpoint = "https://connect.gettyimages.com";
    $endpoint = $rootEndpoint."/v3/search/images/editorial";
    $queryParams = array("phrase" => "kitties");
    $endpoint = $endpoint. (strpos($endpoint, '?') === FALSE ? '?' : ''). http_build_query($queryParams);

    $curl = getCurl($endpoint);
    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

    $response = json_decode(executeCurl($curl)['body'],true);

    echo "Images returned ". json_encode($response["images"]) . "\n\n\n";

### Image Metadata

    echo "**********Search For Images Editorial**********\n\n";
	$rootEndpoint = "https://connect.gettyimages.com";
    $endpoint = $rootEndpoint."/v3/search/images/images/83454811,186239980";
    
    $curl = getCurl($endpoint);
    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

    $response = json_decode(executeCurl($curl)['body'],true);

    echo "Images returned ". json_encode($response["images"]) . "\n\n\n";

### Downloads

    echo "**********Download Image**********\n\n";
	$rootEndpoint = "https://connect.gettyimages.com";
    $imageIdToGet = 83454811;
    $endpoint = $rootEndpoint."/v3/downloads/".$imageIdToGet;

    $headersToSend = array(CURLOPT_HTTPHEADER => array("Api-Key:".$client_key,
                           "Authorization: ".$tokenType." ".$token),
                            CURLOPT_PROXY => "127.0.0.1:8888",
                            CURLOPT_FOLLOWLOCATION => TRUE); //this lets curl follow the 303

    $curl = getCurlForPost($endpoint,$headersToSend);
    $response = executeCurl($curl);

    echo "Download Code: ".$response["http_code"] . "\n";
    echo "Download Headers: ".$response['header'] . "\n";

### Helper Functions

##### executeCurl

	function executeCurl($curl) {
	    $response = curl_exec($curl);
	
	    $error = curl_error($curl);
	    $result = array( 'header' => '', 
	                     'body' => '', 
	                     'curl_error' => '', 
	                     'http_code' => '',
	                     'last_url' => '');
	    if ( $error != "" )
	    {
	        $result['curl_error'] = $error;
	        return $result;
	    }
	
	    $header_size = curl_getinfo($curl,CURLINFO_HEADER_SIZE);
	    $result['header'] = substr($response, 0, $header_size);
	    $result['body'] = substr( $response, $header_size );
	    $result['http_code'] = curl_getinfo($curl,CURLINFO_HTTP_CODE);
	    $result['last_url'] = curl_getinfo($curl,CURLINFO_EFFECTIVE_URL);
	    curl_close($curl);
	    return $result;
	}

##### getCurl

    function getCurl($url, array $options = null) {
	    $defaults = array(
	      CURLOPT_RETURNTRANSFER => 1,
	      CURLOPT_HEADER => 1,
	      CURLOPT_SSL_VERIFYHOST => 0,
	      CURLOPT_SSL_VERIFYPEER => 0
	      );
	
	    if(!$options) {
	      $curlOptions = $defaults;
	    } else {
	      $curlOptions = mergeCurlOptions($defaults, $options);
	    }
	
	    $curl = curl_init($url);
	    curl_setopt_array($curl, $curlOptions);
	
	    return $curl;
	}

##### getCurlForFormPost
	
    function getCurlForFormPost($url) {
	
	    $curlOptions = array(CURLOPT_HTTPHEADER => array("Content-Type: application/x-www-form-urlencoded")); 
	    $curl = getCurlForPost($url,$curlOptions);
	
	    return $curl;
	}

##### getCurlForPost	

    function getCurlForPost($url,array $options = null) {
	    $defaults = array(
	        CURLOPT_POST => 1
	      );
	
	    $curlOptions = mergeCurlOptions($defaults,$options);
	    return getCurl($url, $curlOptions);
	  }

##### setFormData

    function setFormData($curl,$params) {
	    $params = http_build_query($params);
	    curl_setopt($curl, CURLOPT_POSTFIELDS, $params);
	    return $curl;
    }
	
##### mergeCurlOptions

	function mergeCurlOptions(array $defaults, array $optionsToAdd) {
	    if(!$optionsToAdd) {
	      return $defaults;
	    }
	
	    if(array_key_exists(CURLOPT_HTTPHEADER,$optionsToAdd)) {    
	      if(array_key_exists(CURLOPT_HTTPHEADER, $defaults)) {
	        $defaultHeaders = $defaults[CURLOPT_HTTPHEADER];
	        $additionalHeaders = $optionsToAdd[CURLOPT_HTTPHEADER];
	
	        $mergedHeaders = $defaultHeaders + $additionalHeaders;
	        $defaults[CURLOPT_HTTPHEADER] = $mergedHeaders;
	        unset($optionsToAdd[CURLOPT_HTTPHEADER]);
	      }
	    }
	
	    $mergedOptions = $defaults + $optionsToAdd;
	
	    return $mergedOptions;
    }