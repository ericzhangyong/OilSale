//
//  PSDriverOrderListRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSDriverOrderListRequest : BaseRequest


@property (nonatomic,copy) NSString *waybill_time;

/// 运货单类型 1 当日运单 2 历史运单
@property (nonatomic,assign) NSInteger waybill_type;


@end

NS_ASSUME_NONNULL_END
