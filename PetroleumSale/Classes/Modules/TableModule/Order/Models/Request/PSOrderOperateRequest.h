//
//  PSOrderOperateRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/7.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSOrderOperateRequest : BaseRequest

/// 操作类型可选值 confirm 表示确认收货 cancel表示取消订单
@property (nonatomic,copy) NSString *operate_type;

/// 订单编号
@property (nonatomic,copy) NSString *order_code;

/// 订单id
@property (nonatomic,assign) NSInteger order_id;
@end

NS_ASSUME_NONNULL_END
