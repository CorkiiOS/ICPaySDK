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
[[ICPayDesignManager shareInstance] registerSDKWithDictionary:@{ICWxPayChannelKey : @"微信支付需要的appid"} messageBlock:^(ICMessageModel *message) {
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

## 新增自动解析参数模块
* 自定义配置

```
/**
对后台参数自动解析的配置

@param scheme 第三方支付APP返回商家APP所需要scheme 支付宝／银联  微信的为APPID
@param identifierMap 唯一的标识符集合
例如 @{ICWxPayChannelKey : @"weChat" ,
ICALiPayChannelKey : @"alipay",
ICUnionPayChannelKey : @"tn"}

SDK内部通过 weChat 字段判断为使用微信支付
SDK内部通过 alipay 字段判断为使用支付宝支付
SDK内部通过 tn     字段判断为使用银联支付
用户可自定义字段名称

@param replaceKeyMap 主要针对微信支付

替换默认的key 例如 将 partnerId 替换为 pID @{@"partnerId" : @"pID"}等
*/
- (void)loadAutoParserConfigWithScheme:(NSString *)scheme
identifierMap:(NSDictionary *)identifierMap
replaceKeyMap:(NSDictionary *)replaceKeyMap;
```
* 微信参数对照表

默认key  | 含义
------|----
partnerId  | 商家向财付通申请的商家id
prepayId  | 预支付订单
noncestr  | 随机串，防重发
timestamp  | 时间戳，防重发
package  | 商家根据财付通文档填写的数据和签名
sign  | 商家根据微信开放平台文档对数据做的签名


* 配置方式

```
- (void)loadAutoParserConfigWithScheme:(NSString *)scheme
identifierMap:(NSDictionary *)identifierMap
replaceKeyMap:(NSDictionary *)replaceKeyMap;

通过 replaceKeyMap 可以设置对应的key
例如 @{@"partnerId" : @"partner_id"}
将默认的partnerId  替换成partner_id
根据自己服务器的情况配置
```


* 支付宝参数对照表

默认key  | 含义
------|----
identifierMap中ICALiPayChannelKey对应的标示  | 签名
scheme  | 返回商户APP scheme，通过SDK配置

* 银联参数对照表

默认key  | 含义
------|----
identifierMap中ICUnionPayChannelKey对应的标示  | 支付凭证
---|接入模式，内部指定DEBUG模式为@"01",Release模式@"00'
scheme  | 返回商户APP scheme，通过SDK配置


* 支持的格式

```
例如在 初始化的时候采用如下配置

replaceKeyMap:nil 微信支付采用默认的key

[[ICPayDesignManager shareInstance] loadAutoParserConfigWithScheme:@"AliPayURLScheme.ic"
identifierMap:@{ICWxPayChannelKey : @"weChatPay",
ICALiPayChannelKey : @"alipay",
ICUnionPayChannelKey : @"tn"}
replaceKeyMap:nil];

微信

{
"weChatPay" : {"partnerId" : "", "prepayId" : "", "noncestr" : ""}
}


支付宝

{"alipay" : "支付凭证"}

银联
{"tn" : "支付凭证"}


注意：必须为以上格式 json／NSDictionary 均可

[[ICPayDesignManager shareInstance] payWithModel:@{@"alipay" : @"订单签名／支付凭证"} controller:controller completion:^(ICError *error) {
if (error.status == ICErrorStatusCodeSuccess) {
//成功
}else if (error.status == ICErrorStatusCodeUserCancel) {
//取消
}else {
//失败
}

}];

```




## Requirements

* iOS 8.0

## Installation

ICPaySDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
# 1.3.0之前的版本微信回调有问题，1.3.1已修复

target 'TargetName' do
pod 'ICPaySDK', '~> 1.4.0'

end

```

## Author

iCorki, 675053587@qq.com
发现问题或者bug 👏指正！


## License

ICPaySDK is available under the MIT license. See the LICENSE file for more info.
