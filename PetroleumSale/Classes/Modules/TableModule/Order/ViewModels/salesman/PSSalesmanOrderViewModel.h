//
//  PSSalesmanOrderViewModel.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSSalesmanOrderModel.h"
typedef NS_ENUM(NSInteger,PSSalesmanOrderListType){
    PSSalesmanOrderListTypeUnOrdered, //未下单
    PSSalesmanOrderListTypeOrdered,//已下单
    PSSalesmanOrderListTypeOrderFinished,//已完成
    PSSalesmanOrderListTypeOrderCancel //已取消
};
NS_ASSUME_NONNULL_BEGIN

@interface PSSalesmanOrderViewModel : BaseViewModel

@property (nonatomic,assign) PSSalesmanOrderListType listType;


-(CGFloat)ps_getCellHeighttIndex:(NSInteger)index;
-(NSString *)ps_getClientNameAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowOrderStatusAtIndex:(NSInteger)index;
-(NSString *)ps_getOrderStatusAtIndex:(NSInteger)index;
-(NSString *)ps_getOrderTimeAtIndex:(NSInteger)index;
-(NSString *)ps_getOrderCancelReasonAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowOrderCancelReasonAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowOrderContractAtIndex:(NSInteger)index;
-(NSString *)ps_getOrderSaleAwardAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowOrderSaleAwardAtIndex:(NSInteger)index;

    
    

-(void)requestOrderListWithPage:(NSInteger)page
                       Complete:(completeDataArrBlock)complete;
@end

NS_ASSUME_NONNULL_END
