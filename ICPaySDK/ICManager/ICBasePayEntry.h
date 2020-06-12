//
//  ICBasePayEntry.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICIPay.h"

NS_ASSUME_NONNULL_BEGIN

@class ICMessageModel;

@interface ICBasePayEntry : NSObject<ICIPay>

@property (nonatomic, strong, nullable) ICMessageModel *message;

- (void)setAppKey:(NSString *)appKey universalLinks:(NSString *)universalLinks;

- (void)handleResultWithCode:(ICErrorStatusCode)code completion:(ICCompletion)completion;

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
