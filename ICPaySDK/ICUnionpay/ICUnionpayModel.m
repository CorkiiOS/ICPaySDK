//
//  ICUnionpayModel.m
//  AFNetworking
//
//  Created by iCorki. on 2018/1/20.
//

#import "ICUnionpayModel.h"

@implementation ICUnionpayModel

- (NSString *)union_tn {
    return _union_tn;
}

- (NSString *)union_tnModel {
#ifdef DEBUG
    return @"01";
#else
    
#endif
    return @"00";
}

- (NSString *)scheme {
    return _scheme;
}

- (void)setTn:(NSString *)tn scheme:(NSString *)scheme {
    self.union_tn = tn;
    self.scheme = scheme;
}

- (void)setData:(NSDictionary *)data service:(id<ICPaySDKAutoServiceProtocol>)service {
    self.scheme = service.scheme;
    self.union_tn = data[service.uniPrimarykey];
}

@end
