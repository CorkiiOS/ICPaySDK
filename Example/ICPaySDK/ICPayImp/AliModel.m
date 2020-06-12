//
//  AliModel.m
//  ICPayPlusDesign
//
//  Created by wangzg on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "AliModel.h"

@implementation AliModel
/**  白名单*/
- (NSString *)scheme {
    return @"AliPayURLScheme.ic";
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
