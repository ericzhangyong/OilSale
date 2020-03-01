//
//  PSWareHouseModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSWareHouseModel : BaseModel
@property (nonatomic,copy) NSString *Id;

/// 数据状态 1 启用 0 停用
@property (nonatomic,copy) NSString *State;

/// 仓库名称
@property (nonatomic,copy) NSString *WhName;

/// 仓库地址
@property (nonatomic,copy) NSString *WhAddress;
@end

NS_ASSUME_NONNULL_END
