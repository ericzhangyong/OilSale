//
//  PSAddressSaveRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/27.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSAddressSaveRequest : BaseRequest
/// 收货人
@property (nonatomic,copy) NSString *consignee;

/// 手机号码
@property (nonatomic,copy) NSString *phone_num;

/// 区域
@property (nonatomic,copy) NSString *region;

/// 详细地址
@property (nonatomic,copy) NSString *complete_address;

/// rec_addr_id
@property (nonatomic,assign) NSInteger rec_addr_id;

@end

NS_ASSUME_NONNULL_END
