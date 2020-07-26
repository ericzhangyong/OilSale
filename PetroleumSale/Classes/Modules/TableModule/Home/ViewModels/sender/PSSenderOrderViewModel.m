//
//  PSSenderOrderViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderOrderViewModel.h"
#import "PSSenderOrderListRequest.h"
#import "NSString+RECategory.h"
#import "PSSenderStationOrderListRequest.h"
#import "PSSenderSendFarpRequest.h"
@implementation PSSenderOrderViewModel



#pragma mark -数据处理
-(PSSenderOrderModel *)ps_getSenderOrderModelAtIndex:(NSInteger)index{
    
    if (index>= self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(NSString *)ps_getDeliverNoAtIndex:(NSInteger)index{
    
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    return [NSString stringWithFormat:@"订单号：%@",senderOrderModel.order_info.order_code];
}
-(NSString *)ps_getDeliverOrderTimeAtIndex:(NSInteger)index{
    
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    return [NSString stringWithFormat:@"订单时间：%@",senderOrderModel.order_info.shopping_time];
}

-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index{
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    return senderOrderModel.order_info.pic_url;
}

-(NSString *)ps_getBucketTypeAtIndex:(NSInteger)index{
    
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    NSString *string = [NSString stringWithFormat:@"%@ x %@",senderOrderModel.order_info.bucket_type,senderOrderModel.order_info.buy_num];
    return   string;
}
-(NSString *)ps_getPriceAtIndex:(NSInteger)index{
    
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    return [NSString stringWithFormat:@"下单价格：¥%.2lf",senderOrderModel.order_info.expect_amount.doubleValue];
}
-(NSString *)ps_getNameAtIndex:(NSInteger)index{
    
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    if (self.listType == SenderListTypeHome) {
        return [NSString stringWithFormat:@"收货联系人：%@",senderOrderModel.order_info.consignee];
    }else{
        return [NSString stringWithFormat:@"加油站联系人：%@",senderOrderModel.order_info.farp_manager_name];
    }
}
-(NSString *)ps_getCarNumAtIndex:(NSInteger)index{
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
 
    NSArray *carInfo = senderOrderModel.order_info.car_info;
    NSMutableString *content = [NSMutableString string];
    for (int i = 0; i<carInfo.count; i++) {
        if (i == 0) {
            [content appendString:carInfo[i]];
        }else{
            [content appendFormat:@",%@",carInfo[i]];
        }
    }
    return content;
}

-(NSMutableAttributedString *)ps_getIsDebtAtIndex:(NSInteger)index{
    
    NSString *content= [NSString stringWithFormat:@"欠款:%@",@"是"];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{
        NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:14],
        NSForegroundColorAttributeName:color_999999,
    }];
    NSRange range = [content rangeOfString:@"是"];
    if (range.location != NSNotFound) {
        [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],} range:range];
    }
    return attr;
}

-(CGFloat)ps_getNameWidthAtIndex:(NSInteger)index{
    
    NSString *str = [self ps_getNameAtIndex:index];
    
    CGFloat width = 65;
    if (![BaseVerifyUtils isNullOrSpaceStr:str]) {
        width = [str widthWithFont:[UIFont systemWEPingFangRegularOfSize:14]];
    }
    return width;
}

-(NSString *)ps_getPhoneAtIndex:(NSInteger)index{
    
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    if (self.listType == SenderListTypeHome) {
        return [NSString stringWithFormat:@"电话：%@",senderOrderModel.order_info.phone_num];
    }else{
        return [NSString stringWithFormat:@"电话：%@",senderOrderModel.order_info.farp_phone];
    }
}






//-(NSString *)ps_getIsDebtAtIndex:(NSInteger)index{
//
//    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
//
//    return [NSString stringWithFormat:@"欠款：否"];
//}

-(NSString *)ps_getAddressAtIndex:(NSInteger)index{
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    if (self.listType == SenderListTypeHome) {
        if (![BaseVerifyUtils isNullOrSpaceStr:senderOrderModel.order_info.farp_address]) {
            return [NSString stringWithFormat:@"%@",senderOrderModel.order_info.farp_address];
        }else{
            return [NSString stringWithFormat:@"%@",senderOrderModel.order_info.rec_complete_address];
        }
    }else{
        return [NSString stringWithFormat:@"加油站地址：%@",senderOrderModel.order_info.farp_address];
    }
    
}





-(NSString *)ps_getwarHouseStatusAtIndex:(NSInteger)index{
    
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    return [self getStatusWithInteger:senderOrderModel.wh_verify_info.wh_verify_state];
}
-(UIColor *)ps_getwarHouseStatusColorAtIndex:(NSInteger)index{
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    return [self getStatusColorWithInteger:senderOrderModel.wh_verify_info.wh_verify_state];
    
}
-(NSString *)ps_getFinalStatusAtIndex:(NSInteger)index{
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    return [self getStatusWithInteger:senderOrderModel.wh_verify_info.wh_verify_state];
}
-(UIColor *)ps_getFinalStatusColorAtIndex:(NSInteger)index{
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    return [self getStatusColorWithInteger:senderOrderModel.wh_verify_info.wh_verify_state];
    
}
-(NSString *)ps_getBossStatusAtIndex:(NSInteger)index{
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    return [self getStatusWithInteger:senderOrderModel.wh_verify_info.wh_verify_state];
}
-(UIColor *)ps_getBossStatusColorAtIndex:(NSInteger)index{
    
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];

    return [self getStatusColorWithInteger:senderOrderModel.wh_verify_info.wh_verify_state];
}

-(void)ps_removeDataIndex:(NSInteger)index{
    
    if (index <self.dataSource.count) {
        [self.dataSource removeObjectAtIndex:index];
    }
}

-(NSString *)getStatusWithInteger:(NSInteger)integer{
    if (integer == 2) {
        return @"审核未通过";
    }else if (integer == 1){
        return @"审核通过";
    }else{
        return @" 审核中";
    }
}
-(UIColor *)getStatusColorWithInteger:(NSInteger)integer{
    if (integer == 2) {
        return color_FF5C29;
    }else if (integer == 1){
        return color_4084FF;
    }else{
        return color_333333;
    }
}

-(void)requestOrderListWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete{
   
    if (self.listType== SenderListTypeStation) {
        PSSenderStationOrderListRequest *listReqeust = [PSSenderStationOrderListRequest new];
        if (page != 1 && self.dataSource.count>0) {
            PSSenderOrderModel *lastModel = self.dataSource.lastObject;
            listReqeust.shopping_time = lastModel.order_info.shopping_time;
        }
        [listReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                
                NSArray *data = [PSOrderModel convertModelWithJsonArr:response.result[@"order_info"]];
                
                NSMutableArray *arr = [NSMutableArray array];
                for (int i = 0; i<data.count; i++) {
                    PSSenderOrderModel *senderModel = [PSSenderOrderModel new];
                    senderModel.order_info = data[i];
                    [arr addObject:senderModel];
                }
                if (page == 1) {
                    [self.dataSource setArray:arr];
                }else{
                    [self.dataSource addObjectsFromArray:arr];
                }
                complete(YES,data);
            }else{
                complete(NO,@[]);
            }
        }];
    }else{
        PSSenderOrderListRequest *listReqeust = [PSSenderOrderListRequest new];
        listReqeust.order_type = 1;
        if (page != 1 && self.dataSource.count>0) {
            PSSenderOrderModel *lastModel = self.dataSource.lastObject;
            listReqeust.order_time = lastModel.order_info.shopping_time;
        }
        [listReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
            if (response.isFinished) {
                
                NSArray *data = [PSSenderOrderModel convertModelWithJsonArr:response.result[@"shopping_car_list"]];
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
    
}

-(void)reqeustSendOrderWithOrderIdAtIndex:(NSInteger)index complete:(completeBlock)complete{
    
    PSSenderOrderModel *senderOrderModel = [self ps_getSenderOrderModelAtIndex:index];
    PSSenderSendFarpRequest *send = [PSSenderSendFarpRequest new];
    send.order_id = @[@(senderOrderModel.order_info.order_id.integerValue)];
    [send postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
          
            complete(YES);
        }else{
            complete(NO);
        }
    }];
    
}

@end
