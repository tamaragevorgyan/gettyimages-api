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

    public class GetImageDetailsRequestBody
    {
        public string CountryCode { get; set; }
        public string Language { get; set; }
        public List<string> ImageIds { get; set; }
    }

    public class GetImageDetailsRequest
    {
        public RequestHeader RequestHeader { get; set; }
        public GetImageDetailsRequestBody GetImageDetailsRequestBody { get; set; }
    }

    public class SizesDownloadableImage
    {
        public int ResolutionDpi { get; set; }
        public string SizeKey { get; set; }
    }

    public class Image
    {
        public string ImageId { get; set; }
        public List<SizesDownloadableImage> SizesDownloadableImages { get; set; }
    }

    public class GetImageDetailsResult
    {
        public List<Image> Images { get; set; }
    }

    public class GetImageDetailsResponse
    {
        public ResponseHeader ResponseHeader { get; set; }
        public GetImageDetailsResult GetImageDetailsResult { get; set; }
    }

    public class GetImageDetailsSample
    {
        private const string GetImageDetailsRequestUrl = "http://connect.gettyimages.com/v1/search/GetImageDetails";

        // token received from CreateSession/RenewSession API call
        public GetImageDetailsResponse GetImageDetails(string token, List<string> imageIds)
        {
            var getImageDetailsRequest = new GetImageDetailsRequest
                              {
                                  RequestHeader = new RequestHeader {Token = token},
                                  GetImageDetailsRequestBody = new GetImageDetailsRequestBody
                                                                   {
                                                                       CountryCode = "USA",
                                                                       Language = "en-us",
                                                                       ImageIds = imageIds
                                                                   }
                              };

           return MakeWebRequest(GetImageDetailsRequestUrl, getImageDetailsRequest);
        }

        //You may wish to replace this code with your preferred library for posting and receiving JSON data.
        private static GetImageDetailsResponse MakeWebRequest(string requestUrl, GetImageDetailsRequest request)
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

            return jsonSerializer.Deserialize<GetImageDetailsResponse>(jsonResult);
        }
    }
}