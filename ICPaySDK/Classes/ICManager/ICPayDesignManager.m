//
//  ICPayDesignManager.m
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICPayDesignManager.h"
#import <objc/message.h>
#import "ICIPay.h"
#import "ICAssert.h"
#import "ICDebugLog.h"
#import "ICPaySDKCommon.h"
#import "ICMessageModel.h"
#import "ICIAliModel.h"
#import "ICIWxModel.h"
#import "ICIUnionpayModel.h"
#import "ICError.h"

@interface ICPayDesignManager()

@property (nonatomic, strong) NSDictionary *channelMap;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, weak) ICMessageModel *model;

@end

@implementation ICPayDesignManager

+ (instancetype)shareInstance {
    static ICPayDesignManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (void)registerSDKWithDictionary:(NSDictionary *)dictionary
                     messageBlock:(void (^)(ICMessageModel *))messageBlock {
   
    [self _registerSDKWithOption:nil dictionary:dictionary messageBlock:messageBlock];
}

- (void)registerSDKOption:(void (^)())option messageBlock:(void (^)(ICMessageModel *))messageBlock {
    
    [self _registerSDKWithOption:option dictionary:nil messageBlock:messageBlock];
}

- (void)_registerSDKWithOption:(void (^)())option
                           dictionary:(NSDictionary *)dictionary
                             messageBlock:(void (^)(ICMessageModel *))messageBlock {
    if (option) {
        option();
    }
    
    ICMessageModel *model = [ICMessageModel new];
    if (messageBlock) {
        messageBlock(model);
    }
    NSString *appid = dictionary[ICWxPayChannelKey];

    id aliIns = [NSClassFromString(@"ICAliPayFactory") new];
    id wxiIns = [NSClassFromString(@"ICWxPayFactory") new];
    id unionIns = [NSClassFromString(@"ICUnionpayFactory") new];

    self.model = model;

    if (wxiIns) {
        ((void(*)(id,SEL, id))objc_msgSend)(wxiIns, @selector(setMessage:), model);
        ((void(*)(id,SEL, id))objc_msgSend)(wxiIns, @selector(setAppId:), appid);
        [self.channelMap setValue:wxiIns forKey:ICWxPayChannelKey];
    }
    
    if (aliIns) {
        ((void(*)(id,SEL, id))objc_msgSend)(aliIns, @selector(setMessage:), model);
        [self.channelMap setValue:aliIns forKey:ICALiPayChannelKey];
    }
    
    if (unionIns) {
        ((void(*)(id,SEL, id))objc_msgSend)(unionIns, @selector(setMessage:), model);
        [self.channelMap setValue:unionIns forKey:ICUnionPayChannelKey];
    }
}

/**
 消除警告
 */
- (void)initWithMessage:(id)msg {};
- (void)initWithMessage:(id)msg appId:(id)appid {};

- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion {
    
    if ([model conformsToProtocol:@protocol(ICIWxModel)]) {
        self.channel = ICWxPayChannelKey;
    }
    
    if ([model conformsToProtocol:@protocol(ICIAliModel)]) {
        self.channel = ICALiPayChannelKey;
    }
    
    if ([model conformsToProtocol:@protocol(ICIUnionpayModel)]) {
        self.channel = ICUnionPayChannelKey;
    }
    
    id<ICIPay> pay = self.channelMap[self.channel];
    
    if (pay == nil) {
        if (completion) {
            completion([ICError buildErrWithCode:ICErrorStatusCodeChannelFail message:self.model]);
            ICLog(@"创建支付对象失败！！");
        }
        return;
    }
    
    [pay payWithModel:model
           controller:controller
           completion:completion];
}

- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           completion:(ICCompletion)completion {
    
    id<ICIPay> pay = self.channelMap[self.channel];
    return [pay handleOpenURL:url
            sourceApplication:sourceApplication
                   completion:completion];
}

- (BOOL)handleOpenURL:(NSURL *)url
           completion:(ICCompletion)completion {
    
    return [self handleOpenURL:url
             sourceApplication:nil
                    completion:completion];
}
#pragma mark - getter

- (NSDictionary *)channelMap {
    if (_channelMap == nil) {
        _channelMap = [NSMutableDictionary dictionary];
    }
    return _channelMap;
}

@end


/*- (void)payWithCharge:(NSString *)result
 scheme:(NSString *)scheme
 controller:(UIViewController *)controller
 completion:(ICCompletion)completion {
 
 ICJsonParsing *jsonParse = [[ICJsonParsing alloc] init];
 ICParsingContext *context = [[ICParsingContext alloc] initWithParsing:jsonParse];
 ICPayCharge *payCharge = [context parsing:result];
 self.channel = payCharge.channel;
 id<ICIPay> pay = self.channelMap[payCharge.channel];
 if (pay == nil) {
 if (completion) {
 completion([ICError buildErrWithCode:ICErrorStatusCodeChannelFail]);
 }
 return;
 }
 
 [pay payWithCharge:payCharge
 scheme:scheme
 controller:controller
 completion:completion];
 }*/
