//
//  PSPetrolOrderViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSPetrolOrderViewModel.h"
#import "PSStationOrderListRequest.h"
#import "PSStationOrderModel.h"

@implementation PSPetrolOrderViewModel

-(PSStationOrderModel *)ps_getStationModelAtIndex:(NSInteger)index{
    if (index>=self.dataSource.count) {
        return nil;
    }
    return self.dataSource[index];
}


-(NSString *)ps_getStationOrderCodeAtIndex:(NSInteger)index{
    
    PSStationOrderModel *stationModel = [self ps_getStationModelAtIndex:index];
    return [NSString stringWithFormat:@"加油单号：%@",stationModel.farp_order_info.order_code];
}

-(NSString *)ps_getStationorderImageAtIndex:(NSInteger)index{
    PSStationOrderModel *stationModel = [self ps_getStationModelAtIndex:index];
    return stationModel.farp_order_info.oil_pic_url;
}
-(NSString *)ps_getStationOrderCarNumAtIndex:(NSInteger)index{
    
    PSStationOrderModel *stationModel = [self ps_getStationModelAtIndex:index];
    return [NSString stringWithFormat:@"车辆信息：%@",stationModel.farp_car_info.car_number];
}
-(NSString *)ps_getStationOrderTimeAtIndex:(NSInteger)index{
    PSStationOrderModel *stationModel = [self ps_getStationModelAtIndex:index];

    return [NSString stringWithFormat:@"加油时间：%@",stationModel.farp_order_info.order_time];
}
-(NSString *)ps_getStationOrderAddressAtIndex:(NSInteger)index{

    PSStationOrderModel *stationModel = [self ps_getStationModelAtIndex:index];
    return [NSString stringWithFormat:@"加油站地址：%@%@",stationModel.req_farp_addr_edit_model.region,stationModel.req_farp_addr_edit_model.complete_address];
}
-(NSString *)ps_getStationOrderVolumeAtIndex:(NSInteger)index{
    
    PSStationOrderModel *stationModel = [self ps_getStationModelAtIndex:index];
    return [NSString stringWithFormat:@"加油升数：%@升",stationModel.farp_order_info.oil_volume_num];
}
-(NSString *)ps_getStationOrderPicAtIndex:(NSInteger)index row:(NSInteger)row{
    
    PSStationOrderModel *stationModel = [self ps_getStationModelAtIndex:index];
    if (row>=stationModel.farp_order_info.oil_photo_do_pic_urls.count) {
        return @"";
    }
    return stationModel.farp_order_info.oil_photo_do_pic_urls[row];
}
-(CGFloat)ps_getStationOrderCellHeight{
    if (self.listType == PSStationOrderListTypeHistory) {
        return 310;
    }else{
        return 148;
    }
}
-(BOOL)ps_getIsShowBottomPic{
    if (self.listType == PSStationOrderListTypeHistory) {
        return YES;
    }else{
        return NO;
    }

}
#pragma mark- 数据接口
-(void)requestDataWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete{
    
    
    PSStationOrderListRequest *stationORderLIst  = [PSStationOrderListRequest new];
    if (page != 1) {
        PSStationOrderModel *lastModel = self.dataSource.lastObject;
        stationORderLIst.order_time = lastModel.farp_order_info.order_time;
    }
    stationORderLIst.order_type = self.listType == PSStationOrderListTypeCurrent?1:3;
    [stationORderLIst postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            NSArray *data = [PSStationOrderModel convertModelWithJsonArr:response.result[@"farp_order_list"]];
            if (page == 1) {
                [self.dataSource setArray:data];
            }else{
                [self.dataSource addObjectsFromArray:data];
            }
            complete(YES,data);
        }else{
            complete(YES,@[]);
        }
    }];
}


@end
