//
//  REGetUserInfoRequest.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/19.
//  Copyright © 2019 eric. All rights reserved.
//

#import "REGetUserInfoRequest.h"
#import "UserInfoProfile.h"

@implementation REGetUserInfoRequest


-(NSString *)requestMethod{
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeDriver) {
        return @"driver/qry_driver_mine.do";
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypePetrolStation){
        return method_stationMine;
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeSalesman){
        return method_salesmanMine;
    }else if(UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeKeeper){
        return method_keeperMine;
    }
    else{
        return method_userInfo;
    }
}
@end
