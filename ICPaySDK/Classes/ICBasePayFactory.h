//
//  ICBasePayFactory.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICIPay.h"

NS_ASSUME_NONNULL_BEGIN

@class ICMessageModel;

@interface ICBasePayFactory : NSObject<ICIPay>

@property (nonatomic, strong, nullable) ICMessageModel *message;

- (instancetype)initWithMessage:(nullable ICMessageModel *)message;

@end

NS_ASSUME_NONNULL_END
