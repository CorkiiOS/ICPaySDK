//
//  ICAliPayModel.h
//  AFNetworking
//
//  Created by 王志刚 on 2018/1/20.
//

#import <Foundation/Foundation.h>
#import "ICIAliModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ICAliPayModel : NSObject<ICIAliModel>

@property (nonatomic, strong) NSString *scheme;

@property (nonatomic, strong) NSString *orderString;

- (void)setOrderString:(NSString *)orderString scheme:(NSString *)scheme;

@end
NS_ASSUME_NONNULL_END
