//
//  ICPayDesignManager.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ICMessageModel, ICError;

typedef void(^ICCompletion)(ICError *);

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
- (void)registerSDKOption:(nullable void(^)())option messageBlock:(nullable void(^)(ICMessageModel *message))messageBlock;

/**
 注册SDK
 @param dictionary @{ICWxPayChannelKey:微信appkey}
 @param messageBlock 配置文字信息
 */

- (void)registerSDKWithDictionary:(nullable NSDictionary *)dictionary messageBlock:(nullable void(^)(ICMessageModel *message))messageBlock;



/**
 对后台参数自动解析的配置

 @param scheme 第三方支付APP返回商家APP所需要scheme 支付宝／银联  微信的为APPID
 @param identifierMap 识别支付方式的标识符
 例如 @{ICWxPayChannelKey : @"weChat" ,
       ICALiPayChannelKey : @"alipay",
       ICUnionPayChannelKey : @"tn"}
 SDK内部通过 weChat 字段判断为使用微信支付
 SDK内部通过 alipay 字段判断为使用支付宝支付
 SDK内部通过 tn     字段判断为使用银联支付
 用户可自定义字段名称

 @param replaceKeyMap 主要针对微信支付 替换默认的key 例如 将 partnerId 替换为 pID @{@"partnerId" : @"pID"}
 */
- (void)loadAutoParserConfigWithScheme:(NSString *)scheme
                         identifierMap:(NSDictionary *)identifierMap
                         replaceKeyMap:(NSDictionary *)replaceKeyMap;


/**
 支付统一API
 
 @param model 支付模型
 @param controller 控制器
 @param completion 完成回调
 */
- (void)payWithModel:(id)model
           controller:(nullable UIViewController *)controller
           completion:(nullable ICCompletion)completion;


/**
 处理支付回调9.0以前
 
 @param url url
 @param sourceApplication sourceApplication
 @param completion completion
 @return 处理结果
 */
- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           completion:(nullable ICCompletion)completion;


/**
 处理支付回调9.0以后
 */
- (BOOL)handleOpenURL:(NSURL *)url
           completion:(nullable ICCompletion)completion;


@end

NS_ASSUME_NONNULL_END

/*
- (void)payWithCharge:(NSString *)charge
scheme:(NSString *)scheme
controller:(UIViewController *)controller
completion:(ICCompletion)completion;*/
