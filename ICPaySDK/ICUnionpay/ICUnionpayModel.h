//
//  ICUnionpayModel.h
//  AFNetworking
//
//  Created by iCorki. on 2018/1/20.
//

#import <Foundation/Foundation.h>
#import "ICIUnionpayModel.h"
#import "ICBaseParamsModel.h"

@interface ICUnionpayModel : ICBaseParamsModel<ICIUnionpayModel>

@property (nonatomic, strong) NSString *scheme;

@property (nonatomic, strong) NSString *union_tn;

@property (nonatomic, strong) NSString *union_tnModel;


@end
