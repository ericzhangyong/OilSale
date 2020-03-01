//
//  PSCanListModel.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSCanListModel.h"

@implementation PSCanListModel


+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
        @"returned_record_list":[PSCanReturnModel class],
        @"wait_confirm_info":[PSCanReturnModel class]
    };
}

-(NSMutableArray<PSCanReturnModel *> *)returned_record_list{
    if (!_returned_record_list) {
        _returned_record_list = [NSMutableArray array];
    }
    return _returned_record_list;
}

@end


@implementation PSCanReturnModel


-(void)setConfirm_info_id:(NSString *)confirm_info_id{
    _confirm_info_id = confirm_info_id;
    if (![BaseVerifyUtils isNullOrSpaceStr:confirm_info_id]) {
        self.isDriverReturnType = YES;
    }else{
        self.isDriverReturnType = NO;
    }
}


@end
