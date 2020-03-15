//
//  PSOrderViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSOrderViewModel.h"
#import "PSOrderListRequest.h"
#import "PSOrderOperateRequest.h"

@implementation PSOrderViewModel


#pragma mark- 数据处理
-(PSOrderModel *)ps_getOrderModelAtIndex:(NSInteger)index{
    
    if (index>= self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}
-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index{
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    return orderModel.pic_url;
}

-(NSString *)ps_getOrderNoAtIndex:(NSInteger)index{
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    return [NSString stringWithFormat:@"订单号：%@",orderModel.order_code];
}
-(NSString *)ps_getOrderTimeAtIndex:(NSInteger)index{
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    return [NSString stringWithFormat:@"订单时间：%@",orderModel.shopping_time];
}


-(NSString *)ps_getOrderIdAtIndex:(NSInteger)index{
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    return orderModel.order_id;
}
-(NSString *)ps_getOrderCodeAtIndex:(NSInteger)index{
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    return orderModel.order_code;
}
-(NSString *)ps_getBuckerTypeAtIndex:(NSInteger)index{
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];

    if ([orderModel.product_type isEqualToString:@"farp"]) {
        return @"油品：柴油";
    }else if([orderModel.product_type isEqualToString:@"gun"]){
        return [NSString stringWithFormat:@"加油枪 x %@",orderModel.buy_num];

    }else{
        return [NSString stringWithFormat:@"油数量：%@ x %@",orderModel.bucket_type,orderModel.buy_num];
    }
}

-(NSString *)ps_getOrderStatusAtIndex:(NSInteger)index{
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    
    return orderModel.distribution_state_desc;
//    if (orderModel.order_state ==1) {
//        return @"未收货";
//    }else{
//        return @"已完成";
//    }
}
-(UIColor *)ps_getOrderStatusTextColorAtIndex:(NSInteger)index{
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    if (orderModel.order_state ==1) {
        return color_4084FF;
    }else{
        return color_FF6D32;
    }
}
/// 是否含税
/// @param index index
-(NSString *)ps_getOrderTaxStatusAtIndex:(NSInteger)index{
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    if ([orderModel.product_type isEqualToString:@"bucket"]) {
        return orderModel.tax_include_state_desc;
    }else{
        return @"";
    }
}
-(BOOL)ps_getIsShowOrderTaxStatusAtIndex:(NSInteger)index{
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    if ([orderModel.product_type isEqualToString:@"bucket"]) {
        return YES;
    }else{
        return NO;
    }
}
-(NSMutableAttributedString *)ps_getOrderPriceAtIndex:(NSInteger)index{
    
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    if ([orderModel.product_type isEqualToString:@"farp"]) {
        NSMutableString *carStr = [NSMutableString stringWithString:@""];
        for (int i =0;i<orderModel.car_info.count; i++) {
            
            if (i==0) {
                [carStr appendString:orderModel.car_info[i]];
            }else{
                [carStr appendFormat:@",%@",orderModel.car_info[i]];
            }
        }
        NSString *carNum = [NSString stringWithFormat:@"车辆：%@",carStr];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:carNum attributes:@{NSFontAttributeName:[UIFont systemWEPingFangMediumFontOfSize:16],NSForegroundColorAttributeName:color_333333}];
        return attr;
    }else if([orderModel.product_type isEqualToString:@"gun"]){
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"" attributes:@{NSFontAttributeName:[UIFont systemWEPingFangMediumFontOfSize:16],NSForegroundColorAttributeName:color_333333}];
        return attr;
        
    }else{
        NSString *price = orderModel.expect_amount;
        NSString *content = [NSString stringWithFormat:@"¥%@",price];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemWEPingFangMediumFontOfSize:16],NSForegroundColorAttributeName:color_333333}];
        NSArray *dotArr = [price componentsSeparatedByString:@"."];
        if (dotArr.count>0) {
            NSRange dotRange = [content rangeOfString:dotArr[0]];
            [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangMediumFontOfSize:25]} range:dotRange];
        }
        return attr;
        
    }
    
}

-(NSString *)ps_getOrderAddressAtIndex:(NSInteger)index{
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    if ([orderModel.product_type isEqualToString:@"farp"]) {
        NSString *address = [NSString stringWithFormat:@"地址:%@%@",orderModel.rec_region,orderModel.farp_address];
        return address;
    }else{
        NSString *address = [NSString stringWithFormat:@"地址:%@%@",orderModel.rec_region,orderModel.rec_complete_address];
        return address;
    }
    
}
-(NSString *)ps_getLeftBottomBtnTitleAtIndex:(NSInteger)index{
    if (self.listType == PSOrderListTypeCurrent) {
//        PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
//        if ([orderModel.product_type isEqualToString:@"farp"]) {
//            return @"取消预订";
//        }
        return @"取消订单";
    }else{
        return @"查看合同";
    }
}
-(BOOL)ps_getIsShowLeftBottomBtnTitleAtIndex:(NSInteger)index{
    if (self.listType == PSOrderListTypeCurrent) {
        PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
        if ([orderModel.product_type isEqualToString:@"farp"]) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}
-(NSString *)ps_getRightBottomBtnTitleAtIndex:(NSInteger)index{
    if (self.listType == PSOrderListTypeCurrent) {
        PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
        if ([orderModel.product_type isEqualToString:@"farp"]) {
            return @"取消预订";
        }else{
            return @"确认收货";
        }
    }else{
        return @"到货照片";
    }
}
-(BOOL)ps_getIsShowRightBottomBtnTitleAtIndex:(NSInteger)index{
    if (self.listType == PSOrderListTypeHistory) {
        return YES;
    }else{
        return YES;
    }
}
-(BOOL)ps_getIsShowCheckBottomBtnTitleAtIndex:(NSInteger)index{
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    if (self.listType == PSOrderListTypeCurrent && ![orderModel.product_type isEqualToString:@"farp"]) {
        return YES;
    }else{
        return NO;
    }
}
-(PSOrderBottomBtnType)ps_getBottomBtnTypeWithIsLeft:(BOOL)isLeft AtIndex:(NSInteger)index{

    if (isLeft) {
        if (self.listType == PSOrderListTypeCurrent) {
            return PSOrderBottomBtnTypeCancelOrder;
        }else{
            return PSOrderBottomBtnTypeCheckContract;
        }
    }else{
        if (self.listType == PSOrderListTypeCurrent) {
            PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
            if ([orderModel.product_type isEqualToString:@"farp"]) {
                return PSOrderBottomBtnTypeCancerReserve;
            }else{
                return PSOrderBottomBtnTypeConfirmReceive;
            }
        }else{
            return PSOrderBottomBtnTypeArrivePic;
        }
    }
}

-(void)ps_deleteOrderIndex:(NSInteger)index{
    if (index<self.dataSource.count) {
        [self.dataSource removeObjectAtIndex:index];
    }
}

#pragma mark- 到货照片处理
-(NSArray *)ps_getPicsArrAtIndex:(NSInteger)index{
    PSOrderModel *model  = [self ps_getOrderModelAtIndex:index];
    
    return model.pic_list;
}
-(PSOrderImageModel *)ps_getImageModelAtInex:(NSInteger)index
                                         row:(NSInteger)row{
    
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    if (row >= orderModel.pic_list.count) {
        return nil;
    }
    return orderModel.pic_list[row];
}
/// 照片url
-(NSString *)ps_getOrderPicImageUrlAtIndex:(NSInteger)index
                                       row:(NSInteger)row
                                  picIndex:(NSInteger)picIndex{
    PSOrderModel *orderModel = [self ps_getOrderModelAtIndex:index];
    if (row >= orderModel.pic_list.count) {
        return nil;
    }
    PSOrderImageModel *imageModel = orderModel.pic_list[row];
    if (picIndex >= imageModel.pic_url.count) {
        return @"";
    }
    return imageModel.pic_url[picIndex];
}

-(NSString *)ps_getImageModelTitleAtInex:(NSInteger)index
                                     row:(NSInteger)row{
    
    PSOrderImageModel *picModel = [self ps_getImageModelAtInex:index row:row];
    return picModel.order_item_name;
}
-(NSString *)ps_getImageModelDestinyAtInex:(NSInteger)index
                                     row:(NSInteger)row{
    PSOrderImageModel *picModel = [self ps_getImageModelAtInex:index row:row];
    return [NSString stringWithFormat:@"密度：%@    g/ml",picModel.density];
}
-(NSString *)ps_getImageModelVolumeAtInex:(NSInteger)index
                                     row:(NSInteger)row{
    PSOrderImageModel *picModel = [self ps_getImageModelAtInex:index row:row];
    return [NSString stringWithFormat:@"体积：%@    升",picModel.volume];
}
-(NSString *)ps_getImageModelWeightAtInex:(NSInteger)index
                                     row:(NSInteger)row{
    PSOrderImageModel *picModel = [self ps_getImageModelAtInex:index row:row];
    return [NSString stringWithFormat:@"重量：%@   千克",picModel.weight];
}


#pragma mark- 接口

-(void)requestOrderListWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete{
    
        
    
    PSOrderListRequest *listRequest = [PSOrderListRequest new];
    
    if (self.dataSource.count>0 && page>1) {
        PSOrderModel *lastModel = self.dataSource.lastObject;
        listRequest.order_time = lastModel.shopping_time;
    }
    if (self.listType == PSOrderListTypeCurrent) {
        listRequest.order_type = 1;
    }else if (self.listType == PSOrderListTypeHistory){
        listRequest.order_type = 3;
    }
    [listRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            NSArray *data = [PSOrderModel convertModelWithJsonArr:response.result[@"shopping_car_list"]];
            if (page ==1) {
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

-(void)requestOrderOperateWithOperateType:(NSInteger)operateType
                                 order_id:(NSString *)order_id
                               order_code:(NSString *)order_code
                                 complete:(completeBlock)complete{
    
    PSOrderOperateRequest *operateRequest = [PSOrderOperateRequest new];
    if (operateType == 1) {
        operateRequest.operate_type = @"confirm";
    }else if (operateType == 2){
        operateRequest.operate_type = @"cancel";
    }
    operateRequest.order_code = order_code;
    operateRequest.order_id = order_id.integerValue;
    [operateRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            
            complete(YES);
        }else{
            complete(NO);
        }
    }];
    
    
}
@end
