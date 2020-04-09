//
//  PSKeepHomeModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface PSKeeperStockModel : BaseModel

/// 编号
@property (nonatomic,copy) NSString *code;
/// 油的种类 柴油
@property (nonatomic,copy) NSString *oil_type;
/// 品相
@property (nonatomic,copy) NSString *product_phase;
/// 进货单号
@property (nonatomic,copy) NSString *stock_code;
/// 密度
@property (nonatomic,copy) NSString *stock_density;
/// 进货时间
@property (nonatomic,copy) NSString *stock_time;
/// 重量
@property (nonatomic,copy) NSString *stock_weight;

@end


NS_ASSUME_NONNULL_END
