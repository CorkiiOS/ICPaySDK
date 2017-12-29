//
//  ICAppDelegate.m
//  ICPaySDK
//
//  Created by corkiios on 12/19/2017.
//  Copyright (c) 2017 corkiios. All rights reserved.
//

#import "ICAppDelegate.h"
#import <ICPaySDK.h>
#import "ICCircleTestViewController.h"
@implementation ICAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[ICPayDesignManager shareInstance] registerSDKWithDictionary:@{ICWxPayChannelKey : @"微信支付的APPId,如果不使用微信支付可以忽略"} messageBlock:^(ICMessageModel *message) {
        message.cancel = @"取消";
        //配置回调提示
    }];
    
    /*
     [[ICPayDesignManager shareInstance] registerSDKOption:^{
     //自己注册SDK 做想要的操作
     } messageBlock:^(ICMessageModel * _Nonnull message) {
     
     }];
     */
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ICCircleTestViewController new]];
    [self.window makeKeyAndVisible];
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
