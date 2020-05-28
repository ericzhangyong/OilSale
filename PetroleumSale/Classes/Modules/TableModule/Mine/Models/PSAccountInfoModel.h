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

/// 下单时间
@property (nonatomic,copy) NSString *buy_time;
/// 送货司机姓名
@property (nonatomic,copy) NSString *driver_name;
/// 交货时间
@property (nonatomic,copy) NSString *operate_time;
/// 油单价
@property (nonatomic,copy) NSString *unit_price;
/// 欠铁桶个数
@property (nonatomic,copy) NSString *owe_bucket_number;
/// 欠吨桶个数
@property (nonatomic,copy) NSString *owe_ibc_number;
/// 欠加油机个数
@property (nonatomic,copy) NSString *owe_nozzle_number;
/// 是否需要加油枪
@property (nonatomic,copy) NSString *buy_nozzle;


/// 实际重量
@property (nonatomic,copy) NSString *real_Weight;
/// 实际升
@property (nonatomic,copy) NSString *real_volume;



@end

NS_ASSUME_NONNULL_END
