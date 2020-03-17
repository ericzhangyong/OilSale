//
//  PSSalesmanOrderViewModel.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSSalesmanOrderViewModel.h"
#import "PSSalesmanOrderListRequest.h"

@implementation PSSalesmanOrderViewModel


-(PSSalesmanOrderModel *)ps_getOrderModelAtIndex:(NSInteger)index{
    
    if (index>= self.dataSource.count) {
        return nil;
    }
    
    return self.dataSource[index];
}

-(CGFloat)ps_getCellHeighttIndex:(NSInteger)index{
    if (self.listType == PSSalesmanOrderListTypeUnOrdered) {
        return 80;
    }else {
        return 110;
    }
}

-(NSString *)ps_getClientNameAtIndex:(NSInteger)index{
    
    PSSalesmanOrderModel *model = [self ps_getOrderModelAtIndex:index];
    
    return [NSString stringWithFormat:@"客户姓名：%@",model.client_name];
}
-(BOOL)ps_getIsShowOrderStatusAtIndex:(NSInteger)index{
    return self.listType == PSSalesmanOrderListTypeOrdered;
}
-(NSString *)ps_getOrderStatusAtIndex:(NSInteger)index{
    
    if (self.listType == PSSalesmanOrderListTypeOrdered) {
        PSSalesmanOrderModel *model = [self ps_getOrderModelAtIndex:index];

        return model.order_state_desc;
    }else{
        return @"";
    }
    
}
-(NSString *)ps_getOrderTimeAtIndex:(NSInteger)index{
    
    PSSalesmanOrderModel *model = [self ps_getOrderModelAtIndex:index];
    NSString *title = @"";
    if (self.listType == PSSalesmanOrderListTypeUnOrdered) {
        title = [NSString stringWithFormat:@"注册时间：%@",model.operate_time];
    }else if (self.listType == PSSalesmanOrderListTypeOrdered){
        title = [NSString stringWithFormat:@"下单时间：%@",model.operate_time];
    }else if (self.listType == PSSalesmanOrderListTypeOrderFinished){
        title = [NSString stringWithFormat:@"完成时间：%@",model.operate_time];
    }else if (self.listType == PSSalesmanOrderListTypeOrderCancel){
        title = [NSString stringWithFormat:@"取消时间：%@",model.operate_time];
    }
    return title;
}
-(NSString *)ps_getOrderCancelReasonAtIndex:(NSInteger)index{

    PSSalesmanOrderModel *model = [self ps_getOrderModelAtIndex:index];
    NSString *reason = @"";
    if (self.listType == PSSalesmanOrderListTypeOrderCancel) {
        reason = [NSString stringWithFormat:@"取消原因：%@",model.order_cancel_reason];
    }
    return reason;
}
-(BOOL)ps_getIsShowOrderCancelReasonAtIndex:(NSInteger)index{

    if (self.listType == PSSalesmanOrderListTypeOrderCancel) {
        return YES;
    }else{
        return NO;
    }
}
-(BOOL)ps_getIsShowOrderContractAtIndex:(NSInteger)index{

    if (self.listType == PSSalesmanOrderListTypeOrderFinished || self.listType == PSSalesmanOrderListTypeOrdered) {
        return YES;
    }else{
        return NO;
    }
}
-(NSString *)ps_getOrderSaleAwardAtIndex:(NSInteger)index{
    PSSalesmanOrderModel *model = [self ps_getOrderModelAtIndex:index];
    return [NSString stringWithFormat:@"销售奖金：¥%@",model.bonus];
}
-(BOOL)ps_getIsShowOrderSaleAwardAtIndex:(NSInteger)index{
   
    return self.listType == PSSalesmanOrderListTypeOrderFinished;
}


-(void)requestOrderListWithPage:(NSInteger)page
                       Complete:(completeDataArrBlock)complete{
    
    PSSalesmanOrderListRequest *orderList = [PSSalesmanOrderListRequest new];
    if (page !=1 && self.dataSource.count>0) {
        PSSalesmanOrderModel *lastModel =[self ps_getOrderModelAtIndex:self.dataSource.count-1];
        orderList.operate_time = lastModel.operate_time;
    }
    orderList.order_type = @(self.listType).stringValue;
    [orderList postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            NSArray *result = response.result[@"client_order_list"];
            NSArray *data = [PSSalesmanOrderModel convertModelWithJsonArr:result];
            if (page == 1) {
                [self.dataSource setArray:data];
            }else{
                [self.dataSource addObjectsFromArray:data];
            }
            complete(YES,data);
        }else{
            complete(NO,@[]);
        }
    }];
}
@end
