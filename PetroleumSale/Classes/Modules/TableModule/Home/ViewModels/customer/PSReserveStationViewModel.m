//
//  PSReserveStationViewModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSReserveStationViewModel.h"
#import "PSReserveConfirmRequest.h"

@implementation PSReserveStationViewModel


-(PSStationCarModel *)ps_getCarModelAtIndex:(NSInteger)index{
    if (index>= self.carNumArr.count) {
        return nil;
    }
    PSStationCarModel *carModel = self.carNumArr[index];
    return carModel;
}

-(NSString *)ps_getCarNumAtIndex:(NSInteger)index{
   
    PSStationCarModel *carModel = [self ps_getCarModelAtIndex:index];
    
    return [NSString stringWithFormat:@"车辆：%@",carModel.car_number];
}

-(NSString *)ps_getAddress{
    
    return [NSString stringWithFormat:@"加油站地址：%@",self.stationModel.farp_address];
}
-(NSString *)ps_getStationPic{
    return self.stationModel.farp_pic;
}


#pragma mark- 接口

-(void)requestStationReseveConfirmComplete:(completeBlock)complete{
    
    
    PSReserveConfirmRequest *confirmRequest =[PSReserveConfirmRequest new];
    NSMutableArray *carIdArray = [NSMutableArray array];
    for (PSStationCarModel *model in self.carNumArr) {
        NSString *str = model.car_info_id;
        [carIdArray addObject:@(str.integerValue)];
    }
    confirmRequest.car_info_id = carIdArray;
    confirmRequest.farp_id = self.stationModel.farp_id.integerValue;
    [confirmRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            complete(YES);
        }else{
            complete(NO);
        }
    }];
}
@end
