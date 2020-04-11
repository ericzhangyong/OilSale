//
//  PSKeeperOrderViewModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSKeepOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSKeeperOrderViewModel : BaseViewModel

/// 铁通数量
@property (nonatomic,copy) NSString *bucket_num;
/// 吨桶数量
@property (nonatomic,copy) NSString *ibc_num;


-(NSString *)ps_getCurrentOidCount;
-(NSString *)ps_orderTimeAtIndex:(NSInteger)index;
-(NSString *)ps_orderTieBucketCountAtIndex:(NSInteger)index;
-(NSString *)ps_orderDunBucketCountAtIndex:(NSInteger)index;
-(NSMutableAttributedString *)ps_orderTieLastBucketCountAtIndex:(NSInteger)index;
-(NSMutableAttributedString *)ps_orderDunLastBucketCountAtIndex:(NSInteger)index;


-(void)requestOrderListWithPage:(NSInteger)page complete:(completeDataArrBlock)complete;

-(void)requestAggreeStatus:(BOOL)isAgress complete:(completeBlock)complete;


@end

NS_ASSUME_NONNULL_END
