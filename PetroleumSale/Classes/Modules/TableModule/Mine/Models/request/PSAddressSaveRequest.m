//
//  PSAddressSaveRequest.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/27.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSAddressSaveRequest.h"
#import "UserInfoProfile.h"

@implementation PSAddressSaveRequest

-(NSString *)requestMethod{
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypePetrolStation) {
        return method_addressStationSave;
    }
    return method_addressSave;
}

@end
