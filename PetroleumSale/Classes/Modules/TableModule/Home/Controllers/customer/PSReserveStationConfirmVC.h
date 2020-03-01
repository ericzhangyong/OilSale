//
//  PSStationReserveConfirmVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "PSStationModel.h"
#import "PSStationCarModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSReserveStationConfirmVC : BasePullTableVC

-(instancetype)initWithCarNumArr:(NSArray *)carNumArr
                    stationModel:(PSStationModel *)stationModel;


@end

NS_ASSUME_NONNULL_END
