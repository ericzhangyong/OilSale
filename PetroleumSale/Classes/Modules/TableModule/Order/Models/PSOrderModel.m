//
//  PSOrderModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSOrderModel.h"

@implementation PSOrderModel


+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"pic_list":[PSOrderImageModel class]};
}



@end


@implementation PSOrderImageModel



@end
