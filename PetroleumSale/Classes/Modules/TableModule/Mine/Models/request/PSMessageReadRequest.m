//
//  PSMessageReadRequest.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMessageReadRequest.h"
#import "UserInfoProfile.h"

@implementation PSMessageReadRequest


-(NSString *)requestMethod{
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeDriver) {
        return method_messageDriverSetRead;
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeSalesman){
        return method_salesmanMineMessageRead;
    }
    else{
        return method_messageSetRead;
    }
}
@end
