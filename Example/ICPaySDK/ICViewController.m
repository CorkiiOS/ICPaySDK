//
//  ICViewController.m
//  ICPaySDK
//
//  Created by corkiios on 12/19/2017.
//  Copyright (c) 2017 corkiios. All rights reserved.
//

#import "ICViewController.h"
#import <ICPayDesignManager.h>
#import "AliModel.h"
#import "WxModel.h"
#import "UnionModel.h"
#import <AFNetworking.h>

#define kURL_TN_Normal   @"http://101.231.204.84:8091/sim/getacptn"


@interface ICViewController ()

@end

@implementation ICViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     <key>LSApplicationQueriesSchemes</key>
     <array>
     <string>alipay</string>
     <string>alipayshare</string>
     <string>uppaysdk</string>
     <string>uppaywallet</string>
     <string>uppayx1</string>
     <string>uppayx2</string>
     <string>uppayx3</string>
     <string>wechat</string>
     <string>weixin</string>
     </array>
     白名单

     URLType 自行配置
     
     本Demo 银联的可以正常使用  其他支付方式 需要自己的后台返回 支付所需要的参数
     创建对应的模型 遵守对应的协议 实现 一行代码完成支付
     
     
     */
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)requestPaySignCompletion:(void(^)(NSDictionary *wechat, NSString *orderString))completion {
    NSString *URLString = @"";
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    params[@"count"] = @(1);
    params[@"typeId"] = @(1);
    params[@"token"] = @"cf5dssss";
    [[AFHTTPSessionManager manager] POST:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable data) {
        if ([[data objectForKey:@"status"] integerValue] == 200) {
            
            NSDictionary *result = data[@"data"];;
            completion(result[@"weChatPay"],result[@"alipay"]);
            
        }else if ([[data objectForKey:@"status"] integerValue] == 500){
        }else {
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (IBAction)unionPay:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = serializer;
    
    [manager POST:kURL_TN_Normal parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData*  _Nullable data) {
        
        NSString *tn = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
        UnionModel *model = [UnionModel new];
        model.tn = tn;
        [[ICPayDesignManager shareInstance] payWithModel:model controller:self completion:^(ICError *error) {
            [[[UIAlertView alloc] initWithTitle:@"tips" message:error.message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
   
}

- (IBAction)ali:(id)sender {
    [self requestPaySignCompletion:^(NSDictionary *wechat, NSString *orderString) {
        AliModel *model = [[AliModel alloc] init];
        model.orderString = orderString;
        [[ICPayDesignManager shareInstance] payWithModel:model
                                              controller:nil
                                              completion:^(ICError *error) {
                                                  [[[UIAlertView alloc] initWithTitle:@"tips" message:error.message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];
                                              }];
    }];
   
}

- (IBAction)wechat:(id)sender {
    WxModel *model = [[WxModel alloc] init];
    
    [self requestPaySignCompletion:^(NSDictionary *wechat, NSString *orderString) {
        model.data = wechat;
        [[ICPayDesignManager shareInstance] payWithModel:model
                                              controller:nil
                                              completion:^(ICError *error) {
                                                  [[[UIAlertView alloc] initWithTitle:@"tips" message:error.message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];
                                              }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
