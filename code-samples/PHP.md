#PHP
### Note on this sample code

Please note the sample code assumes the following properties are set:

    $client_key = "{your-api-key}";
    $client_secret = "{your-api-secret}";

The code also utilizes the [helper functions](#helper-functions) at the bottom of this file.  

#### A few things about Curl Settings
For troubleshooting purposes there are a few settings that can be used to configure curl.  All these settings go into the CURLOPT_HEADER php array.

##### You need a Proxy?

    //this will set curl to use a local proxy on port 8888s
    CURLOPT_PROXY => "127.0.0.1:8888"

##### SSL Errors? 
Testing localy or proxy server with HTTPS passthrough and you're getting ssl validation errors?

    CURLOPT_SSL_VERIFYHOST => 0
    CURLOPT_SSL_VERIFYPEER => 0

### Authentication

An Api-Key header is needed to authenticate to the Api and will allow you access to read-only operations. The helper function to set the Api-Key header is:

    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

### Authorization

An Authorization header is required to perform download operations. The format of the header is the word **Bearer** followed by the token received from a call to oauth2/token as follows:

    /**
     * Authenticate with the OAuth2 client credentials flow
     */

    echo "**********Authenticate Client Credentials**********\n\n";
    $endpoint = "https://connect.gettyimages.com/oauth2/token";
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
    $endpoint = "https://connect.gettyimages.com/v3/search/images";
    $queryParams = array("phrase" => "kitties");
    $endpoint = $endpoint. (strpos($endpoint, '?') === FALSE ? '?' : ''). http_build_query($queryParams);

    $curl = getCurl($endpoint);
    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

    $response = json_decode(executeCurl($curl)['body'],true);

    echo "Images returned ". json_encode($response["images"]) . "\n\n\n";

##### Images Creative

    echo "**********Search For Images Creative**********\n\n";
    $endpoint = "https://connect.gettyimages.com/v3/search/images/creative";
    $queryParams = array("phrase" => "kitties");
    $endpoint = $endpoint. (strpos($endpoint, '?') === FALSE ? '?' : ''). http_build_query($queryParams);

    $curl = getCurl($endpoint);
    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

    $response = json_decode(executeCurl($curl)['body'],true);

    echo "Images returned ". json_encode($response["images"]) . "\n\n\n";

##### Images Editorial

    echo "**********Search For Images Editorial**********\n\n";
    $endpoint = "https://connect.gettyimages.com/v3/search/images/editorial";
    $queryParams = array("phrase" => "kitties");
    $endpoint = $endpoint. (strpos($endpoint, '?') === FALSE ? '?' : ''). http_build_query($queryParams);

    $curl = getCurl($endpoint);
    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

    $response = json_decode(executeCurl($curl)['body'],true);

    echo "Images returned ". json_encode($response["images"]) . "\n\n\n";

### Image Metadata

    echo "**********Search For Images Editorial**********\n\n";
    $endpoint = "https://connect.gettyimages.com/v3/search/images/images/83454811,186239980";
    
    $curl = getCurl($endpoint);
    curl_setopt($curl,CURLOPT_HTTPHEADER,array("Api-Key:".$client_key));

    $response = json_decode(executeCurl($curl)['body'],true);

    echo "Images returned ". json_encode($response["images"]) . "\n\n\n";

### Downloads

    echo "**********Download Image**********\n\n";
    $imageIdToGet = 83454811;
    $endpoint = "https://connect.gettyimages.com/v3/downloads/".$imageIdToGet;

    $headersToSend = array(CURLOPT_HTTPHEADER => array("Api-Key:".$client_key,
                           "Authorization: ".$tokenType." ".$token),
                            CURLOPT_FOLLOWLOCATION => TRUE); //this lets curl follow the 303

    $curl = getCurlForPost($endpoint,$headersToSend);
    $response = executeCurl($curl);

    echo "Download Code: ".$response["http_code"] . "\n";
    echo "Download Headers: ".$response['header'] . "\n";

### Collections

Use the authentication/authorization header option in the operations below depending on the operation used:

    echo "**********Collections **********\n\n";
    $endpoint = "https://connect.gettyimages.com/v3/collections";

    $headersToSend = array(CURLOPT_HTTPHEADER => array("Api-Key:".$client_key,
                        "Authorization: ".$tokenType." ".$token),
                          CURLOPT_FOLLOWLOCATION => TRUE); //this lets curl follow the 303

    $curl = getCurl($endpoint,$headersToSend);
    $response = executeCurl($curl);

    $response = json_decode($response['body'],true);

    echo "Collections returned ". json_encode($response["collections"]) . "\n\n\n";

### Countries

    echo "**********Countries **********\n\n";
    $endpoint = "https://connect.gettyimages.com/v3/countries";

    $headersToSend = array(CURLOPT_HTTPHEADER => array("Api-Key:".$client_key,
                "Authorization: ".$tokenType." ".$token),
                  CURLOPT_FOLLOWLOCATION => TRUE); //this lets curl follow the 303

    $curl = getCurl($endpoint,$headersToSend);
    $response = executeCurl($curl);

    $response = json_decode($response['body'],true);

    echo "Countries returned ". json_encode($response["countries"]) . "\n\n\n";

### Helper Functions

    /**
     *  Use of these functions isn't required, but does go a long way to simplify the curl interations
     *  by providing functions that more clearly express what's going on. If you're comfortable with curl
     *  or prefer to use another request object, this is up to you.
     */

    /**
     *  Used by the other functions to handle array merging of the curl options
     */
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

    /**
     *  Handles execution of the curl operation and returns an array with the results
     */
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

    /**
     *  Initializes a curl object with default options, optionally an array of curl options
     *  can be passed in.
     */
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

    /**
     *  Configures a curl object for form posting by getting a post request 
     *  and setting the content-type to 'application/x-www-form-urlencoded'
     */
    function getCurlForFormPost($url) {
      $curlOptions = array(CURLOPT_HTTPHEADER => array("Content-Type: application/x-www-form-urlencoded")); 
      $curl = getCurlForPost($url,$curlOptions);

      return $curl;
    }

    /**
     *  Configures a curl request object for a post operation by adding CURLOPT_POST => 1 to the options
     */
    function getCurlForPost($url,array $options = null) {
      $defaults = array(
          CURLOPT_POST => 1
        );

      $curlOptions = mergeCurlOptions($defaults,$options);
      return getCurl($url, $curlOptions);
    }

    /**
     *  Handles taking the body of the request to post and turning it into the proper request string
     *  form posting is different than a json post in that the request parameters are url encoded together
     *  with &'s
     *  If you want to do a JSON body this is not the function to use.
     */
    function setFormData($curl,$params) {
      $params = http_build_query($params);
      curl_setopt($curl, CURLOPT_POSTFIELDS, $params);
      return $curl;
    }

    /**
     *  Handles getting a curl object configured to post json, passing in a php array style object
     *  to turn into JSON
     */
    function getCurlForJSONPost($url, $data) {
      $data_string = json_encode($data,JSON_UNESCAPED_SLASHES);
      $options = array(         
          CURLOPT_POSTFIELDS => $data_string,
          CURLOPT_HTTPHEADER => array('Content-Type: application/json','Content-Length: ' . strlen($data_string))
      );

      $curl = getCurlForPost($url,$options);
      return $curl;
    }