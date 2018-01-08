//
//  ICPayUtils.h
//  ICPaySDK_Example
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 corkiios. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ICPayBlock)(NSString * _Nullable message);

@interface ICPayUtils : NSObject


/* 按照自己的需求封装  */

+ (void)aliPayWithURL:(nonnull NSString *)URL
               params:(nullable NSDictionary *)params
              success:(nonnull ICPayBlock)success
              failure:(nonnull ICPayBlock)failure
               cancel:(nonnull ICPayBlock)cancel;


+ (void)wxPayWithURL:(NSString *_Nonnull)URL
                params:(NSDictionary *_Nullable)params
                success:(ICPayBlock _Nonnull)success
                failure:(ICPayBlock _Nonnull)failure
                 cancel:(ICPayBlock _Nonnull)cancel;

+ (void)unionPayWithURL:(NSString *_Nonnull)URL
                 params:(NSDictionary *_Nullable)params
             controller:(UIViewController *_Nonnull)controller
                success:(nonnull ICPayBlock)success
                failure:(nonnull ICPayBlock)failure
                 cancel:(nonnull ICPayBlock)cancel;

@end
