# ICPaySDK

[![CI Status](http://img.shields.io/travis/corkiios/ICPaySDK.svg?style=flat)](https://travis-ci.org/corkiios/ICPaySDK)
[![Version](https://img.shields.io/cocoapods/v/ICPaySDK.svg?style=flat)](http://cocoapods.org/pods/ICPaySDK)
[![License](https://img.shields.io/cocoapods/l/ICPaySDK.svg?style=flat)](http://cocoapods.org/pods/ICPaySDK)
[![Platform](https://img.shields.io/cocoapods/p/ICPaySDK.svg?style=flat)](http://cocoapods.org/pods/ICPaySDK)

## Example

* 手动配置环境或使用Pod
#import <ICPaySDK.h>
* 初始化SDK

```
[[ICPayDesignManager shareInstance] registerSDKWithDictionary:@{ICWxPayChannelKey : @"wx1cd2880e51ed36e9"} messageBlock:^(ICMessageModel *message) {
message.cancel = @"取消";
}];

```
* 设置支付回掉

```
- (BOOL)application:(UIApplication *)application
openURL:(NSURL *)url
sourceApplication:(NSString *)sourceApplication
annotation:(id)annotation
{
return  [[ICPayDesignManager shareInstance] handleOpenURL:url sourceApplication:sourceApplication completion:nil];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
return  [[ICPayDesignManager shareInstance] handleOpenURL:url completion:nil];
}

```
* 实现支付宝支付

```
//自定义数据模型 实现协议 <ICIAliModel>
AliModel *model = [[AliModel alloc] init];
model.orderString = orderString;
[[ICPayDesignManager shareInstance] payWithModel:model
controller:nil
completion:^(ICError *error) {
//回调
}];

```
* 实现微信支付

```
//自定义数据模型实现 <ICIWxModel>
//服务器获取签名数据之后解析到模型
WxModel *model = [[WxModel alloc] init];
model.data = wechat;
[[ICPayDesignManager shareInstance] payWithModel:model
controller:nil
completion:^(ICError *error) {

//回调
}];

```
* 银联支付

```
AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
manager.responseSerializer = serializer;

[manager POST:kURL_TN_Normal parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSData*  _Nullable data) {

NSString *tn = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
UnionModel *model = [UnionModel new];
model.tn = tn; //开发模式
[[ICPayDesignManager shareInstance] payWithModel:model controller:self completion:^(ICError *error) {
[[[UIAlertView alloc] initWithTitle:@"tips" message:error.message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil] show];
}];

} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

}];

```

* 使用子模块

* pod 'ICPaySDK/ICWxPay'
* pod 'ICPaySDK/ICAliPay'
* pod 'ICPaySDK/UnionPay'

## Requirements

* iOS 8.0

## Installation

ICPaySDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ICPaySDK'
```

## Author

iCorki, 675053587@qq.com
发现问题或者bug 👏指正！


## License

ICPaySDK is available under the MIT license. See the LICENSE file for more info.
