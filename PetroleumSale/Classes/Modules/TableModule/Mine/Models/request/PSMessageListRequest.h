//
//  PSMessageListRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/5.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSMessageListRequest : BaseRequest


/// 查询时间，默认从当前时间查询，每次返回10调，下拉加载更多后，从截止时间点作为查询时间点
@property (nonatomic,copy) NSString *publish_time;
/// 通知类型 1 系统通知 2 罚款通知
@property (nonatomic,assign) NSInteger notice_type;
@end

NS_ASSUME_NONNULL_END
