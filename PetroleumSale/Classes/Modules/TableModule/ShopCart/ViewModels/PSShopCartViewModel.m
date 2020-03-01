//
//  PSShopCartViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSShopCartViewModel.h"
#import "PSShopCartListRequest.h"
#import "PSShopCartModel.h"
#import "PSShopEditRequest.h"

@implementation PSShopCartViewModel


-(void)setIsSelectAll:(BOOL)isSelectAll{
    _isSelectAll = isSelectAll;
    for (PSShopCartModel *model in self.dataSource) {
        model.isSelcted = isSelectAll;
    }
}


#pragma mark- 数据处理

-(PSShopCartModel *)ps_getOrderModelAtIndex:(NSInteger)index{
    
    if (index>= self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}

-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index{
    
    PSShopCartModel *orderModel = [self ps_getOrderModelAtIndex:index];
    return orderModel.pic_url;
}
-(NSString *)ps_getTitlelAtIndex:(NSInteger)index{
    PSShopCartModel *orderModel = [self ps_getOrderModelAtIndex:index];
       return [NSString stringWithFormat:@"%@ x %@",orderModel.bucket_type,orderModel.buy_num];
}
-(NSString *)ps_getPriceAtIndex:(NSInteger)index{
    
    PSShopCartModel *orderModel = [self ps_getOrderModelAtIndex:index];
    NSString *price = [NSString stringWithFormat:@"¥%.1lf/%@",orderModel.unit_price.doubleValue,orderModel.unit_type];
    return price;
}

-(NSMutableAttributedString *)ps_getMoneyAtIndex:(NSInteger)index{
    
    PSShopCartModel *orderModel = [self ps_getOrderModelAtIndex:index];
    NSString *money = [NSString stringWithFormat:@"预计金额：¥%.1lf",orderModel.expect_amount.doubleValue];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:money attributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:14],NSForegroundColorAttributeName:color_333333}];
    NSRange range = [money rangeOfString:@"预计金额："];
    if (range.location != NSNotFound) {
        [attr addAttributes:@{NSForegroundColorAttributeName:color_666666} range:range];
    }
    
    return attr;
}
-(NSString *)ps_getaddress{
    
    PSAddresReceiveModel *address = [PSAddresReceiveModel new];
    if (self.rec_addr_list.count>0) {
        address = self.rec_addr_list.firstObject;
    }
    NSString *addressStr =[NSString stringWithFormat:@"地址：%@%@",address.region,address.complete_address];
    return addressStr;
}
-(PSAddresReceiveModel *)ps_getAddressModel{
    PSAddresReceiveModel *address = [PSAddresReceiveModel new];
    if (self.rec_addr_list.count>0) {
        address = self.rec_addr_list.firstObject;
    }
    return address;
}
-(void)ps_setAddressModelWithModel:(PSAddresReceiveModel *)address{
    if (self.rec_addr_list.count>0) {
        PSAddresReceiveModel *addressModel  = self.rec_addr_list.firstObject;
        addressModel.rec_addr_id = address.rec_addr_id;
        addressModel.consignee = address.consignee;
        addressModel.region = address.region;
        addressModel.phone_num = address.phone_num;
        addressModel.complete_address = address.complete_address;
    }
}

-(BOOL)ps_getIsSelectedAtIndex:(NSInteger)index{
    
    PSShopCartModel *orderModel = [self ps_getOrderModelAtIndex:index];
    return orderModel.isSelcted;
}

-(void)ps_setIsSelectedAtIndex:(NSInteger)index
                   isSeleceted:(BOOL)isSelected{
    PSShopCartModel *orderModel = [self ps_getOrderModelAtIndex:index];
    orderModel.isSelcted = isSelected;
    
    
    BOOL isSelectAll = YES;
    BOOL isSelectNone = YES;
    for (PSShopCartModel *model in self.dataSource) {
        if (model.isSelcted == NO) {
            isSelectAll = NO;
        }else{
            isSelectNone = NO;
        }
    }
    if (isSelectAll) {
        self.isSelectAll = isSelectAll;
    }
   
    if (isSelectNone) {
        self.isSelectAll = NO;
    }
}


/// 获取选中的数据源
-(NSArray *)ps_getSelectedDataArr{
    NSMutableArray *data = [NSMutableArray array];
    
    for (PSShopCartModel *model in self.dataSource) {
        if (model.isSelcted) {
            [data addObject:model];
        }
    }
    return data;
}

/// 获取选中订单的总金额
-(NSMutableAttributedString *)ps_getSelectedTotalMoney{
    
    double totalMoney = 0;
    for (PSShopCartModel *model in self.dataSource) {
        totalMoney += model.expect_amount.doubleValue;
    }
    NSString *totalMoneyStr  = [NSString stringWithFormat:@"合计：¥%.2lf",totalMoney];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:totalMoneyStr attributes:@{NSForegroundColorAttributeName:color_333333,NSFontAttributeName:[UIFont systemWEPingFangBoldFontOfSize:20]}];
    NSRange hejiRange = [totalMoneyStr rangeOfString:@"合计："];
    if (hejiRange.location != NSNotFound) {
        [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:15]} range:hejiRange];
    }
    NSRange symbolRange = [totalMoneyStr rangeOfString:@"¥"];
    if (symbolRange.location != NSNotFound) {
        [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangBoldFontOfSize:15]} range:symbolRange];
    }
    NSString *money = [NSString stringWithFormat:@"%.2lf",totalMoney];
    NSArray *dotArr = [money componentsSeparatedByString:@"."];
    if (dotArr.count>1) {
        NSRange dotRange = [totalMoneyStr rangeOfString:dotArr[1]];
        [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangBoldFontOfSize:15]} range:dotRange];
    }
    
    return  attr;
}
/// 获取选中订单的总金额confrim
-(NSMutableAttributedString *)ps_getSelectedTotalMoneyAtConfirmVC{
    double totalMoney = 0;
       for (PSShopCartModel *model in self.dataSource) {
           totalMoney += model.expect_amount.doubleValue;
       }
       NSString *totalMoneyStr  = [NSString stringWithFormat:@"合计预计金额：¥%.2lf",totalMoney];
       NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:totalMoneyStr attributes:@{NSForegroundColorAttributeName:color_333333,NSFontAttributeName:[UIFont systemWEPingFangBoldFontOfSize:20]}];
       NSRange hejiRange = [totalMoneyStr rangeOfString:@"合计预计金额："];
       if (hejiRange.location != NSNotFound) {
           [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:15]} range:hejiRange];
       }
       NSRange symbolRange = [totalMoneyStr rangeOfString:@"¥"];
       if (symbolRange.location != NSNotFound) {
           [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangBoldFontOfSize:15]} range:symbolRange];
       }
       NSString *money = [NSString stringWithFormat:@"%.2lf",totalMoney];
       NSArray *dotArr = [money componentsSeparatedByString:@"."];
       if (dotArr.count>1) {
           NSRange dotRange = [totalMoneyStr rangeOfString:dotArr[1]];
           [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangBoldFontOfSize:15]} range:dotRange];
       }
       
       return  attr;
    
}

-(void)ps_removeSelectedData{
    
    NSMutableArray *tempData  = [NSMutableArray array];
    for (PSShopCartModel *model in self.dataSource) {
        if (!model.isSelcted) {
            [tempData addObject:model];
        }
    }
    [self.dataSource setArray:tempData];
}

-(PSWareHouseModel *)ps_getSelectedWareHouse{
    if (self.currentWareHouseSelectIndex>=self.warehouse_list.count) {
        return nil;
    }
    return self.warehouse_list[self.currentWareHouseSelectIndex];
}
-(NSString *)ps_getSelectedWareHouseName{
    PSWareHouseModel *wareModel =self.ps_getSelectedWareHouse;
    
    return [NSString stringWithFormat:@"%@%@",wareModel.WhAddress,wareModel.WhName];
}


#pragma mark- 接口
-(void)requestShopCartListComplete:(completeDataArrBlock)complete{
    
    
    PSShopCartListRequest *shopCartList =[PSShopCartListRequest new];
    [shopCartList postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            self.isSelectAll = NO;
            NSDictionary *dict = response.result;
            NSArray *cartListData =[PSShopCartModel convertModelWithJsonArr:dict[@"shopping_car_list"]];
            [self.dataSource setArray: cartListData];
            self.rec_addr_list  = [PSAddresReceiveModel convertModelWithJsonArr:dict[@"rec_addr_list"]];
            self.warehouse_list = [PSWareHouseModel convertModelWithJsonArr:dict[@"warehouse_list"]];
            complete(YES,cartListData);
        }else{
            complete(NO,@[]);
        }
    }];
}

-(void)requesShopCartEditType:(NSInteger)editType
                     pay_type:(NSString *)payType
                     Complete:(completeBlock)complete{
    
    PSShopEditRequest *editRequest =[PSShopEditRequest new];
    PSAddresReceiveModel *address = [PSAddresReceiveModel new];
    if (self.rec_addr_list.count>0) {
        address = self.rec_addr_list.firstObject;
    }
    editRequest.receipt_addr_id = address.rec_addr_id.integerValue;
    
    PSWareHouseModel *wareModel = [PSWareHouseModel new];
    if (self.warehouse_list.count>0) {
        wareModel = self.warehouse_list[self.currentWareHouseSelectIndex];
    }
    editRequest.warehouse_id = wareModel.Id.integerValue;
    
    NSMutableArray *data = [NSMutableArray array];
    for (PSShopCartModel *model in self.dataSource) {
        [data addObject:@(model.shopping_car_id.integerValue)];
    }
    editRequest.sub_car_id_list = data;
    editRequest.sub_type = editType == 1?@"submit":@"reset";
    if (![BaseVerifyUtils isNullOrSpaceStr:payType]) {
        editRequest.pay_type = payType;
    }
    
    [editRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            if (editType == 2) {
                [self ps_removeSelectedData];
            }
            complete(YES);
        }else{
            complete(NO);
        }
    }];

}

@end
