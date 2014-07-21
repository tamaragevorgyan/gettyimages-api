#Java Script Example Code

### Authentication

An Api-Key header is needed to authenticate to the Api and will allow you to access read-only operations. The following javascript defines a function that sets the Api-Key header for the current request:

    var appendApiKeyHeader = function( xhr ) {
      xhr.setRequestHeader('Api-Key', 'your-api-key')
    }

### Authorization

By design CORS headers for OAuth2 will prevent client-side javascript from posting to get security credentials.

### Search

The following sample code utilizes the appendApiKeyHeader function defined above.

#### Images

    var searchRequest = { "phrase": "dog" }

    function GetSearchResults(callback) {
      $.ajax({
        type: "GET",
        beforeSend: appendApiKeyHeader,
        url: "https://connect.gettyimages.com/v3/search",
        data: searchRequest})
        .success(function (data, textStatus, jqXHR) { /* use search results */ })
        .fail(function (data, err) { /* handle errors */ });
    }

#### Images Creative

    var searchRequest = { "phrase": "dog" }

    function GetSearchResults(callback) {
      $.ajax({
        type: "GET",
        beforeSend: appendApiKeyHeader,
        url: "https://connect.gettyimages.com/v3/search/creative",
        data: searchRequest})
        .success(function (data, textStatus, jqXHR) { /* use search results */ })
        .fail(function (data, err) { /* handle errors */ });
    }

#### Images Editorial

    var searchRequest = { "phrase": "dog" }

    function GetSearchResults(callback) {
      $.ajax({
        type: "GET",
        beforeSend: appendApiKeyHeader,
        url: "https://connect.gettyimages.com/v3/search/editorial",
        data: searchRequest})
        .success(function (data, textStatus, jqXHR) { /* use search results */ })
        .fail(function (data, err) { /* handle errors */ });
    }

### Image Metadata

    function GetImagesResults(callback) {
      $.ajax({
        type: "GET",
        beforeSend: appendApiKeyHeader,
        url: "https://connect.gettyimages.com/v3/images/{id}"})
        .success(function (data, textStatus, jqXHR) { /* use image metadata */ })
        .fail(function (data, err) { /* handle errors */ });
    }