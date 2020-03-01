//
//  FSAppVersionRequest.m
//  FireStore
//
//  Created by eric on 2019/9/9.
//  Copyright © 2019 eric. All rights reserved.
//

#import "FSAppVersionRequest.h"

@implementation FSAppVersionRequest


-(NSString *)requestHandler{
    
    return [NSString stringWithFormat:@"%@%@",BaseConfigUrl.shareConfigUrl.webInstance,@"mall/vest/"];
}

-(NSString *)requestMethod{
    return @"vestManage";
}
@end
