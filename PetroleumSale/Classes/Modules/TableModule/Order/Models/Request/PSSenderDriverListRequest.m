//
//  PSSenderDriverListRequest.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDriverListRequest.h"
#import "UserInfoProfile.h"

@implementation PSSenderDriverListRequest



-(NSString *)requestMethod{
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeSender) {
        return method_senderDriverList;
    }else{
        return @"storage/qry_dispatch_driver.do";
    }
}

@end
