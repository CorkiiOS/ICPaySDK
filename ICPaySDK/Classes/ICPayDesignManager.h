//
//  ICPayDesignManager.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 ICorki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICPaySDK.h"
@class ICMessageModel;


@interface ICPayDesignManager : NSObject

+ (instancetype)shareInstance;

/**
 注册SDK
 @param option 执行一些初始化操作 注册SDK 等 例如微信
 @param messageBlock 配置文字信息
 
 说明微信支付
 1.info.plist 需要配置
 <key>LSApplicationQueriesSchemes</key>
 <array>
 <string>weixin</string>
 </array>
 2. URLType 添加scheme

 */
- (void)registerSDKOption:(void(^)())option messageBlock:(void(^)(ICMessageModel *message))messageBlock;

/**
 注册SDK
 @param dictionary @{ICWxPayChannelKey:微信appkey}
 @param messageBlock 配置文字信息
 */

- (void)registerSDKWithDictionary:(NSDictionary *)dictionary messageBlock:(void(^)(ICMessageModel *message))messageBlock;


/**
 支付统一API
 
 @param model 支付模型
 @param controller 控制器
 @param completion 完成回调
 */
- (void)payWithModel:(id)model
           controller:(UIViewController *)controller
           completion:(ICCompletion)completion;
/**
 处理支付回调9.0以前
 
 @param url url
 @param sourceApplication sourceApplication
 @param completion completion
 @return 处理结果
 */
- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           completion:(ICCompletion)completion;


/**
 处理支付回调9.0以后
 */
- (BOOL)handleOpenURL:(NSURL *)url
           completion:(ICCompletion)completion;
@end


/*
- (void)payWithCharge:(NSString *)charge
scheme:(NSString *)scheme
controller:(UIViewController *)controller
completion:(ICCompletion)completion;*/
