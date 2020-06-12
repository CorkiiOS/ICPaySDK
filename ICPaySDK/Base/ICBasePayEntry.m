//
//  ICBasePayEntry.m
//  ICPayPlusDesign
//
//  Created by wangzg on 2017/12/19.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICBasePayEntry.h"

@implementation ICBasePayEntry

- (void)setAppKey:(NSString *)appKey universalLinks:(NSString *)universalLinks {
    
}

/**
 支付统一规范
 */

- (void)payWithModel:(id)model
          controller:(nullable UIViewController *)controller
          completion:(nullable ICCompletion)completion {
}
/**
 处理支付
 */
- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(nullable NSString *)sourceApplication {
    return YES;
}

- (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity {
    return YES;
}

@end
