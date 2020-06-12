//
//  ICPaySDKServiceProtocol.h
//  AFNetworking
//
//  Created by 王志刚 on 2018/7/4.
//

#import <Foundation/Foundation.h>

@protocol ICPaySDKAutoServiceProtocol <NSObject>

/**
 微信支付的appkey
 */
- (NSString *)wechatKey;
/*支付宝支付的标识*/
- (NSString *)aliPrimarykey;
/*银联支付的标识*/
- (NSString *)uniPrimarykey;
/*微信支付的标识*/
- (NSString *)wxPrimaryKey;
/*Universal Links*/
- (NSString *)universalLinks;



/**
 scheme
 */
- (NSString *)scheme;

/*微信支付的参数所对应的key
*/
- (NSString *)partnerIdKey;
- (NSString *)prepayIdKey;
- (NSString *)nonceStrKey;
- (NSString *)timeStampKey;
- (NSString *)packageKey;
- (NSString *)signKey;

@end
