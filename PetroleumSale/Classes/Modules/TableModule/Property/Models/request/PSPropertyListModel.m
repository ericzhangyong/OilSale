//
//  PSPropertyListModel.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSPropertyListModel.h"

@implementation PSPropertyListModel


+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
        @"irc_num":@[@"irc_num",@"ibc_num"]
    };
}


@end
