# ICPaySDK

[![CI Status](http://img.shields.io/travis/corkiios/ICPaySDK.svg?style=flat)](https://travis-ci.org/corkiios/ICPaySDK)
[![Version](https://img.shields.io/cocoapods/v/ICPaySDK.svg?style=flat)](http://cocoapods.org/pods/ICPaySDK)
[![License](https://img.shields.io/cocoapods/l/ICPaySDK.svg?style=flat)](http://cocoapods.org/pods/ICPaySDK)
[![Platform](https://img.shields.io/cocoapods/p/ICPaySDK.svg?style=flat)](http://cocoapods.org/pods/ICPaySDK)

### 配置
* 使用Pod一键配置，也可以选择性的使用子模块
* 新版1.5.2适配了微信支付1.8.6 通用链接
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'ICPaySDK', '~> 1.5.2'

# pod 'ICPaySDK/ICWxPay'
# pod 'ICPaySDK/ICAliPay'
# pod 'ICPaySDK/UnionPay'

end

```

* 相对繁琐一些，需要配置支付厂家的SDK


### 初始化SDK
* 方式一：可采用在项目info.plist中添加`ICWxPayChannelKey`，对用的值为`微信支付的appkey`，如果没有微信支付可以任意填写，之后会自动初始化SDK
* 方式二:

```
[[ICPayDesignManager shareInstance] registerSDKWithDictionary:@{ICWxPayChannelKey : @"wechat key"}];

```

### 设置支付回调

```
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[ICPayDesignManager shareInstance] handleOpenURL:url sourceApplication:sourceApplication];

}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    return [[ICPayDesignManager shareInstance] handleOpenURL:url sourceApplication:nil];
}
```

### 实现支付

* 支付宝<ICIAliModel>(支付宝为例)

```
/*闭包方式*/
/*自定义数据模型 实现协议 <ICIAliModel>*/
AliModel *model = [[AliModel alloc] init];
model.orderString = orderString;
[[ICPayDesignManager shareInstance] payWithModel:model controller:nil completion:^(ICError *error) {
/*回调*/
}];

/*代理方式*/
[[ICPayDesignManager shareInstance] payWithModel:model controller:nil delegate:self];
/*回调*/
- (void)payManagerdidCompleteWithError:(ICError *)error {}

```

## Author

iCorki, 675053587@qq.com
发现问题或者bug 👏指正！

## License

ICPaySDK is available under the MIT license. See the LICENSE file for more info.
