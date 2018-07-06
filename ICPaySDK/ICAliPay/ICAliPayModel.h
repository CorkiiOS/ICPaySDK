//
//  ICAliPayModel.h
//  AFNetworking
//
//  Created by iCorki. on 2018/1/20.
//

#import <Foundation/Foundation.h>
#import "ICIAliModel.h"
#import "ICBaseParamsModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ICAliPayModel : ICBaseParamsModel<ICIAliModel>

@property (nonatomic, strong) NSString *scheme;

@property (nonatomic, strong) NSString *orderString;

@end
NS_ASSUME_NONNULL_END
