//
//  PSGetCanRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/20.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSGetCanRequest : BaseRequest

/// 铁桶数量
@property (nonatomic,copy) NSString *bucket_num;
/// 吨桶数量
@property (nonatomic,assign) NSInteger ibc_num;
/// 加油枪数量
@property (nonatomic,assign) NSInteger nozzle_num;
/// 客户电话
@property (nonatomic,copy) NSString *phone_num;

@end

NS_ASSUME_NONNULL_END
