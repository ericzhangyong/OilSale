//
//  PSSenderOrderViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSSenderOrderModel.h"
typedef NS_ENUM(NSInteger,SenderListType){
    SenderListTypeHome,//首页
    SenderListTypeStation,//加油点
};

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderOrderViewModel : BaseViewModel

@property (nonatomic,assign) SenderListType listType;

#pragma mark -数据处理

-(NSString *)ps_getDeliverNoAtIndex:(NSInteger)index;
-(NSString *)ps_getDeliverOrderTimeAtIndex:(NSInteger)index;
-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index;
-(NSString *)ps_getBucketTypeAtIndex:(NSInteger)index;
-(NSString *)ps_getPriceAtIndex:(NSInteger)index;
-(NSString *)ps_getNameAtIndex:(NSInteger)index;
-(NSString *)ps_getCarNumAtIndex:(NSInteger)index;
-(CGFloat)ps_getNameWidthAtIndex:(NSInteger)index;
-(NSString *)ps_getPhoneAtIndex:(NSInteger)index;
-(NSMutableAttributedString *)ps_getIsDebtAtIndex:(NSInteger)index;
-(NSString *)ps_getAddressAtIndex:(NSInteger)index;
-(NSString *)ps_getwarHouseStatusAtIndex:(NSInteger)index;
-(UIColor *)ps_getwarHouseStatusColorAtIndex:(NSInteger)index;
-(NSString *)ps_getFinalStatusAtIndex:(NSInteger)index;
-(UIColor *)ps_getFinalStatusColorAtIndex:(NSInteger)index;
-(NSString *)ps_getBossStatusAtIndex:(NSInteger)index;
-(UIColor *)ps_getBossStatusColorAtIndex:(NSInteger)index;



#pragma mark- 接口

-(void)requestOrderListWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete;


-(void)reqeustSendOrderWithOrderIdAtIndex:(NSInteger)index complete:(completeBlock)complete;

@end

NS_ASSUME_NONNULL_END
