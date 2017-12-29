//
//  ICAliPayFactory.m
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICAliPayFactory.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ICAssert.h"
#import "ICIAliModel.h"

@interface ICAliPayFactory()

@property (nonatomic) ICCompletion completion;

@end

@implementation ICAliPayFactory

- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion {
    
    self.completion = completion;
    id<ICIAliModel> aliModel = model;
    [[AlipaySDK defaultService] payOrder:aliModel.orderString
                              fromScheme:aliModel.scheme
                                callback:^(NSDictionary *resultDic) {
                                    [self handleResult:resultDic];
                                }];
}

- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           completion:(ICCompletion)completion {
    
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                              standbyCallback:^(NSDictionary *resultDic) {
        [self handleResult:resultDic];
    }];
    return YES;
}

- (BOOL)handleOpenURL:(NSURL *)url
           completion:(ICCompletion)completion {
    
    return [self handleOpenURL:url
             sourceApplication:nil
                    completion:completion];
}

/**
 处理支付回调 分析／解析
 
 @param result 结果集
 */
- (void)handleResult:(NSDictionary *)result {
    NSInteger code = [result[@"resultStatus"] integerValue];
    if (code == 9000) {
        [self handleResultWithCode:ICErrorStatusCodeSuccess completion:self.completion];
    }else if (code == 6001) {
        [self handleResultWithCode:ICErrorStatusCodeUserCancel completion:self.completion];
    }else {
        [self handleResultWithCode:ICErrorStatusCodeFailure completion:self.completion];
    }

    self.completion = nil;
}
/*
 resultStatus，状态码，SDK里没对应信息，第一个文档里有提到：
 9000 订单支付成功
 8000 正在处理中
 4000 订单支付失败
 6001 用户中途取消
 6002 网络连接出错
 memo， 提示信息，比如状态码为6001时，memo就是“用户中途取消”。但千万别完全依赖这个信息，如果未安装支付宝app，采用网页支付时，取消时状态码是6001，但这个memo是空的。。（当我发现这个问题的时候，我就决定，对于这么不靠谱的SDK，还是尽量靠自己吧。。）
 result，订单信息，以及签名验证信息。如果你不想做签名验证，那这个字段可以忽略了。。
 
 - (void)payWithCharge:(ICPayCharge *)charge
 scheme:(NSString *)scheme
 controller:(UIViewController *)controller
 completion:(ICCompletion)completion {
 
 self.completion = completion;
 
 [[AlipaySDK defaultService] payOrder:charge.orderString
 fromScheme:scheme
 callback:^(NSDictionary *resultDic) {
 [self handleResult:resultDic];
 }];
 }
 */

@end
