//
//  PSDeliveryModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDeliveryModel.h"

@implementation PSDeliveryModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"product_info":[PSProductModel class]};
}

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"region":@[@"region",@"rec_region"],
             @"order_time":@[@"order_time",@"way_bill_time"],
             @"bucket_num":@[@"bucket_num",@"order_buy_num"],
             @"complete_address":@[@"complete_address",@"rec_complete_address"]
    };
}

@end
