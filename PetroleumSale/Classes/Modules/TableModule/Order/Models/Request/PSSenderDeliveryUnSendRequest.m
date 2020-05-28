//
//  PSSenderDeliveryUnSendRequest.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDeliveryUnSendRequest.h"
#import "UserInfoProfile.h"
@implementation PSSenderDeliveryUnSendRequest


-(NSString *)requestMethod{
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeKeeper) {
        return method_storageDeliverUnSenderList;
    }
    return method_senderDeliverUnSenderList;
}
@end
