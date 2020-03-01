//
//  REBindingRequest.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/10/9.
//  Copyright © 2019 eric. All rights reserved.
//

#import "REBindingRequest.h"

@implementation REBindingRequest


-(NSSet *)getParametersInURISet{
    
    return [NSSet setWithArray:@[@"POST",@"GET"]];
}


-(NSString *)requestMethod{
    return @"123";
}


@end
