//
//  ICIAliModel.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ICIAliModel <NSObject>
/**  白名单*/
- (NSString *)scheme;

/**
 支付宝签名
 */
- (NSString *)orderString;

@end
