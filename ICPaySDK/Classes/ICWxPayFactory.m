//
//  ICWxPayFactory.m
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICWxPayFactory.h"
#import "WXApi.h"
#import "ICIWxModel.h"
#import "ICError.h"

@interface ICWxPayFactory()<WXApiDelegate>

@property (nonatomic) ICCompletion completion;

@end

@implementation ICWxPayFactory

- (void)setAppId:(NSString *)appId {
    _appId = appId;
    if (appId) {
        BOOL isSuccess = [WXApi registerApp:appId];
        if (isSuccess) {
            NSLog(@"wechatPay sdk register success");
        }else {
            NSLog(@"wechatPay sdk register failure");
        }
    }
}

/**
 微信支付实现
 */
- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion {
    if (completion) {
        self.completion = completion;
    }
    if (completion) {
        if(![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            self.completion([ICError buildErrWithCode:ICErrorStatusCodeUnsupported message:self.message]);
            return;
        }
    }

    id<ICIWxModel> wxModel = model;
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = [wxModel partnerId];
    request.prepayId= [wxModel prepayId];
    request.package = [wxModel package];//@"Sign=WXPay"
    request.nonceStr= [wxModel nonceStr];
    request.timeStamp = [wxModel timeStamp];
    request.sign= [wxModel sign];
    [WXApi sendReq:request];
}

- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           completion:(ICCompletion)completion {
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)handleOpenURL:(NSURL *)url
           completion:(ICCompletion)completion {
    
    return [self handleOpenURL:url
             sourceApplication:nil
                    completion:completion];
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
                if (self.completion) {
                    self.completion([ICError buildErrWithCode:ICErrorStatusCodeSuccess message:self.message]);
                }
                break;
                
            case WXErrCodeUserCancel:
                if (self.completion) {
                    self.completion([ICError buildErrWithCode:ICErrorStatusCodeUserCancel message:self.message]);
                }
                break;
            default:
            {
                if (self.completion) {
                    self.completion([ICError buildErrWithCode:ICErrorStatusCodeFailure message:self.message]);
                }
            }
                break;
                
        }
    }
}

@end

/*
- (void)payWithCharge:(ICPayCharge *)charge
scheme:(NSString *)scheme
controller:(UIViewController *)controller
completion:(ICCompletion)completion {
    
    if (completion) {
        self.completion = completion;
    }
    if (completion) {
        if(![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            self.completion([ICError buildErrWithCode:ICErrorStatusCodeUnsupported]);
            return;
        }
    }
    
    NSDictionary *dict = charge.credential;
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = dict[@"partnerId"];
    request.prepayId= dict[@"prepayId"];
    request.package = @"Sign=WXPay";
    request.nonceStr= dict[@"noncestr"];
    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
    request.timeStamp =   stamp.intValue;;
    request.sign= dict[@"sign"];
    [WXApi sendReq:request];
}
*/
