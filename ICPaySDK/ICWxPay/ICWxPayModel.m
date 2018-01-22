//
//  ICWxPayModel.m
//  AFNetworking
//
//  Created by 王志刚 on 2018/1/20.
//

#import "ICWxPayModel.h"
#import "ICDebugLog.h"
@implementation ICWxPayModel

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

- (void)setData:(id)data
      keyMapper:(NSDictionary *)keyMapper {
    
    if ([data isKindOfClass:[NSString class]]) {
        NSError *error = nil;
        data = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            ICLog(@"微信支付参数解析失败");
            return;
        }
    }
    
    NSString *partnerId = keyMapper[@"partnerId"] ?: @"partnerId";
    NSString *prepayId = keyMapper[@"prepayId"] ?: @"prepayId";
    NSString *nonceStr = keyMapper[@"nonceStr"] ?: @"noncestr";
    NSString *timeStamp = keyMapper[@"timeStamp"] ?: @"timestamp";
    NSString *package = keyMapper[@"package"] ?: @"package";
    NSString *sign = keyMapper[@"sign"] ?: @"sign";

    self.partnerId = data[partnerId];
    self.prepayId = data[prepayId];
    self.nonceStr = data[nonceStr];
    self.timeStamp = [data[timeStamp] intValue];
    self.package = data[package];
    self.sign = data[sign];

}

@end
