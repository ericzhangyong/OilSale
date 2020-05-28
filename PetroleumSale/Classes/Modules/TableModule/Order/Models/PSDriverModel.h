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

#pragma mark-仓库信息
/// 仓库管理员姓名
@property (nonatomic,copy) NSString *storekeeper_name;
/// 仓库管理员id
@property (nonatomic,copy) NSString *storekeeper_id;
/// 仓库地址
@property (nonatomic,copy) NSString *warehouse_address;
/// 仓库名称
@property (nonatomic,copy) NSString *warehouse_name;

//是否被选中派单
@property (nonatomic,assign) BOOL isSelcted;


@end

NS_ASSUME_NONNULL_END
