//
//  PSReseveConfirmFooterView.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSReseveConfirmFooterView.h"

@implementation PSReseveConfirmFooterView


- (IBAction)actionSelectStatie:(UIButton *)sender {

    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
}

- (IBAction)actionAggreementClick:(id)sender {
    if (self.footBtnDidClick) {
        self.footBtnDidClick(1);
    }
}

- (IBAction)actionConfrimClick:(UIButton *)sender {
    
    if (self.footBtnDidClick) {
        self.footBtnDidClick(2);
    }
}

@end
