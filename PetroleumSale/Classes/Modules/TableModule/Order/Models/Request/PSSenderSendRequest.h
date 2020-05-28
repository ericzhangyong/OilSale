//
//  PSSenderSendRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderSendRequest : BaseRequest


/// 司机id
@property (nonatomic,assign) NSInteger driver_id;
/// 运单id
@property (nonatomic,copy) NSArray *way_bill_id;

/// 仓库管理员id
@property (nonatomic,assign) NSInteger storekeeper_id;
@end

NS_ASSUME_NONNULL_END
