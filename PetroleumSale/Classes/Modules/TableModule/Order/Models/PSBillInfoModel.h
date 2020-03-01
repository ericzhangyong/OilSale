//
//  PSBillInfoModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSBillInfoModel : BaseModel

/// 订单预计到达时间
@property (nonatomic,copy) NSString *WbEstimateTime;

/// 派单人外键
@property (nonatomic,copy) NSString *WbPicketUserId;
/// 签收人姓名
@property (nonatomic,copy) NSString *WbReceiverName;
/// 运单状态 1 创建 2 完成
@property (nonatomic,assign) NSInteger WbState;
/// 运单创建时间
@property (nonatomic,copy) NSString *WbPicketTime;
/// 订单到达时间
@property (nonatomic,copy) NSString *WbFinishTime;
/// 数据状态 1 启用 0 停用
@property (nonatomic,copy) NSString *State;
/// 运单编号
@property (nonatomic,copy) NSString *WbCode;
/// 运送司机外键
@property (nonatomic,copy) NSString *WbDriverUserId;
/// 派送状态
@property (nonatomic,copy) NSString *wb_state_desc;

/// 派单时间
@property (nonatomic,copy) NSString *WbDispatchTime;

/// 运单表主键
@property (nonatomic,copy) NSString *Id;
/// 订单表外键
@property (nonatomic,copy) NSString *WbOrderId;
@end

NS_ASSUME_NONNULL_END
