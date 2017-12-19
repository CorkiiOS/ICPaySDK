//
//  ICMessageModel.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICMessageModel : NSObject

/** @brief success message 支付成功*/
@property (nonatomic, strong, nullable) NSString *success;

/** @brief failure message 支付失败*/
@property (nonatomic, strong, nullable) NSString *failure;

/** @brief cancel message 取消支付*/
@property (nonatomic, strong, nullable) NSString *cancel;

/** @brief failure message 没有安装客户端*/
@property (nonatomic, strong, nullable) NSString *unsupported;

/** @brief failure message 支付渠道验证错误*/
@property (nonatomic, strong, nullable) NSString *channelFail;


@end

