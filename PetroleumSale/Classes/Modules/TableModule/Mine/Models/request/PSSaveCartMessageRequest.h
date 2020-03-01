//
//  PSSaveCartMessageRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/14.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSaveCartMessageRequest : BaseRequest

/// 车辆信息id 修改业务携带当前id上来 修改业务当前业务传0
@property (nonatomic,assign) NSInteger car_info_id;
/// 车辆l号码
@property (nonatomic,copy) NSString *car_number;
/// 司机名字
@property (nonatomic,copy) NSString *driver_name;
@end

NS_ASSUME_NONNULL_END
