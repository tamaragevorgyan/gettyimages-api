//
//  GetImageDownloadAuthorizations.h
//  ConnectSample
//

#import <Foundation/Foundation.h>

@interface GetImageDownloadAuthorizations : NSObject

+(NSDictionary*)authorizationsFor:(int)imageId sizeKey:(NSString*)sizeKey token:(NSString*)token;

@end
