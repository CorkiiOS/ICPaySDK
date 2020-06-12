//
//  ICBasePayEntry.h
//  ICPayPlusDesign
//
//  Created by wangzg on 2017/12/19.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICPayDesignManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ICBasePayEntry : NSObject

- (void)setAppKey:(NSString *)appKey universalLinks:(NSString *)universalLinks;

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

/**
 处理通用链接
 */
- (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity;

@end

NS_ASSUME_NONNULL_END

