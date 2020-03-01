//
//  BaseViewModel.m
//  RippleElephantPlatform
//
//  Created by eric on 2019/9/18.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "YYModel.h"

@implementation BaseViewModel


-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
        
    }
    return _dataSource;
}


-(id)copyWithZone:(NSZone *)zone{
    
    return  [self yy_modelCopy];
}
@end
