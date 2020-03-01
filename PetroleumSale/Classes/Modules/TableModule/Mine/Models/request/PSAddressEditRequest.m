//
//  PSAddressEditRequest.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSAddressEditRequest.h"
#import "UserInfoProfile.h"

@implementation PSAddressEditRequest



-(NSString *)requestMethod{
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypePetrolStation) {
        return method_addressStation;
    }else{
        return method_addressMessage;
    }
}
@end
