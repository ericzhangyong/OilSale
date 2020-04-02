//
//  WEUserInfoModel.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/22.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseModel.h"
#import "PSAddresReceiveModel.h"
@class UserRoleModel;
@class UserCarInfoModel;

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,UserType){
    
    UserTypeCustomer = 1, //客户角色
    UserTypeDriver,   //司机角色
    UserTypeSender,    //派单角色
    UserTypePetrolStation,    //委托加油点
    UserTypeSalesman,    //销售员角色
    UserTypeKeeper  //仓库管理员

};
@interface UserInfoModel : BaseModel


/**
 用户头像
 */
@property (nonatomic,copy) NSString *headImg;

/// 用户姓名
@property (nonatomic,copy) NSString *user_name;

/// 用户手机号
@property (nonatomic,copy) NSString *user_phone;
/// 记录余额
@property (nonatomic,copy) NSString *balance;


/// 当前用户性别 1 为男 0为女 当前字段用于判断默认头像
@property (nonatomic,assign) NSInteger user_sex;

/// 用户token
@property (nonatomic,copy) NSString *access_token;

/// token 时效
@property (nonatomic,copy) NSString *exp;

/// 对客户角色有效，其他角色为空。用来标明客户是否上传营业执照，并且通过了后台验证。上传执照用户角色可下单，否则不可下单 (true 已上传, false未上传)
@property (nonatomic,assign) BOOL licensed;

/// 当前用户角色
@property (nonatomic,copy) NSString *user_role_id;

//车辆信息
@property (nonatomic,copy) UserCarInfoModel *car_info;

/// 用户类型
@property (nonatomic,assign) UserType userType;

#pragma mark- 用户信息---我的
/// 未还桶数量
@property (nonatomic,copy) NSString *not_returned_bucket_num;
/// 未读通知数量
@property (nonatomic,copy) NSString *notice_un_read_num;
/// 收货地址
@property (nonatomic,copy) PSAddresReceiveModel *receipt_addr;
/// 售后服务区热线
@property (nonatomic,copy) NSString *sales_service_hotline;
/// 是否上传审核图片
@property (nonatomic,assign) BOOL user_file_upload;
/// 若已经上传审核图片，则由当前接口返回
@property (nonatomic,copy) NSArray *verify_pic_url;
/// x销售员的邀请码
@property (nonatomic,copy) NSString *invite_code;



/*
[{
    "Id": 1,
    "State": 1,
    "UrRoleName": "客户"
}, {
    "Id": 2,
    "State": 1,
    "UrRoleName": "司机"
}],*/
@property (nonatomic,copy) NSArray<UserRoleModel *> *role_list;

/** 是否登录 */
@property (nonatomic,assign) BOOL isLogined;

/// 区域
@property (nonatomic,copy) NSString *region;

/// 详细地址
@property (nonatomic,copy) NSString *complete_address;


#pragma mark- 加油点

/// 储量值
@property (nonatomic,copy) NSString *reserves;
/// 储量值单位
@property (nonatomic,copy) NSString *reserves_unit;



@end

@interface UserRoleModel :BaseModel

@property (nonatomic,copy) NSString *Id;

/// 角色状态 1 为存在 0 为停用
@property (nonatomic,assign) NSInteger State;

/// 角色名称
@property (nonatomic,copy) NSString *UrRoleName;

@end

@interface UserCarInfoModel : BaseModel

/// 车辆信息id 修改业务携带当前id上来 修改业务当前业务传0
@property (nonatomic,assign) NSString *car_info_id;
/// 车辆l号码
@property (nonatomic,copy) NSString *car_number;
/// 司机名字
@property (nonatomic,copy) NSString *driver_name;

@end





NS_ASSUME_NONNULL_END
