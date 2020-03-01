//
//  PSPetrolStationVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "PSStationModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface PSPetrolStationVC : BasePullTableVC

-(instancetype)initWithStationArr:(NSArray *)arr;


@property (nonatomic,copy) void(^selectStationBlock)(PSStationModel *stationModel,NSInteger index);

@end

NS_ASSUME_NONNULL_END
