# 说明
* 暂时支持支付宝/微信支付，如果需要其他支付方式可以【自定义支付对象】

# ICPaySDK

[![CI Status](http://img.shields.io/travis/corkiios/ICPaySDK.svg?style=flat)](https://travis-ci.org/corkiios/ICPaySDK)
[![Version](https://img.shields.io/cocoapods/v/ICPaySDK.svg?style=flat)](http://cocoapods.org/pods/ICPaySDK)
[![License](https://img.shields.io/cocoapods/l/ICPaySDK.svg?style=flat)](http://cocoapods.org/pods/ICPaySDK)
[![Platform](https://img.shields.io/cocoapods/p/ICPaySDK.svg?style=flat)](http://cocoapods.org/pods/ICPaySDK)

### 配置
* 最新版本为 2.1.0
* 使用Pod一键配置，也可以选择性的使用子模块
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'ICPaySDK'

# pod 'ICPaySDK/ICWxPay'
# pod 'ICPaySDK/ICAliPay'

end

```


### 初始化SDK

```
// 使用微信支付需要
[[ICPayDesignManager shareInstance] registerWx:@"" universalLinks:@""];

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

// 微信支付通用链接
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [[ICPayDesignManager shareInstance] handleOpenUniversalLink:userActivity];
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

### 自定义支付对象

```
1. 新建类 继承ICBasePayEntry，实现父类方法， 可以参考 ICAliPayEntry/ICWxPayEntry


 支付统一规范
 */

- (void)payWithModel:(id)model
          controller:(nullable UIViewController *)controller
          completion:(nullable ICCompletion)completion;
/**
 处理支付
 */
- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(nullable NSString *)sourceApplication;

/**
 处理通用链接
 */
- (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity;

2. 添加 支付对象
[[ICPayDesignManager shareInstance] addPayEntry:@"自定义的entry"];

3. 发起支付
[[ICPayDesignManager shareInstance] payWithEntryClass:<#(nonnull Class)#> data:<#(nonnull id)#> controller:<#(nonnull UIViewController *)#> completion:<#^(ICErrorStatusCode)completion#>]

```

## Author

iCorki, 675053587@qq.com
发现问题或者bug 👏指正！

## License

ICPaySDK is available under the MIT license. See the LICENSE file for more info.
