//
//  PSReserveStationViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSStationCarModel.h"
#import "PSStationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSReserveStationViewModel : BaseViewModel


@property (nonatomic,copy) NSArray *carNumArr;
@property (nonatomic,copy) PSStationModel *stationModel;


-(NSString *)ps_getCarNumAtIndex:(NSInteger)index;

-(NSString *)ps_getAddress;
-(NSString *)ps_getStationPic;

#pragma mark- 接口

-(void)requestStationReseveConfirmComplete:(completeBlock)complete;


@end


NS_ASSUME_NONNULL_END
