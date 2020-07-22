//
//  PSSenderDeliverViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDeliverViewModel.h"
#import "PSSenderDeliveryUnSendRequest.h"
#import "PSSenderDeliverySendedRequest.h"
#import "NSString+RECategory.h"
#import "PSSenederPickOneSelfListReqest.h"
#import "PSSenderPickerOneSelfNumSaveRequest.h"

@implementation PSSenderDeliverViewModel

#pragma mark -数据处理
-(PSSenderDeliveryModel *)ps_getSenderOrderModelAtIndex:(NSInteger)index{
    
    if (index>= self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(NSString *)ps_getDeliverNoAtIndex:(NSInteger)index{
    
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    if(self.listType == PSSenderDeliverListTypeSended){
        return [NSString stringWithFormat:@"送货单号：%@",senderOrderModel.waybill_info.WbCode];
    }else{
        return [NSString stringWithFormat:@"订单号：%@",senderOrderModel.order_info.order_code];
    }
}

-(NSString *)ps_getDeliverWay_bill_idAtIndex:(NSInteger)index{
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    return senderOrderModel.waybill_info.Id;
}
-(NSArray *)ps_getDeliverOrderIdArr{
    NSMutableArray *selectArr = [NSMutableArray array];
    
    for (PSSenderDeliveryModel *model in self.dataSource) {
        if (model.isSelected) {
            [selectArr addObject:@(model.waybill_info.Id.integerValue)];
        }
    }
    return selectArr;
}
-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index{
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    return senderOrderModel.order_info.pic_url;
}

-(NSString *)ps_getBucketTypeAtIndex:(NSInteger)index{
    
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    NSString *string = [NSString stringWithFormat:@"%@ x %@",senderOrderModel.order_info.bucket_type,senderOrderModel.order_info.buy_num];
    return   string;
}
-(NSString *)ps_getPriceAtIndex:(NSInteger)index{
    
    if (self.listType == PSSenderDeliverListTypePickOneSelf) {
        PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
        return [NSString stringWithFormat:@"总价：¥%.2lf",senderOrderModel.order_info.expect_amount.doubleValue];
    }else{
        PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
        return [NSString stringWithFormat:@"下单价格：¥%.2lf",senderOrderModel.order_info.expect_amount.doubleValue];
    }
    
}
-(NSString *)ps_getNameAtIndex:(NSInteger)index{
    
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    if (self.listType == PSSenderDeliverListTypeSended) {
        return [NSString stringWithFormat:@"联系人：%@   电话：%@",senderOrderModel.order_info.consignee,senderOrderModel.order_info.phone_num];
    }else{
        return [NSString stringWithFormat:@"收货联系人：%@",senderOrderModel.order_info.consignee];
    }
}


-(NSString *)ps_getSiglePriceAtIndex:(NSInteger)index{

    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    
    return [NSString stringWithFormat:@"单价：%@/升",senderOrderModel.unit_price];
}
-(BOOL)ps_getIsShowSiglePriceAtIndex:(NSInteger)index{
    if (self.listType == PSSenderDeliverListTypePickOneSelf) {
        return YES;
    }else{
        return NO;
    }
}
-(CGFloat)ps_getNameWidthAtIndex:(NSInteger)index{

    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    NSString *text =  [NSString stringWithFormat:@"联系人：%@",senderOrderModel.order_info.consignee];
    CGFloat width = 65;
    if (![BaseVerifyUtils isNullOrSpaceStr:text]) {
        width = [text widthWithFont:[UIFont systemWEPingFangRegularOfSize:14]]+5;
    }
    return width;
}

-(NSString *)ps_getPhoneAtIndex:(NSInteger)index{
    
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    if (self.listType == PSSenderDeliverListTypeSended) {
       return [self getHandleAddressAtIndex:index];
    }else{
        return [NSString stringWithFormat:@"电话：%@",senderOrderModel.order_info.phone_num];
    }
}
-(NSString *)ps_getLabelPickOneSelfTitleAtIndex:(NSInteger)index{

    if (self.listType == PSSenderDeliverListTypePickOneSelf) {
        return @"自提单号：";
    }else{
        return @"仓库：";
    }
}
-(NSString *)ps_getLabelPickOneSelfContentAtIndex:(NSInteger)index{
    
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    if (self.listType == PSSenderDeliverListTypePickOneSelf) {
        return @"";
    }else{
        return senderOrderModel.order_info.warehouse_name;
    }
}
-(BOOL)ps_getIsEnablePickOneSelfTextFieldAtIndex:(NSInteger)index{
//    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    if (self.listType == PSSenderDeliverListTypePickOneSelf) {
        return YES;
    }else{
        return NO;
    }
}

-(NSString *)ps_getAddressAtIndex:(NSInteger)index{
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    if (self.listType == PSSenderDeliverListTypeSended) {
        NSString *name = @"";
        if (![BaseVerifyUtils isNullOrSpaceStr:senderOrderModel.driver_info.UiName]) {
            name = senderOrderModel.driver_info.UiName;
        }
        return  [NSString stringWithFormat:@"司机：%@",name];
    }
    else{
        return [self getHandleAddressAtIndex:index];
    }
}


-(NSString *)getHandleAddressAtIndex:(NSInteger)index{
    
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    if (![BaseVerifyUtils isNumber:senderOrderModel.order_info.farp_address]) {
        return [NSString stringWithFormat:@"收货地址：%@",senderOrderModel.order_info.farp_address];
    }else{
       return [NSString stringWithFormat:@"收货地址：%@%@",senderOrderModel.order_info.rec_region,senderOrderModel.order_info.rec_complete_address];
    }
}

-(NSString *)ps_getDriverNameStatusAtIndex:(NSInteger)index{
    
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    NSString *name = @"";
    if (![BaseVerifyUtils isNullOrSpaceStr:senderOrderModel.driver_info.UiName]) {
        name = senderOrderModel.driver_info.UiName;
    }
    return [NSString stringWithFormat:@"运货司机：%@",name];
}
-(NSString *)ps_getSenderStatusAtIndex:(NSInteger)index{
    
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    NSString *status = senderOrderModel.waybill_info.wb_state_desc;
    if ([BaseVerifyUtils isNullOrSpaceStr:status]) {
        status = @"";
    }
    return status;
}
-(BOOL)ps_getIsShowSenderStatusAtIndex:(NSInteger)index{
    if (self.listType == PSSenderDeliverListTypeSended) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)ps_getIsSelectedAtIndex:(NSInteger)index{
    
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    return senderOrderModel.isSelected;
}
-(BOOL)ps_getIsShowBtnSelectedAtIndex:(NSInteger)index{
    if (self.listType == PSSenderDeliverListTypeUnSended) {
        return YES;
    }else{
        return NO;
    }
}


-(void)ps_setIsSelectedAtIndex:(NSInteger)index IsSelected:(BOOL)isSelected{
    PSSenderDeliveryModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    senderOrderModel.isSelected = isSelected;
}

-(void)requestDeliveryListWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete{
   
    if (self.listType == PSSenderDeliverListTypeSended) {
        
        PSSenderDeliverySendedRequest *SendedlistReqeust = [PSSenderDeliverySendedRequest new];
        if (page != 1) {
            if (self.dataSource.count>0) {
                PSSenderDeliveryModel *model = self.dataSource.lastObject;
                SendedlistReqeust.dispatch_time = model.waybill_info.WbDispatchTime;
            }
        }
        [SendedlistReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                
                NSArray *data = [PSSenderDeliveryModel convertModelWithJsonArr:response.result[@"dispatch_waybill_model"]];
                if (page == 1) {
                    [self.dataSource setArray:data];
                }else{
                    [self.dataSource addObjectsFromArray:data];
                }
                complete(YES,data);
            }else{
                [self.dataSource setArray:@[]];
                complete(NO,@[]);
            }
        }];
    }else if (self.listType == PSSenderDeliverListTypePickOneSelf){
            
        PSSenederPickOneSelfListReqest *SendedlistReqeust = [PSSenederPickOneSelfListReqest new];
        if (page != 1) {
            if (self.dataSource.count>0) {
                PSSenderDeliveryModel *model = self.dataSource.lastObject;
                SendedlistReqeust.dispatch_time = model.waybill_info.WbDispatchTime;
            }
        }
        [SendedlistReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                
                NSArray *data = [PSSenderDeliveryModel convertModelWithJsonArr:response.result[@"dispatch_waybill_model"]];
                if (page == 1) {
                    [self.dataSource setArray:data];
                }else{
                    [self.dataSource addObjectsFromArray:data];
                }
                complete(YES,data);
            }else{
                [self.dataSource setArray:@[]];
                complete(NO,@[]);
            }
        }];
    }
    else{
       PSSenderDeliveryUnSendRequest *unSendedlistReqeust = [PSSenderDeliveryUnSendRequest new];
        
        [unSendedlistReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                
                NSArray *data = [PSSenderDeliveryModel convertModelWithJsonArr:response.result[@"dispatch_waybill_model"]];
                if (page == 1) {
                    [self.dataSource setArray:data];
                }else{
                    [self.dataSource addObjectsFromArray:data];
                }
                complete(YES,data);
            }else{
                [self.dataSource setArray:@[]];
                complete(NO,@[]);
            }
        }];
    }
    
}

-(void)requestSavePickOneSelfWithCode:(NSString *)code
                          way_bill_id:(NSString *)way_bill_id
                             complete:(completeBlock)complete{
    
    PSSenderPickerOneSelfNumSaveRequest *saveRequest =[PSSenderPickerOneSelfNumSaveRequest new];
    saveRequest.mention_code = code;
    saveRequest.way_bill_id = way_bill_id.integerValue;
    [saveRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}

@end
