//
//  UnionModel.m
//  ICPaySDK_Example
//
//  Created by iCorki on 2017/12/27.
//  Copyright © 2017年 corkiios. All rights reserved.
//

#import "UnionModel.h"

@implementation UnionModel

- (NSString *)scheme {
    return @"AliPayURLScheme.ic";
}

- (NSString *)union_tn {
    return _tn;
}

- (NSString *)union_tnModel {
    return @"01";//测试环境
}

@end
