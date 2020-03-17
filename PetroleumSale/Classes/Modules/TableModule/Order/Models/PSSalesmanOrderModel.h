//
//  PSSalesmanOrderModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSalesmanOrderModel : BaseModel


/// 合同地址 h5 展示
@property (nonatomic,copy) NSString *agreement_url;
/// 销售奖金
@property (nonatomic,copy) NSString *bonus;
/// 客户姓名
@property (nonatomic,copy) NSString *client_name;
/// 操作时间 用于分页，每次上滑取列表最后一条上的订单时间回传
@property (nonatomic,copy) NSString *operate_time;
/// 订单取消原因
@property (nonatomic,copy) NSString *order_cancel_reason;
/// 订单状态描述
@property (nonatomic,copy) NSString *order_state_desc;
@end

NS_ASSUME_NONNULL_END
