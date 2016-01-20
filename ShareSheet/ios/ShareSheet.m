#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(ShareSheet, NSObject)

RCT_EXTERN_METHOD(open:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(open:(NSDictionary *)options)

@end