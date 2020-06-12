//
//  ICPayDesignManager.h
//  ICPayPlusDesign
//
//  Created by wangzg on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 错误说明
 
 - PayStatusCodeUnkonwn: 未知
 - PayStatusCodeSuccess: 支付成功
 - PayStatusCodeFailure: 支付失败
 - PayStatusCodeUserCancel: 取消支付
 - PayStatusCodeUnsupported: 没有安装客户端
 - PayStatusCodeChannelFail: 支付渠道验证失败
 
 */
typedef NS_ENUM(NSInteger, ICErrorStatusCode) {
    ICErrorStatusCodeUnkonwn,
    ICErrorStatusCodeSuccess,
    ICErrorStatusCodeFailure,
    ICErrorStatusCodeUserCancel,
    ICErrorStatusCodeUnsupported,
    ICErrorStatusCodeChannelFail
};

/**
 支付完成回调
 
 @param error 错误信息对象
 */
typedef void(^ICCompletion)(ICErrorStatusCode);

@protocol ICPaySDKAutoServiceProtocol, ICPayCompletionProtocol;

@interface ICPayDesignManager : NSObject

+ (instancetype)shareInstance;

/**
 注册微信sdk
 */
- (void)registerWx:(NSString *)appid universalLinks:(NSString *)universalLinks;

/**
 自动解析支付参数时初始化配置

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

- (void)payWithModel:(id)model
          controller:(nullable UIViewController *)controller
            delegate:(id<ICPayCompletionProtocol>)delegate;


/**
 支付回调 9.0前后统一调用此方法
 */
- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(nullable NSString *)sourceApplication;

/**
 使用通用链接回调
 */
- (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity;

@end


@protocol ICPayCompletionProtocol<NSObject>

@optional
- (void)payManagerdidCompleteWithError:(ICErrorStatusCode)error;

@end
