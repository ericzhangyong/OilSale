//
//  PSPersonAcountModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSPersonAcountModel : BaseModel

/// 用户性别 1 男 0 女
@property (nonatomic,copy) NSString *user_sex;
/// 用户名
@property (nonatomic,copy) NSString *user_name;

/// 主账号
@property (nonatomic,copy) NSString *account;

/// 当前账号类型 1 主账号 0 子账号 主账号可添加子账号，若当前账号为子账号，则不可添加子账号，前端置子账号编辑区为只读
@property (nonatomic,assign) BOOL account_type;

/// 子账号1
@property (nonatomic,copy) NSString *sub_account_1;
/// 子账号2
@property (nonatomic,copy) NSString *sub_account_2;
@end

NS_ASSUME_NONNULL_END
