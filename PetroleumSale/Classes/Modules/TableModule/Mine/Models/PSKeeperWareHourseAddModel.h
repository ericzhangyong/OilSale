//
//  PSKeeperWareHourseAddModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/25.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSKeeperWareHourseAddModel : BaseModel

/// sot_id
@property (nonatomic,assign) NSString *sot_id;
/// 详细地址
@property (nonatomic,copy) NSString *sto_addr;
/// 地址名称
@property (nonatomic,copy) NSString *sto_name;
/// 区域
@property (nonatomic,copy) NSString *sto_region;
@end

NS_ASSUME_NONNULL_END
