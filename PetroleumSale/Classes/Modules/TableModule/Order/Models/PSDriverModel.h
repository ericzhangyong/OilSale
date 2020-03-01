//
//  PSDriverModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"
#import "PSBillInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSDriverModel : BaseModel
/// 车牌号
@property (nonatomic,copy) NSString *car_num;
/// 司机主键
@property (nonatomic,copy) NSString *driver_id;
/// 司机名称
@property (nonatomic,copy) NSString *driver_name;
/// 已运送订单列表
@property (nonatomic,copy) NSArray<PSBillInfoModel *> *waybill_num;

//是否被选中派单
@property (nonatomic,assign) BOOL isSelcted;


@end

NS_ASSUME_NONNULL_END
