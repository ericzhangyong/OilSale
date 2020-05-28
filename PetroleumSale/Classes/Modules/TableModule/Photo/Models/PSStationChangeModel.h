//
//  PSStationChangeModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/5/24.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"
#import "PSStationCarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSStationChangeModel : BaseModel

/// 加油量
@property (nonatomic,copy) NSString *oil_volume_num;

@property (nonatomic,strong) NSMutableArray *oil_photo_up_pic_urls;
@property (nonatomic,strong) NSMutableArray *oil_photo_do_pic_urls;
/// <#des#>
@property (nonatomic,copy) NSString *order_file_id;
/// <#des#>
@property (nonatomic,copy) NSString *order_id;
/// farp_car_info
@property (nonatomic,copy) PSStationCarModel *farp_car_info;

/// 是否被编辑选中
@property (nonatomic,assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
