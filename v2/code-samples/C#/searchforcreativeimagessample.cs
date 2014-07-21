// Requirements:
// - C# 4.0
// - Add System.Web.Extension.dll reference to your project so the code can compile.

using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Web.Script.Serialization;
using System.Diagnostics;

namespace ConnectExample.Samples
{
    public class RequestHeader
    {
        public string Token { get; set; }
        public string CoordinationId { get; set; }
    }

    public class StatusEntry
    {
        public string Type { get; set; }
        public string Code { get; set; }
        public string Message { get; set; }
    }

    public class ResponseHeader
    {
        public string Status { get; set; }
        public ICollection<StatusEntry> StatusList { get; set; }
        public string CoordinationId { get; set; }
    }

    public class Query
    {
        public string SearchPhrase { get; set; }
    }

    public class Filter
    {
        public List<string> ImageFamilies;
    }

    public class SearchForImages2RequestBody
    {
        public Query Query;
        public Filter Filter;
        public ResultOptions ResultOptions;
    }

    public class ResultOptions
    {
        public int ItemCount { get; set; }
        public int ItemStartNumber { get; set; }
        public int ItemTotalCount { get; set; }
        public string RefinementOptionsSet { get; set; }
    }

    public class Image
    {
        public string ImageId { get; set; }
        public string Title { get; set; }
        public string ImageFamily { get; set; }
        public string CollectionName { get; set; }
        public DateTime DateCreated { get; set; }
        public string LicensingModel { get; set; }
        public string UrlThumb { get; set; }
        public string UrlPreview { get; set; }
    }

    public class SearchForImagesResponse
    {
        public ResponseHeader ResponseHeader { get; set; }
        public SearchForImagesResult SearchForImagesResult { get; set; }
    }

    public class SearchForImagesResult
    {
        public int ItemStartNumber { get; set; }
        public int ItemTotalCount { get; set; }
        public IList<Image> Images { get; set; }
    }

    public class SearchForImagesRequest
    {
        public RequestHeader RequestHeader { get; set; }
        public SearchForImages2RequestBody SearchForImages2RequestBody { get; set; }
    }

    public class SearchForCreativeImagesSample
    {
        private const string SearchForImagesRequestUrl = "http://connect.gettyimages.com/v1/search/SearchForImages";
        private const string SearchTerm = "tree";

        // token received from CreateSession/RenewSession API call
        public SearchForImagesResponse Search(string token)
        {
            var searchForImagesRequest = new SearchForImagesRequest
            {
                RequestHeader = new RequestHeader{Token = token},
                SearchForImages2RequestBody = new SearchForImages2RequestBody
                                  {
                                      Query = new Query{SearchPhrase = SearchTerm},
                                      Filter = new Filter { ImageFamilies = new List<string> { "Creative" } },
                                      ResultOptions = new ResultOptions { ItemCount = 25, ItemStartNumber = 1 }
                                  }
            };

            return MakeWebRequest(SearchForImagesRequestUrl, searchForImagesRequest);
        }

        //You may wish to replace this code with your preferred library for posting and receiving JSON data.
        private static SearchForImagesResponse MakeWebRequest(string requestUrl, SearchForImagesRequest request)
        {
            var webRequest = WebRequest.Create(requestUrl) as HttpWebRequest;

            webRequest.Method = "POST";
            webRequest.ContentType = "application/json";

            var jsonSerializer = new JavaScriptSerializer();
            var requestStr = jsonSerializer.Serialize(request);

            Debug.WriteLine(requestStr);

            using (var writer = new StreamWriter(webRequest.GetRequestStream()))
            {
                writer.Write(requestStr);
                writer.Close();
            }

            var response = webRequest.GetResponse() as HttpWebResponse;

            string jsonResult;
            using (var reader = new StreamReader(response.GetResponseStream()))
            {
                jsonResult = reader.ReadToEnd();
                reader.Close();
            }

            Debug.WriteLine(jsonResult);

            return jsonSerializer.Deserialize<SearchForImagesResponse>(jsonResult);
        }

    }
}