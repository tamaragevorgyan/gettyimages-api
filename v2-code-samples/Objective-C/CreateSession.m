//
//  CreateSession.m
//  ConnectSample
//

#import "CreateSession.h"
#import "Urls.h"

@implementation CreateSession

+(NSDictionary*)sessionWithUsername:(NSString*)username password:(NSString*)password systemId:(NSString*)systemId systemPassword:(NSString*)systemPassword
{
    NSAssert(systemId != @"",@"SYSTEM ID and SYSTEM PASSWORD are not set. Have you added them to Global.h?");
    NSURL *url = [NSURL URLWithString:CREATE_SESSION_URL];
    
    //PREPARE REQUEST
    NSString *requestBody = [NSString stringWithFormat:@"{\"RequestHeader\":{\"Token\":\"\"},\"CreateSessionRequestBody\":{\"SystemId\":\"%@\",\"SystemPassword\":\"%@\",\"UserName\":\"%@\",\"UserPassword\":\"%@\"}}", systemId, systemPassword, username, password];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling CreateSession...");
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
    
    //DEBUG: LOG OUT THE REPONSE
    //    NSLog(@"===================================================");
    //    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //    NSLog(@"RESPONSE:\n%@",responseString);
    //    NSLog(@"===================================================");
    
    //CHECK FOR RESPONSE ERROR
    if (responseError)
    {
        NSLog(@"RESPONSE ERROR:\n%@",responseError.description);
        return nil;
    }
    
    //ATTEMPT TO PARSE THE RESPONSE AS JSON
    NSLog(@"Finished CreateSession. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);

    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    return responseObject;
}


@end