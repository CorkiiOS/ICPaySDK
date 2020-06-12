//
//  ICWxPayEntry.m
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICWxPayEntry.h"
#import <ICPaySDK/ICDebugLog.h>
#import <ICIWxModel.h>
#import <WXApi.h>
@interface ICWxPayEntry()<WXApiDelegate>

@property (nonatomic) ICCompletion completion;

@end

@implementation ICWxPayEntry

- (void)setAppKey:(NSString *)appKey universalLinks:(nonnull NSString *)universalLinks {
    if (appKey) {
        BOOL isSuccess = NO;
        if ([WXApi respondsToSelector:@selector(registerApp:universalLink:)]) {
            isSuccess = [WXApi performSelector:@selector(registerApp:universalLink:) withObject:appKey withObject:universalLinks];
        }else if ([WXApi respondsToSelector:@selector(registerApp:)]) {
            isSuccess = [WXApi performSelector:@selector(registerApp:) withObject:appKey];
        }
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
    if(![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [self handleResultWithCode:ICErrorStatusCodeUnsupported completion:self.completion];
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
    if ([WXApi respondsToSelector:@selector(sendReq:completion:)]) {
        [WXApi performSelector:@selector(sendReq:completion:) withObject:request withObject:nil];
    }else {
        if ([WXApi respondsToSelector:@selector(sendReq:)]) {
            [WXApi performSelector:@selector(sendReq:) withObject:request];
        }
    }
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    return [WXApi handleOpenURL:url delegate:self];
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
    
    if ([resp isKindOfClass:[PayResp class]]) {
        
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess:
                [self handleResultWithCode:ICErrorStatusCodeSuccess completion:self.completion];

                break;
                
            case WXErrCodeUserCancel:
                [self handleResultWithCode:ICErrorStatusCodeUserCancel completion:self.completion];

                break;
            default:
                [self handleResultWithCode:ICErrorStatusCodeFailure completion:self.completion];

                break;
                
        }
        self.completion = nil;
    }
}

@end
