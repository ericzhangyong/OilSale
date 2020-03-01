//
//  PSAccountInfoModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"
@class PSAccountBillModel;

NS_ASSUME_NONNULL_BEGIN

@interface PSAccountInfoModel : BaseModel

/// 记账余额
@property (nonatomic,copy) NSString *account_balance;

/// 加油卡余额
@property (nonatomic,copy) NSString *fuel_card_balance;
/// 账单列表
@property (nonatomic,strong) NSArray<PSAccountBillModel *>*bill_list;
@end

@interface PSAccountBillModel : BaseModel

/// 扣款金额
@property (nonatomic,copy) NSString *amount;
/// 购买商品类型
@property (nonatomic,copy) NSString *bucket_type;
/// 购买数量
@property (nonatomic,copy) NSString *buy_num;
/// 扣款时间
@property (nonatomic,copy) NSString *pay_time;
/// 扣款类型
@property (nonatomic,copy) NSString *pay_type;

@end

NS_ASSUME_NONNULL_END
