#Java Script Example Code

### A few notes about javascript and cors
The below code will only work with API-Key authentication. CORS headers for the oauth2 will prevent client side java script from posting to get security credentials. This is by design.

### Example HTML Document
#### You should be able to copy the contents of this script and paste it straight into an HTML file.
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns ="http://www.w3.org/1999/xhtml">
      <head></head>
      <body>
        <H1>API-KEY</H1>
        <p>Enter your api key here it will be used by all requests below</p>
        <input id="apiKey" type="text" placeholder="Api-Key"/>
        <div id="SearchImages">
          <H1>Search/Images</H1>
          <textarea id="SearchResults" style="width:250px;height:100px"></textarea>
          <button id="btnGetSearchResults" onclick="getSearchResults('images','#SearchResults')">Search For Dog</button>
        </div>
        <hr/>

        <div id="SearchImagesCreative">
          <H1>Search/Images/Creative</H1>
          <textarea id="SearchResultsCreative" style="width:250px;height:100px"></textarea>
          <button id="btnGetSearchResultsCreative" onclick="getSearchResults('images/creative','#SearchResultsCreative')">Search For Dog</button>
        </div>
        <hr/>

        <div id="SearchImagesEditorial">
          <H1>Search/Images/Creative</H1>
          <textarea id="SearchResultsEditorial" style="width:250px;height:100px"></textarea>
          <button id="btnGetSearchResultsEditorial" onclick="getSearchResults('images/editorial','#SearchResultsEditorial')">Search For Dog</button>
        </div>
        <hr/>

        <div id="Images">
          <H1>Images</H1>
          <textarea id="ImagesResults" style="width:250px;height:100px" rows="100"></textarea>
          <button onclick="getImagesResults('452090390','#ImagesResults')">Get Details for 452090390</button>
        </div>


        <script type="text/javascript">
          var SearchRequest = { "phrase": "dog" }
        </script>

        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.3/jquery.min.js"></script>
        <script type="text/javascript">
          var appendApiKeyHeader = function( xhr ) {
            xhr.setRequestHeader('Api-Key', $('#apiKey').val())
          }

          var processSuccess = function(data, textStatus, jqXHR, callback) {
            returnObject = {};
            returnObject.requestDetails = JSON.stringify(data, undefined, 2)
            callback(returnObject)
          }

          var processFailure = function (data, err, callback) {
            returnObject = {};
            returnObject.requestDetails = JSON.stringify(this)
            returnObject.tokenResponse = 'Data: ' + JSON.stringify(data) + ' | Error: ' + err
            callback(returnObject)
          }


          function getSearchResults(route, textAreaSelector) {
              GetSearchResults(route, function(response) {
                $('textarea' + textAreaSelector).val(JSON.stringify(response, undefined, 2)); 
              });
          }

          function getImagesResults(route, textAreaSelector) {
            GetImagesResults(route,function(response) {
              $('textarea' + textAreaSelector).val(JSON.stringify(response,undefined,2));
            })
          }

          function getImageDownload(route, textAreaSelector) {
            GetImageDownload(route, function (response) {
              $('textarea' + textAreaSelector).val(JSON.stringify(response,undefined,2));          
            })
          }

          function GetSearchResults(route, callback) {
            $.ajax({
              type: "GET",
              beforeSend: appendApiKeyHeader,
              url: "https://connect.gettyimages.com/v3/search/" + route,
              data: SearchRequest})
              .success(function (data, textStatus, jqXHR) { processSuccess(data,textStatus,jqXHR,callback) })
              .fail(function (data, err) { processFailure(data, err, callback) });
          }

          function GetImagesResults(route, callback) {
            $.ajax({
              type: "GET",
              beforeSend: appendApiKeyHeader,
              url: "https://connect.gettyimages.com/v3/images/" + route})
              .success(function (data, textStatus, jqXHR) { processSuccess(data,textStatus,jqXHR, callback) })
              .fail(function (data, err) { processFailure(data, err, callback) })
            }

        </script>
      </body>
    </html>