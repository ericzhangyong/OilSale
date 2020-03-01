//
//  PSSenderDeliveryModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"
#import "PSOrderModel.h"
#import "PSBillInfoModel.h"
@class PSDriverInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderDeliveryModel : BaseModel



@property (nonatomic,copy) PSOrderModel *order_info;

@property (nonatomic,copy) PSDriverInfoModel *driver_info;
@property (nonatomic,copy) PSBillInfoModel *waybill_info;

/// 单价
@property (nonatomic,copy) NSString *unit_price;

/// 是否被选中
@property (nonatomic,assign) BOOL isSelected;

@end

@interface PSDriverInfoModel : BaseModel

@property (nonatomic,copy) NSString *Id;

@property (nonatomic,assign) NSInteger *State;
/// 用户姓名（别名）
@property (nonatomic,copy) NSString *UiName;
/// 用户手机号
@property (nonatomic,copy) NSString *UiPhone;
/// 手机号类型 1 主账号 0 子账号
@property (nonatomic,copy) NSString *UiPhoneType;
/// 用户密码
@property (nonatomic,copy) NSString *UiPwd;
/// 性别 1 男 0 女
@property (nonatomic,copy) NSString *UiSex;
//// 关联用户外键
@property (nonatomic,copy) NSString *UiUserAccountId;
@end


NS_ASSUME_NONNULL_END
