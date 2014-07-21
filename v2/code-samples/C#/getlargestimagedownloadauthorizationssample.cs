// Requirements:
// - C# 4.0
// - Add System.Web.Extension.dll reference to your project so the code can compile.

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

    public class Image
    {
        public string ImageId { get; set; }
    }

    public class GetLargestImageDownloadAuthorizationsRequestBody
    {
        public List<Image> Images { get; set; }
    }

    public class GetLargestImageDownloadAuthorizationsRequest
    {
        public RequestHeader RequestHeader { get; set; }
        public GetLargestImageDownloadAuthorizationsRequestBody GetLargestImageDownloadAuthorizationsRequestBody { get; set; }
    }
  
    public class Authorization
    {
        public bool DownloadIsFree { get; set; }
        public string DownloadToken { get; set; }
        public string ProductOfferingInstanceId { get; set; }
        public string ProductOfferingType { get; set; }
        public string SizeKey { get; set; }
    }

    public class ImageAuth
    {
        public string ImageId { get; set; }
        public List<Authorization> Authorizations { get; set; }
    }

    public class GetLargestImageDownloadAuthorizationsResult
    {
        public List<ImageAuth> Images { get; set; }
    }

    public class GetLargestImageDownloadAuthorizationsResponse
    {
        public ResponseHeader ResponseHeader { get; set; }
        public GetLargestImageDownloadAuthorizationsResult GetLargestImageDownloadAuthorizationsResult { get; set; }
    }

    public class GetLargestImageDownloadAuthorizationsSample
    {
        private const string GetLargestImageDownloadAuthorizationsRequestUrl = "https://connect.gettyimages.com/v1/download/GetLargestImageDownloadAuthorizations";

        // token received from CreateSession/RenewSession API call
        public GetLargestImageDownloadAuthorizationsResponse GetLargestDownloadForImages(string token, List<Image> imageIds)
        {

            var getLargestImageDownloadAuthorizationsRequest = new GetLargestImageDownloadAuthorizationsRequest
            {
                RequestHeader = new RequestHeader { Token = token },
                GetLargestImageDownloadAuthorizationsRequestBody = new GetLargestImageDownloadAuthorizationsRequestBody
                {
                    Images = imageIds
                }
            };

            return MakeWebRequest(GetLargestImageDownloadAuthorizationsRequestUrl, getLargestImageDownloadAuthorizationsRequest);            
        }

        //You may wish to replace this code with your preferred library for posting and receiving JSON data.
        private static GetLargestImageDownloadAuthorizationsResponse MakeWebRequest(string requestUrl, GetLargestImageDownloadAuthorizationsRequest request)
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

            return jsonSerializer.Deserialize<GetLargestImageDownloadAuthorizationsResponse>(jsonResult);
        }
    }    
}