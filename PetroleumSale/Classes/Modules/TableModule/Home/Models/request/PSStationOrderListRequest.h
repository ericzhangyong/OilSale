//
//  PSStationOrderListRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/18.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSStationOrderListRequest : BaseRequest

/// 下单时间，当前字段用于条件查询, 默认可为空，下拉后把列表最后的时间带回来作为分页条件
@property (nonatomic,copy) NSString *order_time;

/// 订单类型错误 1 当前订单（已经下单，未确认收货） 3 历史订单(已完成送货和确认)
@property (nonatomic,assign) int order_type;

@end

NS_ASSUME_NONNULL_END
