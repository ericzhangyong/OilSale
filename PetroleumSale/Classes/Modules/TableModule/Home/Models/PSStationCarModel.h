//
//  PSStationCarModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSStationCarModel : BaseModel

/// 车辆信息id
@property (nonatomic,copy) NSString *car_info_id;
/// 车辆车牌号
@property (nonatomic,copy) NSString *car_number;
/// 行驶证姓名信息
@property (nonatomic,copy) NSString *driver_name;

/// 是否被编辑选中
@property (nonatomic,assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
