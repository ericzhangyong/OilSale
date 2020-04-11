//
//  PSKeeperHomeViewModel.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSKeeperHomeViewModel.h"
#import "PSKeepHomeRequest.h"

@implementation PSKeeperHomeViewModel


-(PSKeeperStockModel *)ps_getStockModelAtIndex:(NSInteger)index{
    
    if (index >= self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(NSString *)ps_getOrderNumAtIndex:(NSInteger)index{
    
    PSKeeperStockModel *model = [self ps_getStockModelAtIndex:index];
    return [NSString stringWithFormat:@"进货单号：%@",model.stock_code];
}
-(NSString *)ps_getVarityAtIndex:(NSInteger)index{
    
    PSKeeperStockModel *model = [self ps_getStockModelAtIndex:index];
    return [NSString stringWithFormat:@"种类：%@",model.oil_type];
}
-(NSString *)ps_getWeightAtIndex:(NSInteger)index{
    
    PSKeeperStockModel *model = [self ps_getStockModelAtIndex:index];
    return [NSString stringWithFormat:@"总重量：%@ KG",model.stock_weight];
}
-(NSString *)ps_getTimeAtIndex:(NSInteger)index{
    
    PSKeeperStockModel *model = [self ps_getStockModelAtIndex:index];
    return [NSString stringWithFormat:@"进货时间：%@",model.stock_time];
}
-(NSString *)ps_getCodeAtIndex:(NSInteger)index{
    
    PSKeeperStockModel *model = [self ps_getStockModelAtIndex:index];
    return [NSString stringWithFormat:@"编号：%@",model.code];
}
-(NSString *)ps_getDensityAtIndex:(NSInteger)index{
    
    PSKeeperStockModel *model = [self ps_getStockModelAtIndex:index];
    return [NSString stringWithFormat:@"密度：%@ KG/L",model.stock_density];
}
-(NSString *)ps_getPinXiangAtIndex:(NSInteger)index{
    
    PSKeeperStockModel *model = [self ps_getStockModelAtIndex:index];
    NSString *pinx = model.product_phase;
    if ([BaseVerifyUtils isNullOrSpaceStr:pinx]) {
        pinx = @"未知";
    }
    return [NSString stringWithFormat:@"品相：%@",pinx];
}


#pragma mark- 接口

-(void)requestHomelistWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete{
    
    
    
    
    PSKeepHomeRequest *listRequest = [PSKeepHomeRequest new];
    
    if (page !=  1) {
        PSKeeperStockModel *lastModel = self.dataSource.lastObject;
        listRequest.stock_time = lastModel.stock_time;
    }
    
    [listRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            self.oil_price = response.result[@"oil_price"];
            self.oil_total = @"12345";
            NSArray *data= [PSKeeperStockModel convertModelWithJsonArr:response.result[@"stock_info_list"]];
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
