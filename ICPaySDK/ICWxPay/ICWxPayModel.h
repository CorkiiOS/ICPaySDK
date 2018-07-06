//
//  ICWxPayModel.h
//  AFNetworking
//
//  Created by iCorki. on 2018/1/20.
//

#import <Foundation/Foundation.h>
#import "ICIWxModel.h"
#import "ICBaseParamsModel.h"
@interface ICWxPayModel : ICBaseParamsModel<ICIWxModel>

@property (nonatomic) NSString *partnerId;
@property (nonatomic) NSString *prepayId;
@property (nonatomic) NSString *nonceStr;
@property (nonatomic) UInt32 timeStamp;
@property (nonatomic) NSString *package;
@property (nonatomic) NSString *sign;

@end
