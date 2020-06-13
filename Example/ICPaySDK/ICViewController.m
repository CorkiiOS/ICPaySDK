//
//  ICViewController.m
//  ICPaySDK
//
//  Created by corkiios on 12/19/2017.
//  Copyright (c) 2017 corkiios. All rights reserved.
//

#import "ICViewController.h"

#define kURL_TN_Normal   @"http://101.231.204.84:8091/sim/getacptn"

#import "ICPayUtils.h"

@interface ICViewController ()

@end

@implementation ICViewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // demo 后续抽空完善----------------------------------
}

- (IBAction)unionPay:(id)sender {
    
    [ICPayUtils unionPayWithURL:kURL_TN_Normal params:nil controller:self success:^(NSString * _Nullable message) {
        [[[UIAlertView alloc] initWithTitle:@"tips" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];

    } failure:^(NSString * _Nullable message) {
        [[[UIAlertView alloc] initWithTitle:@"tips" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];

    } cancel:^(NSString * _Nullable message) {
        [[[UIAlertView alloc] initWithTitle:@"tips" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];

    }];
}

- (IBAction)ali:(id)sender {
#warning 需要自己完善
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [ICPayUtils aliPayWithURL:@"" params:params success:^(NSString * _Nullable message) {
         [[[UIAlertView alloc] initWithTitle:@"tips" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];
    } failure:^(NSString * _Nullable message) {
         [[[UIAlertView alloc] initWithTitle:@"tips" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];
    } cancel:^(NSString * _Nullable message) {
         [[[UIAlertView alloc] initWithTitle:@"tips" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];
    }];
}

- (IBAction)wechat:(id)sender {

#warning 需要自己完善
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [ICPayUtils wxPayWithURL:@"" params:params success:^(NSString * _Nullable message) {
        [[[UIAlertView alloc] initWithTitle:@"tips" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];

    } failure:^(NSString * _Nullable message) {
        [[[UIAlertView alloc] initWithTitle:@"tips" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];

    } cancel:^(NSString * _Nullable message) {
        [[[UIAlertView alloc] initWithTitle:@"tips" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];

    }];
}


- (void)test {
    NSLog(@"%s", __FUNCTION__);
}

@end
