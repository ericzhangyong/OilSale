//
//  PSConfirmHeaderView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSConfirmHeaderView.h"

@implementation PSConfirmHeaderView








- (IBAction)actionSelectAdd:(UIControl *)sender {

    if (self.selectAddBlock) {
        self.selectAddBlock(YES);
    }
}


@end
