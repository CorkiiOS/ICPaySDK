//
//  AliModel.h
//  ICPayPlusDesign
//
//  Created by mac on 2017/7/23.
//  Copyright © 2017年 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ICIAliModel.h>
@interface AliModel : NSObject<ICIAliModel>
@property (nonatomic) NSString *orderString;
@property (nonatomic) NSString *scheme;
@end
