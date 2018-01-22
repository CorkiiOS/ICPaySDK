

//
//  ICPayUtils.m
//  ICPaySDK_Example
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 corkiios. All rights reserved.
//

#import "ICPayUtils.h"
#import <AFNetworking.h>
#import <ICPaySDK.h>
#import "AliModel.h"
#import "WxModel.h"
#import "UnionModel.h"



@implementation ICPayUtils

+ (void)aliPayWithURL:(NSString *)URL
               params:(NSDictionary *)params
              success:(ICPayBlock)success
              failure:(ICPayBlock)failure
               cancel:(ICPayBlock)cancel {
    //替换成自己项目中的网络请求
    [[AFHTTPSessionManager manager] POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable data) {
        if ([[data objectForKey:@"status"] integerValue] == 200) {
            //拿到后台签名
            NSString *orderString = data[@"data"][@"alipay"];
            if (orderString) {
                
                //采用自建模型
//                AliModel *model = [AliModel new];
//                model.orderString = @"签名信息";
                //采用自动解析方式
                [ICPayUtils _payWithModel:@{@"alipay" : orderString} controller:nil success:success failure:failure cancel:cancel];
            }

        }else {
            failure(@"网络等其他情况");

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"网络等其他情况");
    }];
}

+ (void)wxPayWithURL:(NSString *)URL
              params:(NSDictionary *)params
             success:(ICPayBlock)success
             failure:(ICPayBlock)failure
              cancel:(ICPayBlock)cancel {

    //替换成自己项目中的网络请求
    [[AFHTTPSessionManager manager] POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable data) {
        if ([[data objectForKey:@"status"] integerValue] == 200) {
            //拿到后台签名
            NSDictionary *dic = data[@"data"][@"weChatPay"];
            [ICPayUtils _payWithModel:@{@"weChatPay" : dic} controller:nil success:success failure:failure cancel:cancel];
            
        }else {
            failure(@"网络等其他情况");
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"网络等其他情况");
    }];
}

+ (void)unionPayWithURL:(NSString *)URL
                 params:(NSDictionary *)params
             controller:(UIViewController *)controller
                success:(ICPayBlock)success
                failure:(ICPayBlock)failure
                 cancel:(ICPayBlock)cancel {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = serializer;
    
    [manager POST:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData*  _Nullable data) {
        
        NSString *tn = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
//        UnionModel *model = [UnionModel new];
//        model.tn = tn;
        /*
         经过测试 银联SDK会一直引用 self 再调用一次 银联SDK 支付接口 此处self 才dealloc
         
         
         [[UPPaymentControl defaultControl] startPay:unionModel.union_tn fromScheme:unionModel.scheme mode:unionModel.union_tnModel viewController:controller];
         
         */
        [ICPayUtils _payWithModel:@{@"tn" : tn} controller:controller success:success failure:failure cancel:cancel];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)_payWithModel:(id)model
           controller:(UIViewController *)controller
              success:(nonnull ICPayBlock)success
              failure:(nonnull ICPayBlock)failure
               cancel:(nonnull ICPayBlock)cancel {
    [[ICPayDesignManager shareInstance] payWithModel:model controller:controller completion:^(ICError *error) {
        //成功
        if (error.status == ICErrorStatusCodeSuccess) {
            success(error.message);
            
        }else if (error.status == ICErrorStatusCodeUserCancel) {
            cancel(error.message);
            
        }else {
            failure(error.message);
        }
        
    }];
}


@end
