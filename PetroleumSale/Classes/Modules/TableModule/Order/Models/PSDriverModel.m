//
//  PSDriverModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDriverModel.h"

@implementation PSDriverModel


+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"waybill_num":[PSBillInfoModel class]};
}
@end
