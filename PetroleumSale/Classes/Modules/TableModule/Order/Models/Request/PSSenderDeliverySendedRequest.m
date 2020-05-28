//
//  PSSenderDeliverySendedRequest.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDeliverySendedRequest.h"
#import "UserInfoProfile.h"


@implementation PSSenderDeliverySendedRequest

-(NSString *)requestMethod{
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeKeeper) {
        return method_storageDeliverSendedList;
    }
    return method_senderDeliverSendedList;
}


@end
