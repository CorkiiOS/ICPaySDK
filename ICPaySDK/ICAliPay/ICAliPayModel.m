//
//  ICAliPayModel.m
//  AFNetworking
//
//  Created by iCorki. on 2018/1/20.
//

#import "ICAliPayModel.h"

@implementation ICAliPayModel

- (NSString *)scheme {
    return _scheme;
}

- (NSString *)orderString {
    return _orderString;
}

- (void)setData:(NSDictionary *)data service:(id<ICPaySDKAutoServiceProtocol>)service {
    self.scheme = service.scheme;
    self.orderString = data[service.aliPrimarykey];
}

@end
