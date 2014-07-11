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

    public class CreateSessionRequestBody
    {
        public string SystemId { get; set; }
        public string SystemPassword { get; set; }
        public string UserName { get; set; }
        public string UserPassword { get; set; }
    }

    public class CreateSessionTokenRequest
    {
        public RequestHeader RequestHeader { get; set; }
        public CreateSessionRequestBody CreateSessionRequestBody { get; set; }
    }

    public class CreateSessionResult
    {
        public string AccountId { get; set; }
        public string SecureToken { get; set; }
        public string Token { get; set; }
        public int TokenDurationMinutes { get; set; }
    }

    public class CreateSessionTokenResponse
    {
        public ResponseHeader ResponseHeader { get; set; }
        public CreateSessionResult CreateSessionResult { get; set; }
    }

    public class CreateSessionSample
    {
        public string GetToken()
        {
            return GetCreateSessionResponse().CreateSessionResult.Token;
        }

        public string GetSecureToken()
        {
            return GetCreateSessionResponse().CreateSessionResult.SecureToken;
        }

        public CreateSessionTokenResponse GetCreateSessionResponse()
        {
            const string createSessionRequestUrl = "https://connect.gettyimages.com/v1/session/CreateSession";
            var createSessionRequestBody = new CreateSessionRequestBody
            {
                SystemId = "systemId",
                SystemPassword = "systemPassword",
                UserName = "username",
                UserPassword = "password",
            };

            var createSessionTokenRequest = new CreateSessionTokenRequest
            {
                RequestHeader = new RequestHeader(),
                CreateSessionRequestBody = createSessionRequestBody
            };

            return MakeWebRequest(createSessionRequestUrl, createSessionTokenRequest);            
        }

        //You may wish to replace this code with your preferred library for posting and receiving JSON data.
        private static CreateSessionTokenResponse MakeWebRequest(string requestUrl, CreateSessionTokenRequest request)
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

            return jsonSerializer.Deserialize<CreateSessionTokenResponse>(jsonResult);
        }

    }
}