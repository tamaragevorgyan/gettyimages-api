//
//  RenewSession.h
//  ConnectSample
//

#import <UIKit/UIKit.h>

@interface RenewSession : NSObject
+(NSDictionary*)renewToken:(NSString*)token systemId:(NSString*)systemId systemPassword:(NSString*)systemPassword;
@end
