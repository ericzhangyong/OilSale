//
//  PSStationOrderModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/18.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"
#import "UserInfoModel.h"
#import "PSAddresReceiveModel.h"
@class PSStationOrderInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface PSStationOrderModel : BaseModel



@property (nonatomic,copy) UserCarInfoModel *farp_car_info;

@property (nonatomic,copy) PSAddresReceiveModel *req_farp_addr_edit_model;

@property (nonatomic,copy) PSStationOrderInfoModel *farp_order_info;


@end

@interface PSStationOrderInfoModel : BaseModel
/// 拍照图片回显地址列表
@property (nonatomic,copy) NSArray *oil_photo_do_pic_urls;
/// 拍照图片上传地址列表
@property (nonatomic,copy) NSArray *oil_photo_up_pic_urls;
/// 柴油图片地址
@property (nonatomic,copy) NSString *oil_pic_url;
/// 加油数量单位
@property (nonatomic,copy) NSString *oil_volume_num;
/// 订单号
@property (nonatomic,copy) NSString *order_code;
/// 订单id
@property (nonatomic,copy) NSString *order_id;
/// 订单时间
@property (nonatomic,copy) NSString *order_time;
@end

NS_ASSUME_NONNULL_END
