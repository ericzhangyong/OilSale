//
//  PSSavePhotoRequest.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/20.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseRequest.h"
#import "PSPhotoConfirmModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSSavePhotoRequest : BaseRequest

/// 加油枪个数
@property (nonatomic,assign) NSInteger nozzle_num;
/// 加油枪订单id 从获取的订单上取值
@property (nonatomic,assign) NSInteger nozzle_order_id;
/// 订单id
@property (nonatomic,assign) NSInteger order_id;

@property (nonatomic,copy) NSArray<PSBucketModel *> *sub_bucket_info_list;


@end

NS_ASSUME_NONNULL_END
