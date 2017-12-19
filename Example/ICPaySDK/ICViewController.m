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
#import <AFNetworking.h>
@interface ICViewController ()

@end

@implementation ICViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
