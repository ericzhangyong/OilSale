//
//  PSCanListModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"
@class PSCanReturnModel;

NS_ASSUME_NONNULL_BEGIN

@interface PSCanListModel : BaseModel

/// 铁桶未还桶数量
@property (nonatomic,copy) NSString *no_returned_bucket_num;
/// 吨桶未还桶数量
@property (nonatomic,copy) NSString *no_returned_nozzle_num;
/// 加油枪未还桶数量
@property (nonatomic,copy) NSString *no_returned_ibc_num;

@property (nonatomic,strong) NSMutableArray<PSCanReturnModel *> *returned_record_list;

@property (nonatomic,copy) NSArray<PSCanReturnModel *> *wait_confirm_info;

@end

@interface PSCanReturnModel : BaseModel

#pragma mark- 还桶记录

/// 还桶时间
@property (nonatomic,copy) NSString *returned_time;

/// 还桶数量
@property (nonatomic,copy) NSString *returned_num;

#pragma mark- 司机还桶请求model

/// 点击确认后提交的id
@property (nonatomic,copy) NSString *confirm_info_id;

/// 点击确认后提交的key
@property (nonatomic,copy) NSString *confirm_key;

/// 回收司机姓名
@property (nonatomic,copy) NSString *driver_name;

/// 回收桶数量
@property (nonatomic,copy) NSString *recovery_num;

/// 回收时间
@property (nonatomic,copy) NSString *recovery_time;
///司机类型
@property (nonatomic,assign) BOOL isDriverReturnType;

@end

NS_ASSUME_NONNULL_END
