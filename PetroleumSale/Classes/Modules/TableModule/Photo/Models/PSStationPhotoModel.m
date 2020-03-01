//
//  PSStationPhotoModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSStationPhotoModel.h"

@implementation PSStationPhotoModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"farp_car_info":[PSStationCarModel class]};
}

@end

