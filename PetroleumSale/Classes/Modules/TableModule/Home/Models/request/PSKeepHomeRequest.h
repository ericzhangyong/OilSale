//
//  PSKeepHomeRequest.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSKeepHomeRequest : BaseRequest


/// 进货时间，当前字段用于条件查询, 默认可为空，下拉后把列表最后的时间带回来作为分页条件
@property (nonatomic,copy) NSString *stock_time;
@end

NS_ASSUME_NONNULL_END
