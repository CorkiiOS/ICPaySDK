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

    /*新版*/
    
    /*pod集成 或者 手动配置好之后*/
    
    /*注册的方式*/
    ///方式一：
    ///如果采用了微信支付，那么在项目info.plist中添加键值对 ICWxPayChannelKey : 微信key
    ///如果没有微信支付,那么再项目info.plist中添加键值对 ICWxPayChannelKey : 任意字符串
    ///添加任意字符串是为了提供一个自动注册sdk的标志
    
    //// ---------------- ICWxPayUniversalLinks ----------------
    //// 通用链接
    
    ///方式二：
    /*    [[ICPayDesignManager shareInstance]
     registerSDKWithDictionary:@{ICWxPayChannelKey : @"wechat key", ICWxPayUniversalLinks : @""
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
    return [[ICPayDesignManager shareInstance] handleOpenURL:url sourceApplication:sourceApplication];
    
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return [[ICPayDesignManager shareInstance] handleOpenURL:url sourceApplication:nil];
}


@end
