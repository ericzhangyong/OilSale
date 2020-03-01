//
//  FSAddresReceiveModel.h
//  FireStore
//
//  Created by eric on 2019/9/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSAddresReceiveModel : BaseModel


/// 收货地址id
@property (nonatomic,copy) NSString *rec_addr_id;
/// 收货人
@property (nonatomic,copy) NSString *consignee;

/// 手机号码
@property (nonatomic,copy) NSString *phone_num;

/// 区域
@property (nonatomic,copy) NSString *region;

/// 详细地址
@property (nonatomic,copy) NSString *complete_address;




@end

NS_ASSUME_NONNULL_END
