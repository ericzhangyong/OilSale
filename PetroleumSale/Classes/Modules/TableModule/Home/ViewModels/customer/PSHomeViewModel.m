//
//  PSHomeViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSHomeViewModel.h"
#import "PSHomeModel.h"
#import "PSHomeRequest.h"
#import "NSString+RECategory.h"
#import "PSAddShopCartRequest.h"
#import "BaseVerifyUtils.h"
#import "NSString+RECategory.h"

@implementation PSHomeViewModel



-(CGFloat)ps_getHeaderHeight{
    
    CGFloat bannerHeight = self.ps_getBannerHeight;
    CGFloat todayPriceHeight = 30;
    CGFloat announcementHeight= 10+30+10;
    CGFloat noticeHeight = self.ps_getNoticeHeight+20+20;
    return bannerHeight + todayPriceHeight+announcementHeight+noticeHeight;
}

-(CGFloat)ps_getNoticeHeight{
    CGFloat noticeHeight = 0;
    if (![BaseVerifyUtils isNullOrSpaceStr:self.homeModel.buy_notice]) {
        noticeHeight = [self.homeModel.buy_notice heightWithFont:[UIFont systemWEPingFangRegularOfSize:12] width:kScreenWidth-50]+10;
    }
    return noticeHeight;
}

-(CGFloat)ps_getBannerHeight{
    CGFloat bannerHeight = kScreenWidth*200.0/375 -20 +SafeTop;
    return bannerHeight;
}

/// 获取桶类型标题数组
-(NSArray *)ps_getBucket_typeTitleArr{
    
    if (self.homeModel.product_list.count) {
        NSArray *titleArr = [self.homeModel.product_list valueForKey:@"bucket_type"];
        return titleArr;
    }else{
        return @[];
    }
}

-(PSProductModel *)ps_getProductModelAtSection:(NSInteger)section Index:(NSInteger)index{
    if (section>=self.dataSource.count) {
        return nil;
    }
    NSArray *data = self.dataSource[section];
    
    if (index>=data.count) {
        return nil;
    }
    PSProductModel *model = data[index];
    return model;
}

-(NSString *)ps_getTitleAtSection:(NSInteger)section Index:(NSInteger)index{
    
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    return [NSString stringWithFormat:@"%@(%@)",productModel.bucket_type,productModel.bucket_desc];
}
-(NSString *)ps_getUnitTypeAtSection:(NSInteger)section
                               Index:(NSInteger)index{
    
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    return [NSString stringWithFormat:@"%@",productModel.unit_type];
}

-(NSString *)ps_getImageUrlAtSection:(NSInteger)section Index:(NSInteger)index{
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    return productModel.bucket_pic;
}
-(NSMutableAttributedString *)ps_getPriceAtSection:(NSInteger)section Index:(NSInteger)index{
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    
    
    NSString *price =  productModel.tax_include_price;
    NSString *unitType = @"升";
    if (section ==1) {
        unitType = @"吨";
        price = productModel.unit_price;
        if (![BaseVerifyUtils isNullOrSpaceStr:productModel.unit_price]&& productModel.notContainTaxOrDeliver) {
            price = [NSString stringWithFormat:@"%.2f",productModel.unit_price.doubleValue+productModel.distribution_fee.doubleValue];
        }
        if ([BaseVerifyUtils isNumber:price]) {
            price  = [NSString stringWithFormat:@"%.2f",price.doubleValue * productModel.bucket_volume.integerValue];
        }
    }else{
        unitType = @"桶";
        if (![BaseVerifyUtils isNullOrSpaceStr:productModel.tax_include_price]&& productModel.notContainTaxOrDeliver) {
            price = productModel.tax_exclude_price;
        }
//        if ([BaseVerifyUtils isNumber:price]) {
            price  = [NSString stringWithFormat:@"%.2f",price.doubleValue * productModel.bucket_volume.integerValue];
//        }
    }
    
    
    
    
    NSString *content = [NSString stringWithFormat:@"¥%@/%@",price,unitType];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemWEPingFangMediumFontOfSize:16],NSForegroundColorAttributeName:color_333333}];
    NSArray *dotArr = [price componentsSeparatedByString:@"."];
    if (dotArr.count>0) {
        NSRange dotRange = [content rangeOfString:dotArr[0]];
        [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangMediumFontOfSize:25]} range:dotRange];
    }
    return attr;
}
-(NSString *)ps_getLeftBtnContentAtSection:(NSInteger)section index:(NSInteger)index{

    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    if (section == 0) {
        NSString *containTax = [NSString stringWithFormat:@"含税¥%@/升",productModel.tax_include_price];
        return containTax;
    }else{
        return @"自提";
    }
}
-(CGFloat)ps_getLeftBtnWidthAtSection:(NSInteger)section index:(NSInteger)index{
    
    NSString *str= [self ps_getLeftBtnContentAtSection:section index:index];
    CGFloat width = [str widthWithFont:[UIFont systemWEPingFangRegularOfSize:12]];
    if (width<90) {
        width = 90;
    }
    return width+30;
    
}
-(BOOL)ps_getLeftBtnIsSelectedAtSection:(NSInteger)section index:(NSInteger)index{
    
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    return !productModel.notContainTaxOrDeliver;
}
-(void)ps_setLeftBtnIsSelectedAtSection:(NSInteger)section index:(NSInteger)index withState:(BOOL)isSelect{
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    productModel.notContainTaxOrDeliver = !isSelect;
}
-(NSString *)ps_getRightBtnContentAtSection:(NSInteger)section index:(NSInteger)index{
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    if (section == 0) {
        if (![BaseVerifyUtils isNullOrSpaceStr:productModel.tax_exclude_price]) {
            NSString *containTax = [NSString stringWithFormat:@"不含税¥%@/升",productModel.tax_exclude_price];
            return containTax;
        }else{
            return @"不含税";
        }
    }else{
        if ([BaseVerifyUtils isNullOrSpaceStr:productModel.distribution_fee]) {
            return @"配送 +0";
        }
        return [NSString stringWithFormat:@"配送 +%@",productModel.distribution_fee];
    }
}
-(CGFloat)ps_getRightBtnWidthAtSection:(NSInteger)section index:(NSInteger)index{
    
    NSString *str= [self ps_getRightBtnContentAtSection:section index:index];
    CGFloat width = [str widthWithFont:[UIFont systemWEPingFangRegularOfSize:12]];
    if (width<90) {
        width = 90;
    }
    return width+30;
}
-(BOOL)ps_getRightBtnIsSelectedAtSection:(NSInteger)section index:(NSInteger)index{
    
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    return productModel.notContainTaxOrDeliver;
}
-(void)ps_setRightBtnIsSelectedAtSection:(NSInteger)section index:(NSInteger)index withState:(BOOL)isSelect{
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];
    productModel.notContainTaxOrDeliver = isSelect;
}
-(BOOL)ps_getRightBtnEnabledAtSection:(NSInteger)section index:(NSInteger)index{
    
    PSProductModel *productModel = [self ps_getProductModelAtSection:section Index:index];

    if (section == 0 && [BaseVerifyUtils isNullOrSpaceStr:productModel.tax_exclude_price]) {
        return NO;
    }else{
        return YES;
    }
}

-(NSString *)ps_getCarPrice{
    
    NSString *carPrice = [NSString stringWithFormat:@"按车批发 ¥%.2f",self.homeModel.oil_price_car_whole_sale.oil_price.doubleValue];
    return carPrice;
}

#pragma mark- 委托加油点
-(NSArray *)ps_getFarpListArr{
    
    return self.homeModel.farp_product.farp_car_list;
}
-(NSArray *)ps_getFarpListFarpAddressArr{
    return self.homeModel.farp_product.farp_addr_list;

}
-(NSString *)ps_getFarpAddress{
    
    for (PSStationModel *model in self.homeModel.farp_product.farp_addr_list) {
        if (model.isSelected) {
            return model.farp_name;
        }
    }
    return @"";
}
-(PSStationModel *)ps_getSelectFarpModel{
    for (PSStationModel *model in self.homeModel.farp_product.farp_addr_list) {
        if (model.isSelected) {
            return model;
        }
    }
    return nil;
}
-(NSString *)ps_getSelectFarpAddressName{
    for (PSStationModel *model in self.homeModel.farp_product.farp_addr_list) {
        if (model.isSelected) {
            return model.farp_name;
        }
    }
    return @"";
}
-(NSString *)ps_getSelectFarpAddressId{
    for (PSStationModel *model in self.homeModel.farp_product.farp_addr_list) {
           if (model.isSelected) {
               return model.farp_id;
           }
       }
       return @"";
}
-(NSString *)ps_getFarpStationPrice{
    
    NSString *farpPrice = [NSString stringWithFormat:@"%@",self.homeModel.farp_product.farp_oil_price];
    return farpPrice;
}
-(void)ps_setCarListWithArr:(NSArray *)arr{
    
    self.homeModel.farp_product.farp_car_list = arr;
}

-(NSString *)ps_getFarpStationSelectCar{
    
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i<self.homeModel.farp_product.farp_car_list.count; i++) {
        PSStationCarModel *carModel = self.homeModel.farp_product.farp_car_list[i];
        if (carModel.isSelected) {
            if (string.length == 0) {
                [string appendString:carModel.car_number];
            }else{
                [string appendFormat:@",%@",carModel.car_number];
            }
        }
    }
    return  (NSString *)string;
}

-(NSArray *)ps_getFarpStationSelectCarArr{
    
    NSMutableArray *arr = @[].mutableCopy;
    for (PSStationCarModel *model in self.homeModel.farp_product.farp_car_list) {
        if (model.isSelected) {
            [arr addObject:model];
        }
    }
    return arr;
}
-(void)ps_setFarpStationWithFarp_id:(NSString *)farp_id{
    
    for (PSStationModel *model in self.homeModel.farp_product.farp_addr_list) {
        if ([model.farp_id isEqualToString:farp_id]) {
            model.isSelected = YES;
        }else{
            model.isSelected = NO;
        }
    }
}



#pragma mark- 接口

-(void)requestHomeDataListComplete:(completeBlock)complete{
    
    PSHomeRequest *homeRequest =[PSHomeRequest new];
    [homeRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            PSHomeModel *model = [PSHomeModel convertModelWithJsonDic:response.result];
            self.homeModel= model;
            
            if (self.dataSource.count>0) {
                [self.dataSource removeAllObjects];
            }
            if (self.homeModel.product_list.count>0) {
                [self.dataSource addObject:self.homeModel.product_list];
            }
            
            if (self.homeModel.car_product_list.count>0) {
                [self.dataSource addObject:self.homeModel.car_product_list];
            }
            
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}

-(void)requestAddShopCartAtSection:(NSInteger)section
                             Index:(NSInteger)index
                            buyNum:(NSString *)buyNum
                          Complete:(completeBlock)complete{
    PSProductModel *model = [self ps_getProductModelAtSection:section Index:index];
    PSAddShopCartRequest *addShopCart = [PSAddShopCartRequest new];
    addShopCart.bucket_type_id = model.bucket_type_id.integerValue;
    addShopCart.buy_num = buyNum.integerValue;
    if (buyNum.integerValue == 0) {
        addShopCart.buy_num = 1;
    }
    if (section == 1) {//车下单
        addShopCart.product_type = @"car";
        addShopCart.distribution_state = !model.notContainTaxOrDeliver;
    }else{//桶下单
        addShopCart.product_type = @"bucket";
        addShopCart.tax_include_state = !model.notContainTaxOrDeliver;
    }
    [addShopCart postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            [MBProgressHUD toastMessageAtMiddle:@"添加购物车成功"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:FSNotificationAddShopCartSuccesKey object:nil];
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}

@end
