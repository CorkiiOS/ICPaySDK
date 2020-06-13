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

    // 如果使用了微信支付 需要注册
    [[ICPayDesignManager shareInstance] registerWx:@"" universalLinks:@""];
    
    // 使用的时候 在项目里最好自己做一层封装 如果后续有变动 迁移成本低
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ICCircleTestViewController new]];
    [self.window makeKeyAndVisible];
    
    // 自定义支付对象
    //[[ICPayDesignManager shareInstance] addPayEntry:<#(nonnull ICBasePayEntry *)#>];
    
    return YES;
}



/*-------------以下为处理回调------------*/
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

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [[ICPayDesignManager shareInstance] handleOpenUniversalLink:userActivity];
}


@end
