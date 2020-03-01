//
//  PSReserveConfirmRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSReserveConfirmRequest : BaseRequest



@property (nonatomic,copy) NSArray *car_info_id;

/// 委托加油点id
@property (nonatomic,assign) NSInteger farp_id;
@end

NS_ASSUME_NONNULL_END
