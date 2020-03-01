//
//  PSStationPhotoSaveRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSStationPhotoSaveRequest : BaseRequest

/// 车辆信息
@property (nonatomic,assign) NSInteger car_info_id;

/// 加油点地址id
@property (nonatomic,assign) NSInteger farp_addr_id;
/// 加油量
@property (nonatomic,copy) NSString *oil_volume_num;


@end

NS_ASSUME_NONNULL_END
