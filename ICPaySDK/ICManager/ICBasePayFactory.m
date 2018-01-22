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
    
    if (completion) {
        completion([ICError buildErrWithCode:code message:self.message]);
    }
   
}

@end
