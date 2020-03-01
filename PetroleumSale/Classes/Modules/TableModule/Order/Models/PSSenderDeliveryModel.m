//
//  PSSenderDeliveryModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDeliveryModel.h"

@implementation PSSenderDeliveryModel


+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"driver_info":[PSDriverInfoModel class],
             @"waybill_info":[PSBillInfoModel class]
    };
}

@end

@implementation PSDriverInfoModel



@end

