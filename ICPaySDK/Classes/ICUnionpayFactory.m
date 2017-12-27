//
//  ICUnionpayFactory.m
//  ICPaySDK
//
//  Created by 王志刚 on 2017/12/27.
//

#import "ICUnionpayFactory.h"
#import "UPPaymentControl.h"
#import "ICIUnionpayModel.h"
#import "ICError.h"
@interface ICUnionpayFactory()

@property (nonatomic) ICCompletion completion;

@end

@implementation ICUnionpayFactory

- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion {
    
    self.completion = completion;
    id<ICIUnionpayModel> unionModel = model;
    if (!unionModel.union_tn) {
        return;
    }
    
    [[UPPaymentControl defaultControl] startPay:unionModel.union_tn fromScheme:unionModel.scheme mode:unionModel.union_tnModel viewController:controller];

}

- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           completion:(ICCompletion)completion {

    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        if([code isEqualToString:@"success"]) {
            //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
            self.completion([ICError buildErrWithCode:ICErrorStatusCodeSuccess message:self.message]);
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
            self.completion([ICError buildErrWithCode:ICErrorStatusCodeFailure message:self.message]);
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
            self.completion([ICError buildErrWithCode:ICErrorStatusCodeUserCancel message:self.message]);
        }
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
