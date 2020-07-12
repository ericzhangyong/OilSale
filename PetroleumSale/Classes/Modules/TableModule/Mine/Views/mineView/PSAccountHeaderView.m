//
//  PSAccountHeaderView.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSAccountHeaderView.h"

@implementation PSAccountHeaderView




- (IBAction)aciotnClickMore:(UIControl *)sender {
    
    
    if (self.restMoreClik) {
        self.restMoreClik(YES);
    }
}


@end
