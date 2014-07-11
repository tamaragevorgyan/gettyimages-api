//
//  CreateDownloadRequest.h
//  ConnectSample
//

#import <Foundation/Foundation.h>

@interface CreateDownloadRequest : NSObject
+(NSDictionary*)createRequestFor:(NSString*)downloadToken token:(NSString*)token;
@end
