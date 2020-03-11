//
//  PSSenderOrderViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSSenderOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderOrderViewModel : BaseViewModel



#pragma mark -数据处理

-(NSString *)ps_getDeliverNoAtIndex:(NSInteger)index;
-(NSString *)ps_getDeliverOrderTimeAtIndex:(NSInteger)index;
-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index;
-(NSString *)ps_getBucketTypeAtIndex:(NSInteger)index;
-(NSString *)ps_getPriceAtIndex:(NSInteger)index;
-(NSString *)ps_getNameAtIndex:(NSInteger)index;
-(CGFloat)ps_getNameWidthAtIndex:(NSInteger)index;
-(NSString *)ps_getPhoneAtIndex:(NSInteger)index;
-(NSString *)ps_getIsDebtAtIndex:(NSInteger)index;
-(NSString *)ps_getAddressAtIndex:(NSInteger)index;
-(NSString *)ps_getwarHouseStatusAtIndex:(NSInteger)index;
-(UIColor *)ps_getwarHouseStatusColorAtIndex:(NSInteger)index;
-(NSString *)ps_getFinalStatusAtIndex:(NSInteger)index;
-(UIColor *)ps_getFinalStatusColorAtIndex:(NSInteger)index;
-(NSString *)ps_getBossStatusAtIndex:(NSInteger)index;
-(UIColor *)ps_getBossStatusColorAtIndex:(NSInteger)index;



#pragma mark- 接口

-(void)requestOrderListWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete;


@end

NS_ASSUME_NONNULL_END
