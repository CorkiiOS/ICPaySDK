//
//  WxModel.m
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "WxModel.h"
#import "payRequsestHandler.h"
@implementation WxModel

/** 商家向财付通申请的商家id */
- (NSString *)partnerId {
    return _partnerId;
}

/** 预支付订单 */
- (NSString *)prepayId {
    return _prepayId;
}

/** 随机串，防重发 */
- (NSString *)nonceStr {
    return _nonceStr;
}

/** 时间戳，防重发 */
- (UInt32)timeStamp {
    return _timeStamp;
}

/** 商家根据财付通文档填写的数据和签名 */
- (NSString *)package {
    return _package;
}

/** 商家根据微信开放平台文档对数据做的签名 */
- (NSString *)sign {
    return _sign;
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    _partnerId = data[@"partnerId"];
    _prepayId = data[@"prepayId"];
    _package = @"Sign=WXPay";
    _nonceStr= data[@"noncestr"];
    NSMutableString *stamp  = [data objectForKey:@"timestamp"];
    _timeStamp =   stamp.intValue;
    _sign = data[@"sign"];
}
@end
