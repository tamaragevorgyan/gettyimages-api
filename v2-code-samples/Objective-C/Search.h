//
//  Search.h
//  ConnectSample
//

#import <Foundation/Foundation.h>
#include "Global.h"

@interface Search : NSObject
+(NSDictionary*)searchWith:(NSString*)phrase itemCount:(int)count itemStartNumber:(int)itemStartNumber imageFamilies:(NSArray*)families  token:(NSString*)token;
@end
