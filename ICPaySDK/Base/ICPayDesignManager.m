//
//  ICPayDesignManager.m
//  ICPayPlusDesign
//
//  Created by wangzg on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import "ICPayDesignManager.h"
#import "ICwangzgros.h"
#import "ICIAliModel.h"
#import "ICIWxModel.h"
#import "ICIUnionpayModel.h"
#import "ICPaySDKAutoServiceProtocol.h"
#import "ICBasePayEntry.h"
#import "ICBaseParamsModel.h"

static NSString *const ICALiPayChannelKey = @"ALiPayChannelKey";
static NSString *const ICWxPayChannelKey = @"WeChatPayChannelKey";
static NSString *const ICUnionPayChannelKey = @"ICUnionPayChannelKey";

@interface ICPayDesignManager()

@property (nonatomic, strong) NSMutableDictionary <NSString *, ICBasePayEntry *>*channelMap;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, weak) id<ICPayCompletionProtocol>delegate;
@property (nonatomic, strong) id<ICPaySDKAutoServiceProtocol>service;

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

- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerPayEntrys];
    }
    return self;
}

#pragma mark - public
- (void)registerSDKAutoService:(id<ICPaySDKAutoServiceProtocol>)service {
    if (service.wechatKey && service.universalLinks) {
        [self.channelMap[ICWxPayChannelKey] setAppKey:service.wechatKey universalLinks:service.universalLinks];
    }else {
        ICLog(@"ICPaySDK 微信支付注册参数缺失**************************");
    }
}

- (void)registerWx:(NSString *)appid universalLinks:(NSString *)universalLinks {
    [self.channelMap[ICWxPayChannelKey] setAppKey:appid universalLinks:universalLinks];
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
    
    ICBasePayEntry *entry = self.channelMap[self.channel];
    if (entry == nil) {
        if (completion) {
            completion(ICErrorStatusCodeChannelFail);
            ICLog(@"创建支付对象失败！！");
        }
        return;
    }
    
    [entry payWithModel:model controller:controller completion:completion];
}

- (void)payWithModel:(id)model
          controller:(nullable UIViewController *)controller
            delegate:(id<ICPayCompletionProtocol>)delegate {
    self.delegate = delegate;
    [self payWithModel:model controller:controller completion:^(ICErrorStatusCode code) {
        if ([self.delegate respondsToSelector:@selector(payManagerdidCompleteWithError:)]) {
            [self.delegate payManagerdidCompleteWithError:code];
        }
    }];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    ICBasePayEntry *entry = self.channelMap[self.channel];
    return [entry handleOpenURL:url
            sourceApplication:sourceApplication];
}

- (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity {
    ICBasePayEntry *entry = self.channelMap[self.channel];
    [entry handleOpenUniversalLink:userActivity];
}

#pragma mark - private
- (void)registerPayEntrys {
    ICLog(@"ICPaySDK 创建Entry**************************");
    ICBasePayEntry *aliPay = [NSClassFromString(@"ICAliPayEntry") new];
    ICBasePayEntry *wxPay = [NSClassFromString(@"ICWxPayEntry") new];
    ICBasePayEntry *unionPay = [NSClassFromString(@"ICUnionpayEntry") new];
    
    self.channelMap[ICALiPayChannelKey] = aliPay;
    self.channelMap[ICWxPayChannelKey] = wxPay;
    self.channelMap[ICUnionPayChannelKey] = unionPay;
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

#pragma mark - getter

- (NSMutableDictionary *)channelMap {
    if (_channelMap == nil) {
        _channelMap = [NSMutableDictionary dictionary];
    }
    return _channelMap;
}

@end

