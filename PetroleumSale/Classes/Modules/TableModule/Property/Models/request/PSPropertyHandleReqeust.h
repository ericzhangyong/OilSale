//
//  PSPropertyHandleReqeust.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSPropertyHandleReqeust : BaseRequest

/// 回收数量
@property (nonatomic,assign) NSInteger back_num;
/// 回收类型 bucket 油桶 ibc 吨桶 gun 加油枪
@property (nonatomic,copy) NSString *back_type;
/// 操作类型 delete 为处理 add为新增 update为回收
@property (nonatomic,copy) NSString *operate_type;
/// 仓库id
@property (nonatomic,assign) NSInteger storage_id;


@end

NS_ASSUME_NONNULL_END
