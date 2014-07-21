//
//  RenewSession.m
//  ConnectSample
//

#import "RenewSession.h"
#import "Urls.h"

@implementation RenewSession

+(NSDictionary*)renewToken:(NSString*)token systemId:(NSString*)systemId systemPassword:(NSString*)systemPassword
{
    NSURL *url = [NSURL URLWithString:RENEW_SESSION_URL];
    
    //PREPARE REQUEST
    NSString *requestBody = [NSString stringWithFormat:@"{\"RequestHeader\":{\"Token\":\"%@\"},\"RenewSessionRequestBody\":{\"SystemId\":\"%@\",\"SystemPassword\":\"%@\"}}", token, systemId, systemPassword];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling RenewSession...");
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
    
    //CHECK FOR RESPONSE ERROR
    if (responseError)
    {
        NSLog(@"RESPONSE ERROR:\n%@",responseError.description);
        return nil;
    }
    
    //ATTEMPT TO PARSE THE RESPONSE AS JSON
    NSLog(@"Finished RenewSession. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    return responseObject;
}


@end