//
//  FSAddressDeleteRequest.m
//  FireStore
//
//  Created by eric on 2019/9/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "FSAddressDeleteRequest.h"

@implementation FSAddressDeleteRequest


-(NSSet *)getParametersInURISet{

    return [NSSet setWithArray:@[@"POST",@"GET"]];
}
-(NSString *)requestHandler{
    
    return BaseConfigUrl.shareConfigUrl.webInstance;
}

- (NSString *)requestMethod{
    
    return @"dsafsafds";
}
@end
