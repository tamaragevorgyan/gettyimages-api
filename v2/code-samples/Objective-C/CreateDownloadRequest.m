//
//  CreateDownloadRequest.m
//  ConnectSample
//

#import "CreateDownloadRequest.h"
#import "Urls.h"

@implementation CreateDownloadRequest

+(NSDictionary*)createRequestFor:(NSString*)downloadToken token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:CREATE_DOWNLOAD_REQUEST_URL];
    
    //PREPARE REQUEST
    NSString *requestBody = [NSString stringWithFormat: @"{\"RequestHeader\":{\"Token\":\"%@\", \"CoordinationId\":\"MyUniqueId\"},\"CreateDownloadRequestBody\":{\"DownloadItems\":[{\"DownloadToken\":\"%@\"}]}}", token, downloadToken]; 
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling CreateDownloadRequest...");
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
    

    //CHECK FOR RESPONSE ERROR
    if (responseError)
    {
        NSLog(@"RESPONSE ERROR:\n%@",responseError.description);
        return nil;
    }
    
    //ATTEMPT TO PARSE THE RESPONSE AS JSON
    NSLog(@"Finished CreateDownloadRequest. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    return responseObject;
}

@end
