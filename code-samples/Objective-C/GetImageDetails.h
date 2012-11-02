//
//  GetImageDetails.h
//  ConnectSample
//

#import <Foundation/Foundation.h>

@interface GetImageDetails : NSObject
+(NSDictionary*)detailsFor:(NSArray*)imageIds token:(NSString*)token;
@end
