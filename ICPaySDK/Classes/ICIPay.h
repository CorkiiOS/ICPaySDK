//
//  ICIPay.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 ICorki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICPaySDK.h"

/**
 支付规范
 */
@protocol ICIPay <NSObject>

/**
 支付统一规范
 */

- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion;
/**
 处理支付回调9.0
 */
- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           completion:(ICCompletion)completion;


/**
 处理支付回调9.0以后
 */
- (BOOL)handleOpenURL:(NSURL *)url
           completion:(ICCompletion)completion;
@end
