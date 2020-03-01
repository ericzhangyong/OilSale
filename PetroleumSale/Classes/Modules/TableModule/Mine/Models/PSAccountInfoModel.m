//
//  PSAccountInfoModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSAccountInfoModel.h"

@implementation PSAccountInfoModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
        @"bill_list":[PSAccountBillModel class]
    };
}

@end

@implementation PSAccountBillModel



@end
