//
//  PSStationModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSStationModel : BaseModel

/// 委托加油点名称
@property (nonatomic,copy) NSString *farp_name;
/// 委托加油点订单
@property (nonatomic,copy) NSString *farp_id;
/// 委托加油点地址
@property (nonatomic,copy) NSString *farp_address;
/// 加油点封面图片地址
@property (nonatomic,copy) NSString *farp_pic;

/// 是否被选中
@property (nonatomic,assign) BOOL isSelected;


@end

NS_ASSUME_NONNULL_END
