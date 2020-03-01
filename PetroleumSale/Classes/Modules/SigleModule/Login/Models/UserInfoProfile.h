//
//  WEUserInfoProfile.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "BaseRequestHeader.h"

NS_ASSUME_NONNULL_BEGIN

//是否是委托角色
#define IsUSerStationType UserInfoProfile.shareUserInfo.userInfo.userType == UserTypePetrolStation


@interface UserInfoProfile : NSObject

+(instancetype)shareUserInfo; 


@property (nonatomic,strong) UserInfoModel *userInfo;


//更新信息
-(void)updataUserinfoWithDictInfo:(NSDictionary *)dictInfo;

/**
 更新数据
 */
-(void)updataUserInfoAndCache;

/**
 数据库中加载数据
 */
-(void)getLocalUserInfo;


/**
 用户退出登录
 */
-(void)loginOut;

-(void)clearAll;


/**
 开始统计
 */
-(void)startActiveCollect;

/**
 结束统计
 */
-(void)endActiveCollect;


/**
 请求用户基本信息

 @param complete 回调
 */
-(void)requestUserInfoWitnComplete:(void(^)(BOOL isFinish))complete;


/**
 用户活跃统计
 */
-(void)requestUserActive;

@end

NS_ASSUME_NONNULL_END
