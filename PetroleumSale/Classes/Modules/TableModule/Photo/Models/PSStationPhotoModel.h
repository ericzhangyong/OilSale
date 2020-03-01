//
//  PSStationPhotoModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"
#import "PSAddresReceiveModel.h"
#import "PSStationCarModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface PSStationPhotoModel : BaseModel

/// 地址信息
@property (nonatomic,copy) PSAddresReceiveModel *req_farp_addr_edit_model;
/// 加油量
@property (nonatomic,copy) NSString *oil_volume_num;

@property (nonatomic,strong) NSMutableArray *oil_photo_up_pic_urls;
@property (nonatomic,strong) NSMutableArray *oil_photo_do_pic_urls;
/// 加油车辆列表信息
@property (nonatomic,copy) NSArray<PSStationCarModel *> *farp_car_info;


@end




NS_ASSUME_NONNULL_END
