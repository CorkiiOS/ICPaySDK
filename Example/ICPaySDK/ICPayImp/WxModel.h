//
//  WxModel.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ICIWxModel.h>
@interface WxModel : NSObject<ICIWxModel>

@property (nonatomic) NSString *partnerId;
@property (nonatomic) NSString *prepayId;
@property (nonatomic) NSString *nonceStr;
@property (nonatomic) UInt32 timeStamp;
@property (nonatomic) NSString *package;
@property (nonatomic) NSString *sign;

@property (nonatomic, strong) NSDictionary *data;

- (void)setData:(NSDictionary *)data;
@end
