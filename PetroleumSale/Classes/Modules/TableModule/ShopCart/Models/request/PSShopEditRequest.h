//
//  PSShopEditRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSShopEditRequest : BaseRequest


/// 支付方式 1 记账余额支付 2 加油卡支付 4 现金支付
@property (nonatomic,copy) NSString *pay_type;
/// 地址信息
@property (nonatomic,assign) NSInteger receipt_addr_id;

/// 提交的购物车序列号列表
@property (nonatomic,copy) NSArray *sub_car_id_list;

/// 操作类型 submit 提交购物车,reset 撤销购物车
@property (nonatomic,copy) NSString *sub_type;

/// 仓库地址id
@property (nonatomic,assign) NSInteger warehouse_id;



@end

NS_ASSUME_NONNULL_END
