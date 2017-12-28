//
//  ICError.m
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICError.h"
#import "ICMessageModel.h"

/** @brief err message 支付成功*/
static NSString *const ICErrorMessageSuccess = @"支付成功";
/** @brief err message 支付失败*/
static NSString *const ICErrorMessageFailure = @"支付失败";
/** @brief err message 取消支付*/
static NSString *const ICErrorMessageUserCancel = @"取消支付";
/** @brief err message 没有安装客户端*/
static NSString *const ICErrorMessageUnsupported = @"没有安装客户端";
/** @brief err message 支付渠道验证错误*/
static NSString *const ICErrorMessageChannelFail = @"支付渠道验证错误";

@interface ICError()

@property (nonatomic) NSMutableDictionary* errorMaps;
- (NSString *(^)(ICErrorStatusCode))msg;

@end

@implementation ICError

+ (instancetype)buildErrWithCode:(ICErrorStatusCode)code
                         message:(ICMessageModel *)message {
    ICError *err = [[ICError alloc] initWithMessage:message];
    err.status = code;
    return err;
}

- (instancetype)initWithMessage:(ICMessageModel *)message {
    self = [super init];
    if (self) {

        NSString *success = message.success ?: ICErrorMessageSuccess;
        NSString *failure = message.failure ?: ICErrorMessageFailure;
        NSString *unsupported = message.unsupported ?: ICErrorMessageUnsupported;
        NSString *cancel = message.cancel ?: ICErrorMessageUserCancel;
        NSString *channelFail = message.channelFail ?: ICErrorMessageChannelFail;
       
        [self.errorMaps setObject:success forKey:self.msg(ICErrorStatusCodeSuccess)];
        [self.errorMaps setObject:failure forKey:self.msg(ICErrorStatusCodeFailure)];
        [self.errorMaps setObject:unsupported forKey:self.msg(ICErrorStatusCodeUnsupported)];
        [self.errorMaps setObject:cancel forKey:self.msg(ICErrorStatusCodeUserCancel)];
        [self.errorMaps setObject:channelFail forKey:self.msg(ICErrorStatusCodeChannelFail)];
        
    }
    return self;
}

- (NSInteger)statusCode {
    return self.status;
}

- (NSString *)message {
    return [self.errorMaps objectForKey:self.msg(self.status)];
}

- (NSString *(^)(ICErrorStatusCode))msg {
    return  ^(ICErrorStatusCode status){
        return [NSString stringWithFormat:@"%lu",(unsigned long)status];
    };
}

- (NSMutableDictionary *)errorMaps {
    if (_errorMaps == nil) {
        _errorMaps = [NSMutableDictionary dictionary];
    }
    return _errorMaps;
}

@end
