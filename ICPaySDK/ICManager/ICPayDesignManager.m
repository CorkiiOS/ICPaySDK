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
#import "ICPaySDKAutoServiceProtocol.h"
#import "ICBasePayFactory.h"
#import "ICBaseParamsModel.h"
@interface ICPayDesignManager()

@property (nonatomic, strong) NSMutableDictionary <NSString *, ICBasePayFactory *>*channelMap;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, weak) ICMessageModel *model;
@property (nonatomic, weak) id<ICPayCompletionProtocol>delegate;
@property (nonatomic, strong) id<ICPaySDKAutoServiceProtocol>service;

@end

@implementation ICPayDesignManager

+ (void)load {
    [self performSelectorOnMainThread:@selector(shareInstance) withObject:nil waitUntilDone:NO];
}

+ (instancetype)shareInstance {
    static ICPayDesignManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)noti {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *wxkey = info[@"ICWxPayChannelKey"];
    if (wxkey) {
        ICLog(@"info.plist 检测到注册配置");
        [self _registerSDKWithOption:nil dictionary:@{ICWxPayChannelKey : wxkey} messageBlock:^(ICMessageModel *message) {
            message.cancel = @"支付取消";
            message.success = @"支付成功";
            message.failure = @"支付失败";
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark impl

- (void)registerSDKAutoService:(id<ICPaySDKAutoServiceProtocol>)service {
    if (service.wechatKey) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[ICWxPayChannelKey] = service.wechatKey;
        params[ICWxPayUniversalLinks] = service.universalLinks;
        [self _registerSDKWithOption:nil dictionary:params messageBlock:nil];
    }
}

- (void)registerSDKWithDictionary:(NSDictionary *)dictionary {
    [self _registerSDKWithOption:nil dictionary:dictionary messageBlock:nil];
}

- (void)_registerSDKWithOption:(void (^)())option
                           dictionary:(NSDictionary *)dictionary
                             messageBlock:(void (^)(ICMessageModel *))messageBlock {
    if (option) {
        option();
    }
    ICLog(@"ICPaySDK 开始注册**************************");
    ICMessageModel *model = [ICMessageModel new];
    if (messageBlock) {
        messageBlock(model);
    }

    ICBasePayFactory *aliPay = [NSClassFromString(@"ICAliPayFactory") new];
    ICBasePayFactory *wxPay = [NSClassFromString(@"ICWxPayFactory") new];
    ICBasePayFactory *unionPay = [NSClassFromString(@"ICUnionpayFactory") new];
    
    aliPay.message = model;
    wxPay.message = model;
    unionPay.message = model;
    
    [wxPay setAppKey:dictionary[ICWxPayChannelKey] universalLinks:dictionary[ICWxPayUniversalLinks]];
    
    self.channelMap[ICALiPayChannelKey] = aliPay;
    self.channelMap[ICWxPayChannelKey] = wxPay;
    self.channelMap[ICUnionPayChannelKey] = unionPay;
    
    ICLog(@"ICPaySDK 注册完成*****************方式  ******%@ *****%@ ****%@",aliPay,wxPay,unionPay);

}

- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion {
    if ([model isKindOfClass:[NSString class]]) {
        NSError *error = nil;
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[model dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        model = [self modelWithData:data];
        
    }else if ([model isKindOfClass:[NSDictionary class]]) {
        model = [self modelWithData:model];
    }else {
        if ([model conformsToProtocol:@protocol(ICIWxModel)]) {
            self.channel = ICWxPayChannelKey;
        }
        
        if ([model conformsToProtocol:@protocol(ICIAliModel)]) {
            self.channel = ICALiPayChannelKey;
        }
        
        if ([model conformsToProtocol:@protocol(ICIUnionpayModel)]) {
            self.channel = ICUnionPayChannelKey;
        }
    }
    
    if (model == nil) {
        ICLog(@"支付参数获取失败失败！！");
        return;
    }
    
    id<ICIPay> pay = self.channelMap[self.channel];
    if (pay == nil) {
        if (completion) {
            completion([ICError buildErrWithCode:ICErrorStatusCodeChannelFail message:self.model]);
            ICLog(@"创建支付对象失败！！");
        }
        return;
    }
    
    [pay payWithModel:model controller:controller completion:completion];
}

- (void)payWithModel:(id)model
          controller:(nullable UIViewController *)controller
            delegate:(id<ICPayCompletionProtocol>)delegate {
    self.delegate = delegate;
    [self payWithModel:model controller:controller completion:^(ICError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(payManagerdidCompleteWithError:)]) {
            [self.delegate payManagerdidCompleteWithError:error];
        }
    }];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    id<ICIPay> pay = self.channelMap[self.channel];
    return [pay handleOpenURL:url
            sourceApplication:sourceApplication];
}

- (id)modelWithData:(NSDictionary *)data {
    NSString *aliIdentifier = self.service.aliPrimarykey;
    NSString *wxIdentifier = self.service.wxPrimaryKey;
    NSString *unionIdentifier = self.service.uniPrimarykey;
    NSString *scheme = self.service.scheme;

    if ([[data allKeys] containsObject:aliIdentifier]) {
        self.channel = ICALiPayChannelKey;
        ICBaseParamsModel *ali = [NSClassFromString(@"ICAliPayModel") new];
        [ali setData:data service:self.service];
        return ali;

    }else if ([[data allKeys] containsObject:wxIdentifier]) {
        self.channel = ICWxPayChannelKey;
        ICBaseParamsModel *wx = [NSClassFromString(@"ICWxPayModel") new];
        [wx setData:data service:self.service];
        return wx;

    }else if ([[data allKeys] containsObject:unionIdentifier]) {
        self.channel = ICUnionPayChannelKey;
        ICBaseParamsModel *un = [NSClassFromString(@"ICUnionpayModel") new];
        [un setData:data service:self.service];
        return un;
    }
    return nil;
}

- (void)setGlobalPayCancelText:(NSString *)text {
    self.channelMap[ICALiPayChannelKey].message.cancel = text;
    self.channelMap[ICWxPayChannelKey].message.cancel = text;
    self.channelMap[ICUnionPayChannelKey].message.cancel = text;
}

- (void)setGlobalPaySuccessText:(NSString *)text {
    self.channelMap[ICALiPayChannelKey].message.success = text;
    self.channelMap[ICWxPayChannelKey].message.success = text;
    self.channelMap[ICUnionPayChannelKey].message.success = text;
}

- (void)setGlobalPayFailureText:(NSString *)text {
    self.channelMap[ICALiPayChannelKey].message.failure = text;
    self.channelMap[ICWxPayChannelKey].message.failure = text;
    self.channelMap[ICUnionPayChannelKey].message.failure = text;
}

#pragma mark - getter

- (NSMutableDictionary *)channelMap {
    if (_channelMap == nil) {
        _channelMap = [NSMutableDictionary dictionary];
    }
    return _channelMap;
}








/**************************************即将废弃***********************************/
- (void)registerSDKWithDictionary:(NSDictionary *)dictionary
                     messageBlock:(void (^)(ICMessageModel *))messageBlock {
    
    [self _registerSDKWithOption:nil dictionary:dictionary messageBlock:messageBlock];
}

- (void)registerSDKOption:(void (^)())option messageBlock:(void (^)(ICMessageModel *))messageBlock {
    
    [self _registerSDKWithOption:option dictionary:nil messageBlock:messageBlock];
}

- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           completion:(ICCompletion)completion {
    id<ICIPay> pay = self.channelMap[self.channel];
    return [pay handleOpenURL:url
            sourceApplication:sourceApplication];
}

- (BOOL)handleOpenURL:(NSURL *)url
           completion:(ICCompletion)completion {
    return [self handleOpenURL:url
             sourceApplication:nil
                    completion:completion];
}

@end

