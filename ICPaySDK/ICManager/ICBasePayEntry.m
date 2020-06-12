//
//  ICBasePayEntry.m
//  ICPayPlusDesign
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICBasePayEntry.h"
#import "ICError.h"

@implementation ICBasePayEntry

- (void)handleResultWithCode:(ICErrorStatusCode)code completion:(ICCompletion)completion {
    
    if (completion) {
        completion([ICError buildErrWithCode:code message:self.message]);
    }
   
}

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

@end
