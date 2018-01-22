//
//  ICAliPayModel.m
//  AFNetworking
//
//  Created by 王志刚 on 2018/1/20.
//

#import "ICAliPayModel.h"

@implementation ICAliPayModel

- (NSString *)scheme {
    return _scheme;
}

- (NSString *)orderString {
    return _orderString;
}

- (void)setOrderString:(NSString *)orderString scheme:(NSString *)scheme {
    self.scheme = scheme;
    self.orderString = orderString;
}

@end
