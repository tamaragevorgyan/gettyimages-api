//
//  GetImageDetails.m
//  ConnectSample
//

#import "GetImageDetails.h"
#import "Urls.h"

@implementation GetImageDetails

+(NSDictionary*)detailsFor:(NSArray*)imageIds token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:GET_IMAGE_DETAILS_URL];
    
    //IF NO IMAGES HAVE BEEN REQUESTED, RETURN WITHOUT MAKING A CALL
    if (!imageIds.count > 0) return nil;
    
    //PREPARE REQUEST
    NSMutableString *imageIdsStr = [NSMutableString stringWithString:@"[\""];
    [imageIdsStr appendString: [imageIds componentsJoinedByString:@"\",\""] ];
    [imageIdsStr appendString:@"\"]"];
    
    NSString *requestBody = [NSString stringWithFormat: @"{\"RequestHeader\":{\"Token\":\"%@\", \"CoordinationId\":\"MyUniqueId\"},\"GetImageDetailsRequestBody\":{\"CountryCode\":\"USA\",\"ImageIds\":%@,\"Language\":\"en-us\"}}", token, imageIdsStr]; 
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling GetImageDetails...");
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
    
    //CHECK FOR RESPONSE ERROR
    if (responseError)
    {
        NSLog(@"RESPONSE ERROR:\n%@",responseError.description);
        return nil;
    }
    
    //ATTEMPT TO PARSE THE RESPONSE AS JSON
    NSLog(@"Finished GetImageDetails. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    return responseObject;
}

@end
