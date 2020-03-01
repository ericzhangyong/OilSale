//
//  PSDeliveryModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"
#import "PSHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSDeliveryModel : BaseModel

/// 收货人
@property (nonatomic,copy) NSString *consignee;

/// 手机号码
@property (nonatomic,copy) NSString *phone_num;

/// 区域
@property (nonatomic,copy) NSString *region;

/// 详细地址
@property (nonatomic,copy) NSString *complete_address;

/// 运单编号
@property (nonatomic,copy) NSString *way_bill_code;
/// 运单id
@property (nonatomic,copy) NSString *waybill_id;
/// 下单时间
@property (nonatomic,copy) NSString *order_time;
/// 购买数量
@property (nonatomic,copy) NSString *bucket_num;

@property (nonatomic,copy) NSString *bucket_pic_url;

/// 商品信息
@property (nonatomic,copy) PSProductModel *product_info;

//buckettype
@property (nonatomic,copy) NSString *commodity_name;


@property (nonatomic,copy) NSString *nozzle_num;
@property (nonatomic,copy) NSString *nozzle_order_id;


@end

NS_ASSUME_NONNULL_END
