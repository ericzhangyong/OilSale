//
//  PSAccountHisModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/7/14.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSAccountHisModel : BaseModel

/// 充值时间
@property (nonatomic,copy) NSString *recharge_time;
/// 充值类型 1 为加油卡 2为账户余额
@property (nonatomic,copy) NSString *recharge_type;
/// 充值金额
@property (nonatomic,copy) NSString *recharge_money;
@end

NS_ASSUME_NONNULL_END
