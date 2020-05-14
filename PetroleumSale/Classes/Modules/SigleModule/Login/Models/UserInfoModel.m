//
//  WEUserInfoModel.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "UserInfoModel.h"
#import "BaseRequestHeader.h"

@implementation UserInfoModel



+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
        @"role_list":[UserRoleModel class]
    };
}

-(BOOL)isLogined{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:REUserTokenKey];
    BOOL isLogin = ![BaseVerifyUtils isNullOrSpaceStr:token];
    return isLogin;
}

-(void)setUser_role_id:(NSString *)user_role_id{
    _user_role_id = user_role_id;
    
    if ([user_role_id isEqualToString:@"3"]) {
        self.userType = UserTypeSender;
    }else if ([user_role_id isEqualToString:@"2"]){
        self.userType = UserTypeDriver;
    }else if ([user_role_id isEqualToString:@"4"]){
        self.userType = UserTypeSalesman;
    }
    else if ([user_role_id isEqualToString:@"5"]){
        self.userType = UserTypePetrolStation;
    }
    else if ([user_role_id isEqualToString:@"6"]){
        self.userType = UserTypeKeeper;
    }
    else{
        self.userType = UserTypeCustomer;
    }
  
}


@end

@implementation UserRoleModel



@end

@implementation UserCarInfoModel



@end
