//
//  ICIWxModel.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ICIWxModel <NSObject>

/** 商家向财付通申请的商家id */
- (NSString *)partnerId;

/** 预支付订单 */
- (NSString *)prepayId;

/** 随机串，防重发 */
- (NSString *)nonceStr;

/** 时间戳，防重发 */
- (UInt32)timeStamp;

/** 商家根据财付通文档填写的数据和签名 */
- (NSString *)package;

/** 商家根据微信开放平台文档对数据做的签名 */
- (NSString *)sign;

@end
