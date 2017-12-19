//
//  ICPaySDK.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 ICorki. All rights reserved.
//

#ifndef ICPaySDK_h
#define ICPaySDK_h
#import "ICError.h"
#import "ICMessageModel.h"
@class ICError;
/**
 支付完成回调
 
 @param error 错误信息对象
 */
typedef void(^ICCompletion)(ICError *error);
/** @brief 支付宝渠道key*/
static NSString *const ICALiPayChannelKey = @"ALiPayChannelKey";
/** @brief 微信渠道key*/
static NSString *const ICWxPayChannelKey = @"WeChatPayChannelKey";

#endif /* ICPaySDK_h */
