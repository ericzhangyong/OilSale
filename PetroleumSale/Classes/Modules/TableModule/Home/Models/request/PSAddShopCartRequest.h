//
//  PSAddShopCartRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSAddShopCartRequest : BaseRequest


///  桶类型id,
@property (nonatomic,assign) NSInteger bucket_type_id;

/// BuyNum: 购买数量
@property (nonatomic,assign) NSInteger buy_num;

/// 1 为自提 0 为配送 下单为车时候，上传当前字段
@property (nonatomic,assign) NSInteger distribution_state;
/// 1 桶下单 product_type='bucket' (tax_include_state不为空) 车下单 product_type = 'car'（distribution_state 部位空）
@property (nonatomic,copy) NSString *product_type;

/// 1 为含税 0 为不含税 下单为油桶时候，上传当前字段
@property (nonatomic,assign) NSInteger tax_include_state;
@end

NS_ASSUME_NONNULL_END
