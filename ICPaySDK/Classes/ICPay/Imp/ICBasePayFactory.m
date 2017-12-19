//
//  ICBasePayFactory.m
//  ICPayPlusDesign
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 ICorki. All rights reserved.
//

#import "ICBasePayFactory.h"

@implementation ICBasePayFactory

- (instancetype)initWithMessage:(ICMessageModel *)message {
    self = [super init];
    if (self) {
        
        _message = message;
    }
    return self;
}


@end
