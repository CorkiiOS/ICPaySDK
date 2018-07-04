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
@interface ICPayDesignManager()

@property (nonatomic, strong) NSMutableDictionary <NSString *, ICBasePayFactory *>*channelMap;
@property (nonatomic, strong) NSDictionary *identifierMap;
@property (nonatomic, strong) NSMutableDictionary *replaceKeyMap;
@property (nonatomic, strong) NSString *scheme;

@property (nonatomic, strong) NSString *channel;
@property (nonatomic, weak) ICMessageModel *model;

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
    NSString *wxkey = info[ICWxPayChannelKey];
    if (wxkey) {
        [self registerSDKWithDictionary:@{ICWxPayChannelKey : wxkey} messageBlock:^(ICMessageModel * _Nonnull message) {
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
    
    [wxPay setAppKey:dictionary[ICWxPayChannelKey]];
    
    self.channelMap[ICALiPayChannelKey] = aliPay;
    self.channelMap[ICWxPayChannelKey] = wxPay;
    self.channelMap[ICUnionPayChannelKey] = unionPay;
    
}

- (void)payWithModel:(id)model
          controller:(UIViewController *)controller
          completion:(ICCompletion)completion {
    /*
     支付参数支持json
     需要一个唯一的标示来代表某种支付方式
     例如：通过 orderString 判断为支付宝支付
          通过 partnerId  判断为微信支付
          通过 tn 判断为银联支付
     
     */
    if ([model isKindOfClass:[NSString class]]) {
        NSError *error = nil;
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[model dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        model = [self parserData:data];
        
    }else if ([model isKindOfClass:[NSDictionary class]]) {
        model = [self parserData:model];
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
    
    [pay payWithModel:model
           controller:controller
           completion:completion];
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    id<ICIPay> pay = self.channelMap[self.channel];
    return [pay handleOpenURL:url
            sourceApplication:sourceApplication];
}

- (id)parserData:(NSDictionary *)data {
    if (!self.identifierMap) {
        return nil;
    }
    NSString *aliIdentifier = self.identifierMap[ICALiPayChannelKey];
    NSString *wxIdentifier = self.identifierMap[ICWxPayChannelKey];
    NSString *unionIdentifier = self.identifierMap[ICUnionPayChannelKey];
    
    if ([[data allKeys] containsObject:aliIdentifier]) {
        self.channel = ICALiPayChannelKey;
        id aliIns = [NSClassFromString(@"ICAliPayModel") new];
        if (aliIns) {
            ((void(*)(id,SEL, id, id))objc_msgSend)(aliIns, @selector(setOrderString:scheme:), data[aliIdentifier],self.scheme);
        }
        return aliIns;
        
    }else if ([[data allKeys] containsObject:wxIdentifier]) {
        self.channel = ICWxPayChannelKey;
        id wxiIns = [NSClassFromString(@"ICWxPayModel") new];
        if (wxiIns) {
            ((void(*)(id,SEL, id, id))objc_msgSend)(wxiIns, @selector(setData:keyMapper:), data[wxIdentifier],self.replaceKeyMap);
        }
        return wxiIns;
        
    }else if ([[data allKeys] containsObject:unionIdentifier]) {
        self.channel = ICUnionPayChannelKey;
        id unionIns = [NSClassFromString(@"ICUnionpayModel") new];
        if (unionIns) {
            ((void(*)(id,SEL, id, id))objc_msgSend)(unionIns, @selector(setTn:scheme:), data[unionIdentifier],self.scheme);
        }
        return unionIns;
        
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

- (void)loadAutoParserConfigWithScheme:(NSString *)scheme
                         identifierMap:(NSDictionary *)identifierMap
                         replaceKeyMap:(NSDictionary *)replaceKeyMap {
    self.identifierMap = identifierMap;
    self.replaceKeyMap = replaceKeyMap.mutableCopy;
    self.scheme = scheme;
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

