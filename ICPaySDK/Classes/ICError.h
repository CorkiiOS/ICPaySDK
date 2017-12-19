//
//  ICError.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 ICorki. All rights reserved.
//



#import <Foundation/Foundation.h>

@class ICMessageModel;
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

@interface ICError : NSObject

@property (nonatomic) ICErrorStatusCode status;

+ (instancetype)buildErrWithCode:(ICErrorStatusCode)code
                         message:(ICMessageModel *)message;
/**
 获取错误码
 
 @return 状态吗
 */
- (NSInteger)statusCode;

/**
 获取支付回调信息
 
 @return 支付回调信息
 */
- (NSString *)message;

@end
