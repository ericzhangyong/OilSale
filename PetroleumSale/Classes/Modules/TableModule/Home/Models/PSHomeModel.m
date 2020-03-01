//
//  PSHomeModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/27.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSHomeModel.h"

@implementation PSHomeModel


+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"tool_bar_list":[PSBannerModel class],
             @"product_list":[PSProductModel class],
             @"car_product_list":[PSProductModel class]
    };
}
@end

@implementation PSOilPriceModel



@end
@implementation PSProductModel



@end

@implementation PSBannerModel



@end

@implementation PSFarpProductHomeModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    
    return @{
        @"farp_car_list":[PSStationCarModel class],
        @"farp_addr_list":[PSStationModel class]
    };
}

@end


@implementation PSOidPriceCarModel



@end
