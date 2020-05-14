//
//  PSDeliveryViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/13.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDeliveryViewModel.h"
#import "PSDriverOrderListRequest.h"
#import "NSString+RECategory.h"

@implementation PSDeliveryViewModel

#pragma mark- 数据处理

-(PSDeliveryModel *)ps_getDeliveryModelAtIndex:(NSInteger)index{
    
    if (index>= self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(NSString *)ps_getDeliverNoAtIndex:(NSInteger)index{
    
    PSDeliveryModel *model = [self ps_getDeliveryModelAtIndex:index];
    return [NSString stringWithFormat:@"送货单号：%@",model.way_bill_code];
}
-(CGFloat)ps_getDeliverNoHeightAtIndex:(NSInteger)index{
    
    CGFloat orderNoHeight = 20;
    NSString *orderNo = [self ps_getDeliverNoAtIndex:index];
    if (![BaseVerifyUtils isNullOrSpaceStr:orderNo]) {
        orderNoHeight = [orderNo heightWithFont:[UIFont systemWEPingFangRegularOfSize:14] width:kScreenWidth-30*2-70]+5;
    }
    return orderNoHeight;
}
-(NSString *)ps_getDeliverNoCodeAtIndex:(NSInteger)index{
    PSDeliveryModel *model = [self ps_getDeliveryModelAtIndex:index];
    return model.way_bill_code;
}
-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index{
    
    PSDeliveryModel *model = [self ps_getDeliveryModelAtIndex:index];
    NSString *url = model.product_info.bucket_pic;
    if ([BaseVerifyUtils isNullOrSpaceStr:url]) {
        url = model.bucket_pic_url;
    }
    return url;
}
-(NSString *)ps_getTitleAtIndex:(NSInteger)index{
    
    PSDeliveryModel *model = [self ps_getDeliveryModelAtIndex:index];
    //@"铁桶x9999"
    NSString *bucketType = model.product_info.bucket_type;
    if (model.commodity_name) {
        bucketType = model.commodity_name;
    }
    NSString *num = model.nozzle_num;
    if (![BaseVerifyUtils isNullOrSpaceStr:model.bucket_num]) {
        num = model.bucket_num;
    }
    return [NSString stringWithFormat:@"%@ x %@",bucketType,num];
}
-(NSString *)ps_getTimeAtIndex:(NSInteger)index{
    
    PSDeliveryModel *model = [self ps_getDeliveryModelAtIndex:index];
    return [NSString stringWithFormat:@"时间：%@",model.order_time];
}
-(NSString *)ps_getAddressAtIndex:(NSInteger)index{
    
    PSDeliveryModel *model = [self ps_getDeliveryModelAtIndex:index];

    return [NSString stringWithFormat:@"地址：%@%@",model.region,model.complete_address];
}


#pragma mark- 接口处理

-(void)requestDeliverDataWithTime:(NSString *)waybill_time
                             page:(NSInteger)page
                         Complete:(completeDataArrBlock)complete{
    
    PSDriverOrderListRequest *orderListRequest = [PSDriverOrderListRequest new];
    orderListRequest.waybill_time = waybill_time;
    if (self.deliverListType == DeliveryListTypeToaday) {
        orderListRequest.waybill_type = 1;
    }else{
        orderListRequest.waybill_type = 2;
    }
    [orderListRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
        
            NSArray *data = [PSDeliveryModel convertModelWithJsonArr:response.result[@"warehouse_model_list"]];
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
