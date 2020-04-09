//
//  PSMessageListRequest.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/5.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMessageListRequest.h"
#import "UserInfoProfile.h"

@implementation PSMessageListRequest


-(NSString *)requestMethod{
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeDriver) {
        return method_messageDriverList;
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeSalesman){
        return method_salesmanMineMessage;
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeKeeper){
        return method_keeperMineMessageRead;
    }
    else{
        return method_messageList;
    }
}
@end
