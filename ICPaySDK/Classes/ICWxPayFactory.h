//
//  ICWxPayFactory.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 ICorki. All rights reserved.
//

#import "ICBasePayFactory.h"
@interface ICWxPayFactory : ICBasePayFactory

- (instancetype)initWithMessage:(ICMessageModel *)message appId:(NSString *)appId;

@end
