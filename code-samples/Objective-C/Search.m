//
//  Search.m
//  ConnectSample
//

#import "Search.h"
#import "Urls.h"

@implementation Search

+(NSDictionary*)searchWith:(NSString*)phrase itemCount:(int)count itemStartNumber:(int)itemStartNumber imageFamilies:(NSArray*)families  token:(NSString*)token
{
    NSURL *url = [NSURL URLWithString:SEARCH_URL];
    
    //PREPARE REQUEST
    NSMutableString *imageFamilies = [NSMutableString stringWithString:@""];
    if (families.count > 0)
    {
        [imageFamilies appendString:@",\"Filter\":{\"ImageFamilies\":[\""];
        [imageFamilies appendString: [families componentsJoinedByString:@"\",\""] ];
        [imageFamilies appendString:@"\"]}"];
    }
    NSString *requestBody = [NSString stringWithFormat: @"{\"RequestHeader\":{\"Token\":\"%@\"},\"SearchForImages2RequestBody\":{\"Query\":{\"SearchPhrase\":\"%@\"},\"ResultOptions\":{\"ItemCount\":%d,\"ItemStartNumber\":%d}%@}}", token, phrase, count, itemStartNumber, imageFamilies];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *responseError;
    NSURLResponse *response;
    
    //SEND REQUEST
    NSLog(@"calling Search...");
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&responseError];
        
    //CHECK FOR RESPONSE ERROR
    if (responseError)
    {
        NSLog(@"RESPONSE ERROR:\n%@",responseError.description);
        return nil;
    }
    
    //ATTEMPT TO PARSE THE RESPONSE AS JSON
    NSLog(@"Finished Search. Parsing data...");
    NSError *jsonParseError;
    NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonParseError];
    NSAssert(!jsonParseError, @"Error parsing JSON: %@", jsonParseError.description);
    
    NSDictionary *responseObject = [NSDictionary dictionaryWithDictionary:responseDictionary];
    return responseObject;
}

@end
