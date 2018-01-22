//
//  ICUnionpayFactory.m
//  ICPaySDK
//
//  Created by iCorki on 2017/12/27.
//

#import "ICUnionpayFactory.h"
#import "UPPaymentControl.h"
#import "ICIUnionpayModel.h"
#import "ICDebugLog.h"
#import "ICAssert.h"

@interface ICUnionpayFactory()

@property (nonatomic) ICCompletion completion;

@end

@implementation ICUnionpayFactory

- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion {
    
    ICParameterAssert(controller);
    
    self.completion = completion;
    id<ICIUnionpayModel> unionModel = model;
    if (!unionModel.union_tn) {
        ICLog(@"银联支付参数 tn 为空");
        return;
    }
    
    BOOL isSuccess = [[UPPaymentControl defaultControl] startPay:unionModel.union_tn fromScheme:unionModel.scheme mode:unionModel.union_tnModel viewController:controller];
    if (isSuccess) {
        ICLog(@"调起银联支付成功");
    }else {
        ICLog(@"调起银联支付失败");
    }
}

- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           completion:(ICCompletion)completion {

    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        if([code isEqualToString:@"success"]) {
         
            [self handleResultWithCode:ICErrorStatusCodeSuccess completion:self.completion];
        }
        else if([code isEqualToString:@"fail"]) {
       
            [self handleResultWithCode:ICErrorStatusCodeFailure completion:self.completion];
        }
        else if([code isEqualToString:@"cancel"]) {
            
             [self handleResultWithCode:ICErrorStatusCodeUserCancel completion:self.completion];
        }
        self.completion = nil;
    }];
    
    return YES;
}

- (BOOL)handleOpenURL:(NSURL *)url
           completion:(ICCompletion)completion {
    return [self handleOpenURL:url
             sourceApplication:nil
                    completion:completion];
}

@end
