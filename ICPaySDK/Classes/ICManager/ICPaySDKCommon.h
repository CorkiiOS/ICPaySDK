//
//  ICPaySDK.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#ifndef ICPaySDKCommon_h
#define ICPaySDKCommon_h
#if __OBJC__

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


@class ICError;

/**
 支付完成回调
 
 @param error 错误信息对象
 */
typedef void(^ICCompletion)(ICError *);
/** @brief 支付宝渠道key 不需要操作*/
static NSString *const ICALiPayChannelKey = @"ALiPayChannelKey";
/** @brief 微信渠道key*/
static NSString *const ICWxPayChannelKey = @"WeChatPayChannelKey";

static NSString *const ICUnionPayChannelKey = @"ICUnionPayChannelKey";

#endif
#endif /* ICPaySDK_h */
