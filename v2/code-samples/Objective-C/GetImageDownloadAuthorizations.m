//
//  GetImageDownloadAuthorizations.m
//  ConnectSample
//

#import "GetImageDownloadAuthorizations.h"
#import "Urls.h"

@implementation GetImageDownloadAuthorizations

+(NSDictionary*)authorizationsFor:(int)imageId sizeKey:(NSString*)sizeKey token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:GET_IMAGE_DOWNLOAD_AUTHORIZATIONS_URL];
    
    //PREPARE REQUEST
    NSString *requestBody = [NSString stringWithFormat: @"{\"RequestHeader\":{\"Token\":\"%@\", \"CoordinationId\":\"MyUniqueId\"},\"GetImageDownloadAuthorizationsRequestBody\":{\"ImageSizes\":[{\"ImageId\":%d,\"SizeKey\":\"%@\"}]}}", token, imageId, sizeKey];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling GetImageDownloadAuthorizations...");
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
    
    //CHECK FOR RESPONSE ERROR
    if (responseError)
    {
        NSLog(@"RESPONSE ERROR:\n%@",responseError.description);
        return nil;
    }
    
    //ATTEMPT TO PARSE THE RESPONSE AS JSON
    NSLog(@"Finished GetImageDownloadAuthorizations. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    return responseObject;
}

@end
