//
//  GetLargestImageDownloadAuthorizations.h
//  ConnectSample
//

#import <Foundation/Foundation.h>

@interface GetLargestImageDownloadAuthorizations : NSObject
+(NSDictionary*)getLargestDownloadAuthFor:(int)imageId token:(NSString*)token;
@end
