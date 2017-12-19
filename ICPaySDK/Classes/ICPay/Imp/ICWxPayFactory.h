//
//  ICWxPayFactory.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 ICorki. All rights reserved.
//

#import "ICBasePayFactory.h"
#import "ICIPay.h"
@interface ICWxPayFactory : ICBasePayFactory<ICIPay>

- (instancetype)initWithMessage:(ICMessageModel *)message appId:(NSString *)appId;

@end
