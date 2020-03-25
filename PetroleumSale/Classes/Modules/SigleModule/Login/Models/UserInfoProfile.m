//
//  WEUserInfoProfile.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "UserInfoProfile.h"
#import "BaseRequestHeader.h"
#import "REGetUserInfoRequest.h"
#import "BaseWeakTimer.h"

#define userInfoCacheKey @"userInfoCacheKey"

@interface UserInfoProfile()

/**  */
//@property (nonatomic,weak) NSTimer *timer;
{
    NSTimer *_timer;
}
@end
@implementation UserInfoProfile

+(instancetype)shareUserInfo{
    static UserInfoProfile *userProfiles = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userProfiles = [UserInfoProfile new];
    });
    return userProfiles;
}


-(instancetype)init{
    if (self = [super init]) {
        [self getLocalUserInfo];
    }
    return self;
}


-(void)updataUserInfoAndCache{
    
    //保存用户信息到数据库
    if (self.userInfo) {
        
        NSDictionary *userInfoDict = [self.userInfo modelToJsonDictionary];
        [[NSUserDefaults standardUserDefaults] setObject:userInfoDict forKey:userInfoCacheKey];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@{} forKey:userInfoCacheKey];
    }
}

-(void)updataUserinfoWithDictInfo:(NSDictionary *)dictInfo{
    UserInfoModel *userModel =[UserInfoModel convertModelWithJsonDic:dictInfo];
    
    self.userInfo = userModel;
    NSString *token = userModel.access_token;//[[NSUserDefaults standardUserDefaults] objectForKey:REUserTokenKey];
    [BaseRequestHeader.shareRequestHeader updateLoginToken:token];
    [self updataUserInfoAndCache];
}

-(void)getLocalUserInfo{
    
    NSDictionary *userInfoDict = [[NSUserDefaults standardUserDefaults] objectForKey:userInfoCacheKey];
    if (userInfoDict.count==0) {
        return;
    }
    self.userInfo = [UserInfoModel convertModelWithJsonDic:userInfoDict];
}

/**
 用户退出登录
 */
-(void)loginOut{
    //退出通知
    [self clearAll];
//    [[NSNotificationCenter defaultCenter] postNotificationName:WEUserLoginOutSuccessKey object:nil];
    
}

-(void)clearAll{
    
    //清除数据库
    _userInfo = nil;
//    [[WEKeyValueStore shareStore] we_deleteObjectById:userInfoCacheKey];
//    //清除数据库
//    [[WEKeyValueStore shareStore] we_clearTable];
    //删除token
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:REUserTokenKey];
    [BaseRequestHeader.shareRequestHeader deleteLoginToken];
    [self updataUserInfoAndCache];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:REUserTokenKey];
    [BaseRequestHeader.shareRequestHeader updateLoginToken:token];
}


/**
 开始统计
 */
-(void)startActiveCollect{
    
    _timer  = [BaseWeakTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(requestUserActive) userInfo:nil repeats:YES];
}

/**
 结束统计
 */
-(void)endActiveCollect{
    
    [_timer invalidate];
    _timer = nil;
}



/**
 请求用户基本信息
 
 @param complete 回调
 */
-(void)requestUserInfoWitnComplete:(void(^)(BOOL isFinish))complete{
    
    WEAK_SELF;
    REGetUserInfoRequest *userInforequest = [REGetUserInfoRequest new];
    [userInforequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response.isFinished) {
            
                if (weakSelf.userInfo == nil) {
                    weakSelf.userInfo = [UserInfoModel new];
                }
                
                NSDictionary *dict = response.result;
                NSString *not_returned_bucket_num = dict[@"not_returned_bucket_num"];
                NSNumber *notice_un_read_num = dict[@"notice_un_read_num"];
                NSDictionary *addrDict = dict[@"receipt_addr"];
                if (addrDict == nil) {
                    addrDict = dict[@"farp_addr"];
                }
                //地址相关
                PSAddresReceiveModel *receipt_addr = [PSAddresReceiveModel convertModelWithJsonDic:addrDict];
                NSString *sales_service_hotline = dict[@"sales_service_hotline"];
                NSNumber *user_file_upload = dict[@"user_file_upload"];
                NSDictionary *user_info = dict[@"user_info"];
                NSArray *verify_pic_url = dict[@"verify_pic_url"];
                NSString *balance = dict[@"balance"];
                NSString *invite_code = dict[@"invite_code"];
                
                //加油点储量
                NSDictionary *reservesDict = dict[@"farp_reserves"];
                if (reservesDict) {
                    weakSelf.userInfo.reserves = reservesDict[@"reserves"];
                    weakSelf.userInfo.reserves_unit = reservesDict[@"reserves_unit"];
                }
                weakSelf.userInfo.invite_code = invite_code;
                weakSelf.userInfo.not_returned_bucket_num = not_returned_bucket_num;
                weakSelf.userInfo.notice_un_read_num = notice_un_read_num.stringValue;
                weakSelf.userInfo.receipt_addr = receipt_addr;
                weakSelf.userInfo.sales_service_hotline = sales_service_hotline;
                weakSelf.userInfo.user_file_upload = user_file_upload.boolValue;
                weakSelf.userInfo.user_phone = user_info[@"phone_num"];
                NSNumber *user_sex =  user_info[@"sex"];
                weakSelf.userInfo.user_sex = user_sex.integerValue;
                weakSelf.userInfo.user_name = user_info[@"user_name"];
                weakSelf.userInfo.verify_pic_url = verify_pic_url;
                weakSelf.userInfo.balance = balance;
                
                //车辆信息
                NSDictionary *carInfoDict = dict[@"car_info"];
                UserCarInfoModel *carInfo = [UserCarInfoModel convertModelWithJsonDic:carInfoDict];
                self.userInfo.car_info = carInfo;
                [self updataUserInfoAndCache];
                
                complete(YES);
            }else{
                complete(NO);
            }
        });
    }];
}



-(void)requestUserActive{
    
    
}

@end
