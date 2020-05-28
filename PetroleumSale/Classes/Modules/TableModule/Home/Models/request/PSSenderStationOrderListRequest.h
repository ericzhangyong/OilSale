//
//  PSSenderStationOrderListRequest.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/5/16.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderStationOrderListRequest : BaseRequest


/// 下单时间 跟其他分页查询一样，首次可填当前时间或不填，下拉后填写后面的日期
@property (nonatomic,copy) NSString *shopping_time;
@end

NS_ASSUME_NONNULL_END
