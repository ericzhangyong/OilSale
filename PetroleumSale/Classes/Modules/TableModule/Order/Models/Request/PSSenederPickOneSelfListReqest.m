//
//  PSSenederPickOneSelfListReqest.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/25.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSSenederPickOneSelfListReqest.h"
#import "UserInfoProfile.h"

@implementation PSSenederPickOneSelfListReqest

-(NSString *)requestMethod{
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeKeeper) {
        return method_storagePickOneSelf;
    }
    return method_senderPickOneSelf;
}
@end
