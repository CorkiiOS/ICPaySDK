//
//  ICBasePayFactory.m
//  ICPayPlusDesign
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICBasePayFactory.h"
#import "ICError.h"

@implementation ICBasePayFactory

- (void)handleResultWithCode:(ICErrorStatusCode)code completion:(ICCompletion)completion {
    
    switch (code) {
        case ICErrorStatusCodeSuccess:
        {
            //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
            if (completion) {
                completion([ICError buildErrWithCode:ICErrorStatusCodeSuccess message:self.message]);
            }
        }
            break;
        case ICErrorStatusCodeFailure:
        {
            //交易失败
            if (completion) {
                completion([ICError buildErrWithCode:ICErrorStatusCodeFailure message:self.message]);
            }
        }
            break;
        case ICErrorStatusCodeUserCancel:
        {
            if (completion) {
                completion([ICError buildErrWithCode:ICErrorStatusCodeUserCancel message:self.message]);
            }
        }
            break;
        case ICErrorStatusCodeUnsupported:
        {
            if (completion) {
                completion([ICError buildErrWithCode:ICErrorStatusCodeUnsupported message:self.message]);
            }
        }
            break;
            
        default:
            break;
    }

}

@end
