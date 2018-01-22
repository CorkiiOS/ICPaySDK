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
     
     注意：  本Demo 银联的可以正常使用  其他支付方式 需要自己的后台返回 支付所需要的参数
            创建对应的模型 遵守对应的协议 实现 一行代码完成支付
     
            后面抽出时间实现本地签名支付！！！！
     
            感谢支持
            欢迎star!!
     
            https://github.com/CorkiiOS/ICPaySDK.git
     
     * 银联测试账号
      招商银行借记卡：6226090000000048     手机号：18100000000     密码：111101     短信验证码：123456（先点获取验证码之后再输入）     证件类型：01身份证     证件号：510265790128303     姓名：张三
     
     华夏银行贷记卡：6226388000000095     手机号：18100000000     CVN2：248     有效期：1219     短信验证码：123456（先点获取验证码之后再输入）     证件类型：01身份证     证件号：510265790128303     姓名：张三
     
     */
	// Do any additional setup after loading the view, typically from a nib.
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
