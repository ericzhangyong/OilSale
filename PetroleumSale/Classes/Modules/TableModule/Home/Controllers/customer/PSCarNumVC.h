//
//  PSCarNumVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "PSStationCarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSCarNumVC : BasePullTableVC

-(instancetype)initWithDataArray:(NSArray<PSStationCarModel *>  *)data;



@property (nonatomic,copy) void(^selectCarNumBlock)(NSArray *dataArr);

@end

NS_ASSUME_NONNULL_END
