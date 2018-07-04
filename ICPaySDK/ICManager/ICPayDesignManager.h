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
@protocol ICPaySDKAutoServiceProtocol;

typedef void(^ICCompletion)(ICError *);

@interface ICPayDesignManager : NSObject

+ (instancetype)shareInstance;


/**
 注册SDK

 @param dictionary 如果项目中使用微信支付 dictionary = @{ICWxPayChannelKey : @"微信支付key"}，反之为nil
 */
- (void)registerSDKWithDictionary:(nullable NSDictionary *)dictionary;

/**
 注册SDK

 @param service 自动解析支付参数必须遵守的规则，详见ICPaySDKAutoServiceProtocol.h
 */
- (void)registerSDKAutoService:(id<ICPaySDKAutoServiceProtocol>)service;

/**
 支付统一API
 
 @param model 支付模型
 @param controller 银联支付为必要参数，其他为nil
 @param completion 完成回调
 */
- (void)payWithModel:(id)model
          controller:(nullable UIViewController *)controller
          completion:(nullable ICCompletion)completion;


/**
 支付回调 9.0前后统一调用此方法

 @param url ～
 @param sourceApplication ～
 @return ～
 */
- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(nullable NSString *)sourceApplication;
/**
 全局设置支付成功提示文字

 @param text ～
 */
- (void)setGlobalPaySuccessText:(NSString *)text;

/**
 全局设置支付取消文字

 @param text ～
 */
- (void)setGlobalPayCancelText:(NSString *)text;

/**
 全局设置支付失败文字

 @param text ～
 */
- (void)setGlobalPayFailureText:(NSString *)text;


/*******************************即将废弃**************************************/


/**
 注册SDK
 @param dictionary @{ICWxPayChannelKey:微信appkey}
 @param messageBlock 配置文字信息
 */

- (void)registerSDKWithDictionary:(nullable NSDictionary *)dictionary messageBlock:(nullable void(^)(ICMessageModel *message))messageBlock DEPRECATED_MSG_ATTRIBUTE("use registerSDKWithDictionary: instead");

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
- (void)registerSDKOption:(nullable void(^)())option messageBlock:(nullable void(^)(ICMessageModel *message))messageBlock DEPRECATED_MSG_ATTRIBUTE("use registerSDKWithDictionary: instead");

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
                         replaceKeyMap:(nullable NSDictionary *)replaceKeyMap DEPRECATED_MSG_ATTRIBUTE("use registerSDKAutoService: instead");


/**
 处理支付回调9.0以后
 */
- (BOOL)handleOpenURL:(NSURL *)url
           completion:(nullable ICCompletion)completion DEPRECATED_MSG_ATTRIBUTE("use handleOpenURL:sourceApplication: instead");

- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(nullable NSString *)sourceApplication
           completion:(nullable ICCompletion)completion DEPRECATED_MSG_ATTRIBUTE("use handleOpenURL:sourceApplication: instead");

@end

NS_ASSUME_NONNULL_END
