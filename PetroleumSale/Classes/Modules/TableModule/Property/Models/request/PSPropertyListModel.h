//
//  PSPropertyListModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSPropertyListModel : BaseModel

/// 铁桶数量
@property (nonatomic,copy) NSString *bucket_num;

/// 加油枪数量
@property (nonatomic,copy) NSString *gun_num;

/// 吨桶数量
@property (nonatomic,copy) NSString *irc_num;
/// 仓库地址
@property (nonatomic,copy) NSString *storage_address;
/// 仓库id
@property (nonatomic,copy) NSString *storage_id;
/// 仓库名称
@property (nonatomic,copy) NSString *storage_name;

@end

NS_ASSUME_NONNULL_END
