//
//  PSSenderDeliverySendedRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderDeliverySendedRequest : BaseRequest

/// 派单时间 跟其他分页查询一样，首次可填当前时间或不填，下拉后填写后面的日期
@property (nonatomic,copy) NSString *dispatch_time;

@end

NS_ASSUME_NONNULL_END
