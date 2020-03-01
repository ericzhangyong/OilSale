//
//  PSShopCartModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSShopCartModel : BaseModel

/// 桶描述
@property (nonatomic,copy) NSString *bucket_desc;
/// 图片地址
@property (nonatomic,copy) NSString *pic_url;
/// 吨桶装或铁通装
@property (nonatomic,copy) NSString *bucket_type;
/// 商品编号
@property (nonatomic,copy) NSString *shopping_car_id;
/// 单价 20/桶 20
@property (nonatomic,copy) NSString *unit_price;
/// 单价单位 20/桶 桶
@property (nonatomic,copy) NSString *unit_type;
/// 预计价格
@property (nonatomic,copy) NSString *expect_amount;
/// 购买数量
@property (nonatomic,copy) NSString *buy_num;


/// 是否被选中
@property (nonatomic,assign) BOOL isSelcted;

@end

NS_ASSUME_NONNULL_END
