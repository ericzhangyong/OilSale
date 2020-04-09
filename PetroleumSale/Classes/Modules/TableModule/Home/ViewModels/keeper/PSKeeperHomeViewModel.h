//
//  PSKeeperHomeViewModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSKeeperStockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSKeeperHomeViewModel : BaseViewModel

/// 今日油价
@property (nonatomic,copy) NSString *oil_price;
/// 仓库油量
@property (nonatomic,copy) NSString *oil_total;

-(NSString *)ps_getOrderNumAtIndex:(NSInteger)index;
-(NSString *)ps_getVarityAtIndex:(NSInteger)index;
-(NSString *)ps_getWeightAtIndex:(NSInteger)index;
-(NSString *)ps_getTimeAtIndex:(NSInteger)index;
-(NSString *)ps_getCodeAtIndex:(NSInteger)index;
-(NSString *)ps_getDensityAtIndex:(NSInteger)index;
-(NSString *)ps_getPinXiangAtIndex:(NSInteger)index;


#pragma mark- 接口

-(void)requestHomelistWithPage:(NSInteger)page Complete:(completeDataArrBlock)complte;


@end

NS_ASSUME_NONNULL_END
