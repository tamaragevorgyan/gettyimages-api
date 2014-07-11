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

    public class ImageSize
    {
        public string ImageId { get; set; }
        public string SizeKey { get; set; }
    }

    public class ImageDownloadAuth
    {
        public bool DownloadIsFree { get; set; }
        public string DownloadToken { get; set; }
        public string ProductOfferingInstanceId { get; set; }
        public string ProductOfferingType { get; set; }
    }

    public class ImageDownloadAuthorizations
    {
        public List<ImageDownloadAuth> Authorizations { get; set; }
        public string ImageId { get; set; }
    }

    public class GetImageDownloadAuthorizationsRequestBody
    {
        public IList<ImageSize> ImageSizes { get; set; }
    }

    public class GetImageDownloadAuthorizationsRequest
    {
        public RequestHeader RequestHeader { get; set; }
        public GetImageDownloadAuthorizationsRequestBody GetImageDownloadAuthorizationsRequestBody { get; set; }
    }

    public class GetImageDownloadAuthorizationsResult
    {
        public List<ImageDownloadAuthorizations> Images { get; set; }
    }

    public class GetImageDownloadAuthorizationsResponse
    {
        public ResponseHeader ResponseHeader { get; set; }
        public GetImageDownloadAuthorizationsResult GetImageDownloadAuthorizationsResult { get; set; }
    }
    
    public class GetImageDownloadAuthorizationsSample
    {
        private const string GetImageDownloadAuthorizationsRequestUrl = "https://connect.gettyimages.com/v1/download/GetImageDownloadAuthorizations";

        // token received from CreateSession/RenewSession API call
        public GetImageDownloadAuthorizationsResponse AuthorizeDownload(string token, IList<ImageSize> imageSizes)
        {
            var getImageDownloadAuthorizationsRequest = new GetImageDownloadAuthorizationsRequest
            {
                RequestHeader = new RequestHeader { Token = token },
                GetImageDownloadAuthorizationsRequestBody = new GetImageDownloadAuthorizationsRequestBody
                                                                {
                                                                    ImageSizes = imageSizes
                                                                }
            };

            return MakeWebRequest(GetImageDownloadAuthorizationsRequestUrl, getImageDownloadAuthorizationsRequest);
        }

        //You may wish to replace this code with your preferred library for posting and receiving JSON data.
        private static GetImageDownloadAuthorizationsResponse MakeWebRequest(string requestUrl, GetImageDownloadAuthorizationsRequest request)
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

            return jsonSerializer.Deserialize<GetImageDownloadAuthorizationsResponse>(jsonResult);
        }
    }
}