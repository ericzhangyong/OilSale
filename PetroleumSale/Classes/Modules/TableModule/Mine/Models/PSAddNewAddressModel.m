//
//  FSAddNewAddressModel.m
//  FireStore
//
//  Created by eric on 2019/8/31.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSAddNewAddressModel.h"

@implementation PSAddNewAddressModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"title":@[@"title",@"label"],
             @"content":@[@"edit_text_value",@"content"]
             
    };
}



@end
