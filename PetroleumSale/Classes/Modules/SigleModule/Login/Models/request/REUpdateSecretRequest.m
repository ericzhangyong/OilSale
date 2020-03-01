//
//  REUpdateSecretRequest.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/10/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import "REUpdateSecretRequest.h"

@implementation REUpdateSecretRequest



+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"password":@"newPwd"};
}

-(NSSet *)getParametersInURISet{
    return [NSSet setWithArray:@[@"POST",@"GET"]];
}
-(NSString *)requestMethod{
    
    return @"dfsafdsa";
}
@end
