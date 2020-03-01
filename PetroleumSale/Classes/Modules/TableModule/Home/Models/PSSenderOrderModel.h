//
//  PSSenderOrderModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"
#import "PSOrderModel.h"
@class PSOrderVerifyModel;

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderOrderModel : BaseModel


@property (nonatomic,copy) PSOrderModel *order_info;

@property (nonatomic,copy) PSOrderVerifyModel *wh_verify_info;
@property (nonatomic,copy) PSOrderVerifyModel *fin_verify_info;
@property (nonatomic,copy) PSOrderVerifyModel *boss_verify_info;

@end


@interface PSOrderVerifyModel : BaseModel

/// 审核时间
@property (nonatomic,copy) NSString *verify_time;

/// 审核人外键
@property (nonatomic,copy) NSString *verify_user_id;
/// 审核状态 0 审核中 1 审核通过 2 审核未通过
@property (nonatomic,assign) NSInteger wh_verify_state;

@end

NS_ASSUME_NONNULL_END
