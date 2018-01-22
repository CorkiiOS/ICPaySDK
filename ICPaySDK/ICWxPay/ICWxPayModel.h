//
//  ICWxPayModel.h
//  AFNetworking
//
//  Created by 王志刚 on 2018/1/20.
//

#import <Foundation/Foundation.h>
#import "ICIWxModel.h"

@interface ICWxPayModel : NSObject<ICIWxModel>

@property (nonatomic) NSString *partnerId;
@property (nonatomic) NSString *prepayId;
@property (nonatomic) NSString *nonceStr;
@property (nonatomic) UInt32 timeStamp;
@property (nonatomic) NSString *package;
@property (nonatomic) NSString *sign;

- (void)setData:(id)data
      keyMapper:(NSDictionary *)keyMapper;
@end
