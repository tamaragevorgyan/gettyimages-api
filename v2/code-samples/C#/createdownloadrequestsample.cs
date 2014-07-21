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

    public class DownloadItem
    {
        public string DownloadToken { get; set; }
    }

    public class CreateDownloadRequestBody
    {
        public List<DownloadItem> DownloadItems { get; set; }
    }

    public class CreateDownloadRequest
    {
        public RequestHeader RequestHeader { get; set; }
        public CreateDownloadRequestBody CreateDownloadRequestBody { get; set; }
    }

    public class DownloadUrl
    {
        public string ImageId { get; set; }
        public string SizeName { get; set; }
        public string Status { get; set; }
        public string UrlAttachment { get; set; }
    }

    public class CreateDownloadRequestResult
    {
        public List<DownloadUrl> DownloadUrls { get; set; }
    }

    public class CreateDownloadResponse
    {
        public ResponseHeader ResponseHeader { get; set; }
        public CreateDownloadRequestResult CreateDownloadRequestResult { get; set; }
    }

    public class CreateDownloadRequestSample
    {
        private const string CreateDownloadRequestRequestUrl = "https://connect.gettyimages.com/v1/download/CreateDownloadRequest";

        // securetoken received from CreateSession/RenewSession API call
        public CreateDownloadResponse CreateRequest(string secureToken, List<DownloadItem> downloadTokens)
        {
            var createDownloadRequest = new CreateDownloadRequest
            {
                RequestHeader = new RequestHeader { Token = secureToken },
                CreateDownloadRequestBody = new CreateDownloadRequestBody
                {
                    DownloadItems = downloadTokens
                }
            };

            return MakeWebRequest(CreateDownloadRequestRequestUrl, createDownloadRequest);
        }

        //You may wish to replace this code with your preferred library for posting and receiving JSON data.
        private static CreateDownloadResponse MakeWebRequest(string requestUrl, CreateDownloadRequest request)
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

            return jsonSerializer.Deserialize<CreateDownloadResponse>(jsonResult);
        }
    }    
}