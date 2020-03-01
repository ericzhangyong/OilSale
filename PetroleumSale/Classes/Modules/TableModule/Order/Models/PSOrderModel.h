//
//  PSOrderModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"
@class PSOrderImageModel;

NS_ASSUME_NONNULL_BEGIN

@interface PSOrderModel : BaseModel


/// 订单状态 1 已经下单 3 确认收货
@property (nonatomic,assign) NSInteger order_state;
/// 所在地区
@property (nonatomic,copy) NSString *rec_region;
/// 下单时间
@property (nonatomic,copy) NSString *shopping_time;
/// 下单的选择的仓库地址
@property (nonatomic,copy) NSString *warehouse_name;

/// 购买数量
@property (nonatomic,copy) NSString *buy_num;
/// 桶类型 吨桶或铁通等
@property (nonatomic,copy) NSString *bucket_type;
/// 桶类型 吨桶或铁通等
@property (nonatomic,copy) NSString *phone_num;
/// 下单的选择的仓库地址
@property (nonatomic,copy) NSString *warehouse_address;
/// 购物车图片地址
@property (nonatomic,copy) NSString *pic_url;
/// 详细信息
@property (nonatomic,copy) NSString *rec_complete_address;
///订单号
@property (nonatomic,copy) NSString *order_code;
///订单Id
@property (nonatomic,copy) NSString *order_id;
/// 预计价格
@property (nonatomic,copy) NSString *expect_amount;
/// 收货人
@property (nonatomic,copy) NSString *consignee;

@property (nonatomic,copy) NSArray<PSOrderImageModel *> *pic_list;


/// 桶下单 product_type='bucket' 车下单 product_type = 'car' 加油点下单 product_type='farp' 加油枪订单 product_type='gun'
@property (nonatomic,copy) NSString *product_type;

/// 含税 或 不含税 product_type='bucket' 下单为油桶时候，将当前字段显示到图片上
@property (nonatomic,copy) NSString *tax_include_state_desc;
/// 加油点地址 当订单类型 product_type='farp' 时，取当前字段
@property (nonatomic,copy) NSString *farp_address;
/// 自提 或 配送 product_type = 'car' 下单为车时候，将当前字段显示到图片上
@property (nonatomic,copy) NSString *distribution_state_desc;
/// 加油点加油车辆信息 当订单类型 product_type='farp' 时，取当前字段
@property (nonatomic,copy) NSArray *car_info;

@end

@interface PSOrderImageModel : BaseModel

/// 密度 例 0.8 g/ml
@property (nonatomic,copy) NSString *density;

/// 订单条目名称
@property (nonatomic,copy) NSString *order_item_name;

/// 图片地址列表
@property (nonatomic,copy) NSArray *pic_url;
/// 体积 例 500L
@property (nonatomic,copy) NSString *volume;
/// 重量 例 200kg
@property (nonatomic,copy) NSString *weight;
@end



NS_ASSUME_NONNULL_END
