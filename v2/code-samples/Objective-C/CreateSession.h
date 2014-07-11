//
//  CreateSession.h
//  ConnectSample
//

#import <Foundation/Foundation.h>

@interface CreateSession : NSObject

+(NSDictionary*)sessionWithUsername:(NSString*)username password:(NSString*)password systemId:(NSString*)systemId systemPassword:(NSString*)systemPassword;

@end
