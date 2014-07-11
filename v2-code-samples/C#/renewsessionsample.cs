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

    public class RenewSessionRequestBody
    {
        public string SystemId { get; set; }
        public string SystemPassword { get; set; }
        public string UserId { get; set; }
        public string UserPassword { get; set; }
    }

    public class RenewSessionRequest
    {
        public RequestHeader RequestHeader { get; set; }
        public RenewSessionRequestBody RenewSessionRequestBody { get; set; }
    }

    public class RenewSessionResult
    {
        public string AccountId { get; set; }
        public string SecureToken { get; set; }
        public string Token { get; set; }
        public int TokenDurationMinutes { get; set; }
    }

    public class RenewSessionResponse
    {
        public ResponseHeader ResponseHeader { get; set; }
        public RenewSessionResult RenewSessionResult { get; set; }
    }

    public class RenewSessionSample
    {
        public string GetToken(string secureToken)
        {
            return RenewSecureToken(secureToken).RenewSessionResult.Token;
        }

        public string GetSecureToken(string secureToken)
        {
            return RenewSecureToken(secureToken).RenewSessionResult.SecureToken;
        }

        // token received from CreateSession API call
        public RenewSessionResponse RenewSecureToken(string secureToken)
        {
            const string renewSessionRequestUrl = "https://connect.gettyimages.com/v1/session/RenewSession";
            var sessionToken = new RenewSessionRequestBody
            {
                SystemId = "systemId",
                SystemPassword = "systemPassword",
            };

            var renewSessionRequest = new RenewSessionRequest
            {
                RequestHeader = new RequestHeader { Token = secureToken },
                RenewSessionRequestBody = sessionToken
            };

            return MakeWebRequest(renewSessionRequestUrl, renewSessionRequest);
        }

        //You may wish to replace this code with your preferred library for posting and receiving JSON data.
        private static RenewSessionResponse MakeWebRequest(string requestUrl, RenewSessionRequest request)
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

            return jsonSerializer.Deserialize<RenewSessionResponse>(jsonResult);
        }
    }
}