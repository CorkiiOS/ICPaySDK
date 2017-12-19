//
//  ICBasePayFactory.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 ICorki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICIPay.h"

@class ICMessageModel;

@interface ICBasePayFactory : NSObject<ICIPay>

@property (nonatomic, strong) ICMessageModel *message;

- (instancetype)initWithMessage:(ICMessageModel *)message;

@end
