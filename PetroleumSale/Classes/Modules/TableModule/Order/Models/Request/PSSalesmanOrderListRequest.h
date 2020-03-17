//
//  PSSalesmanOrderListRequest.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSalesmanOrderListRequest : BaseRequest


/// 操作时间 用于分页，每次上滑取列表最后一条上的订单时间回传,首次可为空
@property (nonatomic,copy) NSString *operate_time;

/// 订单类型 0 未下单 1 已下单 2 已完成 3 已取消
@property (nonatomic,copy) NSString *order_type;

@end

NS_ASSUME_NONNULL_END
