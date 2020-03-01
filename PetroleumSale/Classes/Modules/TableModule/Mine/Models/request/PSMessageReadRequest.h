//
//  PSMessageReadRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSMessageReadRequest : BaseRequest
  //放id即可
@property (nonatomic,copy) NSArray *notice_ids;

/// 要设置的状态 1 为设置为已读 0 为设置为未读 当前直接传1就行
@property (nonatomic,assign) NSInteger notice_state;

/// 通知类型 1 系统通知 2 罚款通知
@property (nonatomic,assign) NSInteger notice_type;


@end

NS_ASSUME_NONNULL_END
