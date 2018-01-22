//
//  ICUnionpayModel.h
//  AFNetworking
//
//  Created by iCorki. on 2018/1/20.
//

#import <Foundation/Foundation.h>
#import "ICIUnionpayModel.h"

@interface ICUnionpayModel : NSObject<ICIUnionpayModel>

@property (nonatomic, strong) NSString *scheme;

@property (nonatomic, strong) NSString *union_tn;

@property (nonatomic, strong) NSString *union_tnModel;

- (void)setTn:(NSString *)tn scheme:(NSString *)scheme;

@end
