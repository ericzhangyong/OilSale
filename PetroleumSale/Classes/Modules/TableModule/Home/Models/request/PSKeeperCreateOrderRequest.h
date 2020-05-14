//
//  PSKeeperCreateOrderRequest.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/27.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSKeeperCreateOrderRequest : BaseRequest

/// 编号
@property (nonatomic,copy) NSString *code;
/// 油的种类 柴油
@property (nonatomic,copy) NSString *oil_type;
/// 进货单号
@property (nonatomic,copy) NSString *stock_code;
/// <#des#>
@property (nonatomic,copy) NSString *stock_density;
/// 重量
@property (nonatomic,copy) NSString *stock_weight;
@end

NS_ASSUME_NONNULL_END
