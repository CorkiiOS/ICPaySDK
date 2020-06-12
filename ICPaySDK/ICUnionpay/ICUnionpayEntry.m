//
//  ICUnionpayEntry.m
//  ICPaySDK
//
//  Created by iCorki on 2017/12/27.
//

#import "ICUnionpayEntry.h"
#import "UPPaymentControl.h"
#import "ICIUnionpayModel.h"
#import "ICwangzgros.h"

@interface ICUnionpayEntry()

@property (nonatomic) ICCompletion completion;

@end

@implementation ICUnionpayEntry

- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion {
    
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

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        if (!self.completion) {
            return;
        }
        
        if([code isEqualToString:@"success"]) {
            self.completion(ICErrorStatusCodeSuccess);
        }
        else if([code isEqualToString:@"fail"]) {
            self.completion(ICErrorStatusCodeFailure);
        }
        else if([code isEqualToString:@"cancel"]) {
            self.completion(ICErrorStatusCodeUserCancel);
        }
        self.completion = nil;
    }];
    
    return YES;
}


@end
