//
//  FSAddresReceiveModel.m
//  FireStore
//
//  Created by eric on 2019/9/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSAddresReceiveModel.h"

@implementation PSAddresReceiveModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    
    return @{@"addressId":@[@"id",@"addressId"]};
}
@end
