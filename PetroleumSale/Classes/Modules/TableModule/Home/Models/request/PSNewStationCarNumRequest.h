//
//  PSNewStationCarNumRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSNewStationCarNumRequest : BaseRequest


@property (nonatomic,copy) NSArray *car_num;

/// add 添加操作 delete 删除操作
@property (nonatomic,copy) NSString *operate_type;
@end

NS_ASSUME_NONNULL_END
