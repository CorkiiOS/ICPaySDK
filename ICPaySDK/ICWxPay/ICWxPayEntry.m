//
//  ICWxPayEntry.m
//  ICPayPlusDesign
//
//  Created by wangzg on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICWxPayEntry.h"
#import <ICIWxModel.h>
#import <WXApi.h>
#import "ICMacros.h"

@interface ICWxPayEntry()<WXApiDelegate>

@property (nonatomic) ICCompletion completion;

@end

@implementation ICWxPayEntry

- (void)setAppKey:(NSString *)appKey universalLinks:(nonnull NSString *)universalLinks {
    if (appKey) {
        BOOL isSuccess = [WXApi registerApp:appKey universalLink:universalLinks];
        if (isSuccess) {
            ICLog(@"wechatPay sdk register success");
        }else {
            ICLog(@"wechatPay sdk register failure");
        }
    }
}

/**
 微信支付实现
 */
- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion {
    self.completion = completion;
    if(![WXApi isWXAppInstalled]) {
        if (self.completion) {
            self.completion(ICErrorStatusCodeUnsupported);
        }
        return;
    }

    id<ICIWxModel> wxModel = model;
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = [wxModel partnerId];
    request.prepayId= [wxModel prepayId];
    request.package = [wxModel package];//@"Sign=WXPay"
    request.nonceStr= [wxModel nonceStr];
    request.timeStamp = [wxModel timeStamp];
    request.sign= [wxModel sign];
    [WXApi sendReq:request completion:nil];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

/**
 微信支付回调
 
 @param resp 具体的回应内容
 
 */
//WXSuccess           = 0,    /**< 成功    */
//WXErrCodeCommon     = -1,   /**< 普通错误类型    */
//WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
//WXErrCodeSentFail   = -3,   /**< 发送失败    */
//WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
//WXErrCodeUnsupport  = -5,   /**< 微信不支持    */

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]] && self.completion) {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess:
                self.completion(ICErrorStatusCodeSuccess);
                break;
                
            case WXErrCodeUserCancel:
                self.completion(ICErrorStatusCodeUserCancel);
                break;
                
            default:
                self.completion(ICErrorStatusCodeFailure);
                break;
                
        }
        self.completion = nil;
    }
}

@end
