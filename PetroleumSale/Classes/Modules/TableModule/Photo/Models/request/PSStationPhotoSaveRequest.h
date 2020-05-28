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

/// 委托加油订单下的详单id
@property (nonatomic,assign) NSInteger order_file_id;

/// 委托加油订单id
@property (nonatomic,assign) NSInteger order_id;
/// 加油量
@property (nonatomic,copy) NSString *oil_volume;


@end

NS_ASSUME_NONNULL_END
