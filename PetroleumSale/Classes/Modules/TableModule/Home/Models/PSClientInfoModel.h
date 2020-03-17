//
//  PSClientInfoModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSClientInfoModel : BaseModel

/// des
@property (nonatomic,copy) NSString *client_id;

/// 客户流失时间
@property (nonatomic,copy) NSString *client_lost_time;
/// 客户姓名
@property (nonatomic,copy) NSString *client_name;
/// 客户注册时间
@property (nonatomic,copy) NSString *client_regist_time;
/// 当前客户状态
@property (nonatomic,copy) NSString *client_state_desc;
/// 最近一次拜访时间
@property (nonatomic,copy) NSString *recently_visit_time;
/// 拜访状态 1 为已经拜访 0 为未拜访
@property (nonatomic,copy) NSString *visit_state;

@end

NS_ASSUME_NONNULL_END
