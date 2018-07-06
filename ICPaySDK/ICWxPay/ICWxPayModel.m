//
//  ICWxPayModel.m
//  AFNetworking
//
//  Created by iCorki. on 2018/1/20.
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

- (void)setData:(NSDictionary *)data service:(id<ICPaySDKAutoServiceProtocol>)service {
    NSString *partnerId = [service respondsToSelector:@selector(partnerIdKey)]? service.partnerIdKey: @"prepayId";
    NSString *prepayId = [service respondsToSelector:@selector(prepayIdKey)]? service.prepayIdKey: @"noncestr";
    NSString *nonceStr = [service respondsToSelector:@selector(nonceStrKey)]? service.nonceStrKey: @"timestamp";
    NSString *timeStamp = [service respondsToSelector:@selector(timeStampKey)]? service.timeStampKey: @"package";
    NSString *package = [service respondsToSelector:@selector(packageKey)]? service.packageKey: @"package";
    NSString *sign = [service respondsToSelector:@selector(signKey)]? service.signKey: @"sign";
    id pset = data[service.wxPrimaryKey];
    if ([pset isKindOfClass:[NSDictionary class]]) {
    }else {
        pset = data;
    }
    
    self.partnerId = pset[partnerId];
    self.prepayId = pset[prepayId];
    self.nonceStr = pset[nonceStr];
    self.timeStamp = [pset[timeStamp] intValue];
    self.package = pset[package];
    self.sign = pset[sign];
}

@end
