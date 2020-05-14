//
//  PSDriverViemModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDriverViemModel.h"
#import "PSSenderDriverListRequest.h"
#import "PSSenderSendRequest.h"
#import "UserInfoProfile.h"

@implementation PSDriverViemModel

#pragma mark- 数据加工

-(PSDriverModel *)ps_getDriverModelAtIndex:(NSInteger)index{
    if (index>=self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(PSBillInfoModel *)ps_getBillInfoModelAtIndex:(NSInteger)index row:(NSInteger)row{
    PSDriverModel *driverModel = [self ps_getDriverModelAtIndex:index];
    if (row>driverModel.waybill_num.count) {
        return nil;
    }
    return driverModel.waybill_num[row];
}

-(NSInteger)ps_getSectionCountAtIndex:(NSInteger)index{
     PSDriverModel *driverModel = [self ps_getDriverModelAtIndex:index];
    return driverModel.waybill_num.count;
}
-(NSString *)ps_getOrderNoAtIndex:(NSInteger)index row:(NSInteger)row{
    
    PSBillInfoModel *billModel  = [self ps_getBillInfoModelAtIndex:index row:row];
    NSString *title = @"送货单号";
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeKeeper) {
        title = @"送货单号";
    }
    return [NSString stringWithFormat:@"%@：%@",title,billModel.WbCode];
}
-(NSString *)ps_getDriverNameAtIndex:(NSInteger)index{
    
    PSDriverModel *driverModel = [self ps_getDriverModelAtIndex:index];
    return [NSString stringWithFormat:@"司机：%@",driverModel.driver_name] ;
}

-(NSString *)ps_getDriverOrderCountAtIndex:(NSInteger)index{
    PSDriverModel *driverModel = [self ps_getDriverModelAtIndex:index];
    return [NSString stringWithFormat:@"%ld个运单",driverModel.waybill_num.count] ;
}
-(BOOL)ps_getDriverIsSelectedAtIndex:(NSInteger)index{
    PSDriverModel *driverModel = [self ps_getDriverModelAtIndex:index];
    return driverModel.isSelcted;
}
-(void)ps_setDriverIsSelectedAtIndex:(NSInteger)index isSelected:(BOOL)isSelected{
    
    for (int i = 0; i<self.dataSource.count; i++) {
        PSDriverModel *model = self.dataSource[i];
        if (index == i) {
            model.isSelcted = isSelected;
        }else{
            model.isSelcted = NO;
        }
    }
}
-(NSString *)ps_getSendTimeAtIndex:(NSInteger)index row:(NSInteger)row{
    
    PSBillInfoModel *billModel  = [self ps_getBillInfoModelAtIndex:index row:row];
    return [NSString stringWithFormat:@"送货时间：%@",billModel.WbDispatchTime];
}
-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index row:(NSInteger)row{
    
//    PSBillInfoModel *billModel  = [self ps_getBillInfoModelAtIndex:index row:row];
    return @"";
}
-(NSMutableAttributedString *)ps_getSendLastTimeAtIndex:(NSInteger)index row:(NSInteger)row{
    PSBillInfoModel *billModel  = [self ps_getBillInfoModelAtIndex:index row:row];
//       return
    
    NSString *content = [NSString stringWithFormat:@"最晚送货结束时间：%@",billModel.WbEstimateTime];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:14],NSForegroundColorAttributeName:color_666666}];
    NSRange range = [content rangeOfString:@"最晚送货结束时间："];
    if (range.location != NSNotFound) {
        [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:14],NSForegroundColorAttributeName:color_333333} range:range];
    }
    return attr;
}


#pragma mark- 接口

-(void)requestDriverListComplete:(completeBlock)complete{
    
    PSSenderDriverListRequest *listRequest = [PSSenderDriverListRequest new];
    [listRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            NSArray *data = [PSDriverModel convertModelWithJsonArr:response.result];
            [self.dataSource setArray:data];
            complete(YES);
        }else{
            
            complete(NO);
        }
    }];
}


-(void)requestSendDeliveryComplete:(completeBlock)complete{
    
    PSDriverModel *selectModel;
    
    if (self.currentDriverIndex<self.dataSource.count) {
        selectModel = self.dataSource[self.currentDriverIndex];
    }
    
    for (PSDriverModel *model in self.dataSource) {
        if (model.isSelcted) {
            selectModel = model;
        }
    }
    
    
    if (!selectModel) {
        [MBProgressHUD toastMessageAtMiddle:@"请选择司机"];
        return;
    }
    PSSenderSendRequest *sendRequest =[ PSSenderSendRequest new];
    sendRequest.driver_id = selectModel.driver_id.integerValue;
    sendRequest.way_bill_id = self.orderIdArr;
    [sendRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}

@end
