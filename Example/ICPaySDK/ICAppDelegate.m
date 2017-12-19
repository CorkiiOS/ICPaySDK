//
//  ICAppDelegate.m
//  ICPaySDK
//
//  Created by corkiios on 12/19/2017.
//  Copyright (c) 2017 corkiios. All rights reserved.
//

#import "ICAppDelegate.h"
#import <ICPaySDK.h>

@implementation ICAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[ICPayDesignManager shareInstance] registerSDKWithDictionary:@{ICWxPayChannelKey : @"wx1cd2880e51ed36e9"} messageBlock:^(ICMessageModel *message) {
        message.cancel = @"取消";
    }];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [[ICPayDesignManager shareInstance] handleOpenURL:url sourceApplication:sourceApplication completion:nil];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return  [[ICPayDesignManager shareInstance] handleOpenURL:url completion:nil];
}


@end
