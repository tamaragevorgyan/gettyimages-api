//
//  GetLargestImageDownloadAuthorizations.m
//  ConnectSample
//

#import "GetLargestImageDownloadAuthorizations.h"
#import "Urls.h"

@implementation GetLargestImageDownloadAuthorizations


+(NSDictionary*)getLargestDownloadAuthFor:(int)imageId token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:GET_LARGEST_IMAGE_DOWNLOAD_AUTHORIZATION_URL];
    
    //PREPARE REQUEST
    NSString *requestBody = [NSString stringWithFormat: @"{\"RequestHeader\":{\"Token\":\"%@\", \"CoordinationId\":\"MyUniqueId\"},\"GetLargestImageDownloadAuthorizationsRequestBody\":{\"Images\":[{\"ImageId\":\"%d\"}]}}", token, imageId]; 
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling GetLargestImageDownloadAuthorizations...");
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
    
    //CHECK FOR RESPONSE ERROR
    if (responseError)
    {
        NSLog(@"RESPONSE ERROR:\n%@",responseError.description);
        return nil;
    }
    
    //ATTEMPT TO PARSE THE RESPONSE AS JSON
    NSLog(@"Finished GetLargestImageDownloadAuthorizations. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    return responseObject;
}


@end
