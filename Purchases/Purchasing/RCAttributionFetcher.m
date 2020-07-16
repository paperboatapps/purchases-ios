//
//  RCAttributionFetcher.m
//  Purchases
//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "RCAttributionFetcher.h"
#import "RCCrossPlatformSupport.h"
#import "RCLogUtils.h"

@protocol FakeAdClient <NSObject>

+ (instancetype)sharedClient;
- (void)requestAttributionDetailsWithBlock:(void (^)(NSDictionary<NSString *, NSObject *> * _Nullable attributionDetails, NSError * _Nullable error))completionHandler;

@end

@implementation RCAttributionFetcher : NSObject

- (nullable NSString *)advertisingIdentifier
{
    return nil;
}


- (nullable NSString *)identifierForVendor
{
#if UI_DEVICE_AVAILABLE
    if ([UIDevice class]) {
        return UIDevice.currentDevice.identifierForVendor.UUIDString;
    }
#endif
    return nil;
}

- (void)adClientAttributionDetailsWithCompletionBlock:(void (^)(NSDictionary<NSString *, NSObject *> * _Nullable attributionDetails, NSError * _Nullable error))completionHandler
{
#if AD_CLIENT_AVAILABLE
    id<FakeAdClient> adClientClass = (id<FakeAdClient>)NSClassFromString(@"ADClient");
    
    if (adClientClass) {
        [[adClientClass sharedClient] requestAttributionDetailsWithBlock:completionHandler];
    }
#endif
}

@end

