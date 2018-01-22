//
//  ICError.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "ICPaySDKCommon.h"
@class ICMessageModel;

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
