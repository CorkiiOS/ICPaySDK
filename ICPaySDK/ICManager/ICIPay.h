//
//  ICIPay.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICPaySDKCommon.h"

NS_ASSUME_NONNULL_BEGIN
/**
 支付规范
 */
@protocol ICIPay <NSObject>

/**
 支付统一规范
 */

- (void)payWithModel:(id)model
          controller:(nullable UIViewController *)controller
          completion:(nullable ICCompletion)completion;
/**
 处理支付
 */
- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(nullable NSString *)sourceApplication;


@end

NS_ASSUME_NONNULL_END
