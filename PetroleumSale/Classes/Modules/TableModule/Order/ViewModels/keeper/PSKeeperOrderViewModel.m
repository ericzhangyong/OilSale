//
//  PSKeeperOrderViewModel.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSKeeperOrderViewModel.h"
#import "PSKeepOrderAgressRequest.h"
#import "PSKeepOrderListReqeust.h"

@implementation PSKeeperOrderViewModel


-(NSString *)ps_getCurrentOidCount{
    
    return [NSString stringWithFormat:@"吨桶x%@    铁桶x%@",self.bucket_num,self.ibc_num];
}

-(PSKeepOrderModel *)ps_getOrderModelAtIndex:(NSInteger)index{
    if (index>=self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(NSString *)ps_orderTimeAtIndex:(NSInteger)index{
    
    PSKeepOrderModel *model = [self ps_getOrderModelAtIndex:index];
    return [NSString stringWithFormat:@"下单时间:%@",model.order_time];
}
-(NSString *)ps_orderTieBucketCountAtIndex:(NSInteger)index{
    
    PSKeepOrderModel *model = [self ps_getOrderModelAtIndex:index];
    return [NSString stringWithFormat:@"下单铁桶：%@",model.order_bucket_num];
}
-(NSString *)ps_orderDunBucketCountAtIndex:(NSInteger)index{
    
    PSKeepOrderModel *model = [self ps_getOrderModelAtIndex:index];
    return [NSString stringWithFormat:@"下单吨桶：%@",model.order_ibc_num];
}
-(NSMutableAttributedString *)ps_orderTieLastBucketCountAtIndex:(NSInteger)index{
    
    PSKeepOrderModel *model = [self ps_getOrderModelAtIndex:index];
    NSString *content =  [NSString stringWithFormat:@"同意后剩余铁桶：%@",model.will_surplus_bucket_num];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSForegroundColorAttributeName:color_666666,NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:14]}];
    if (![BaseVerifyUtils isNullOrSpaceStr:model.will_surplus_ibc_num]) {
        NSRange range = [content rangeOfString:model.will_surplus_bucket_num];
        [attr addAttribute:NSForegroundColorAttributeName value:color_FF5C29 range:range];
    }
    return attr;
}
-(NSMutableAttributedString *)ps_orderDunLastBucketCountAtIndex:(NSInteger)index{
    
    PSKeepOrderModel *model = [self ps_getOrderModelAtIndex:index];
    NSString *content =  [NSString stringWithFormat:@"同意后剩余吨桶：%@",model.will_surplus_ibc_num];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSForegroundColorAttributeName:color_666666,NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:14]}];
    if (![BaseVerifyUtils isNullOrSpaceStr:model.will_surplus_ibc_num]) {
        NSRange range = [content rangeOfString:model.will_surplus_ibc_num];
        [attr addAttribute:NSForegroundColorAttributeName value:color_4084FF range:range];
    }
    return attr;
}





-(void)requestOrderListWithPage:(NSInteger)page complete:(completeDataArrBlock)complete{
    
    
    PSKeepOrderListReqeust *listReqeust = [PSKeepOrderListReqeust new];
    if (page != 1) {
        PSKeepOrderModel *lastModel = self.dataSource.lastObject;
        listReqeust.operate_time = lastModel.order_time;
    }
    [listReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            NSDictionary *now_stock = response.result[@"now_stock"];
            self.bucket_num = now_stock[@"bucket_num"];
            self.ibc_num = now_stock[@"ibc_num"];
            NSArray *data = [PSKeepOrderModel convertModelWithJsonArr:response.result[@"ver_order_list"]];
            if (page == 1) {
                [self.dataSource setArray:data];
            }else{
                [self.dataSource addObjectsFromArray:data];
            }
            complete(YES,@[]);
        }else{
            complete(NO,@[]);
        }
    }];
    
}

-(void)requestAggreeStatus:(BOOL)isAgress complete:(completeBlock)complete{
    
    PSKeepOrderAgressRequest *agrees  = [PSKeepOrderAgressRequest new];
    [agrees postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if(response.isFinished){
            
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}

@end
