//
//  PSKeepOrderCell.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSKeepOrderCell.h"

@implementation PSKeepOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    self.btn_left.layer.borderColor = color_FF5C29.CGColor;
    self.btn_left.layer.borderWidth = 1;
    self.btn_left.layer.masksToBounds = YES;
    self.btn_left.layer.cornerRadius = 18;
    [self.btn_left setTitleColor:color_FF5C29 forState:UIControlStateNormal];

    

    self.btn_right.layer.masksToBounds = YES;
    self.btn_right.layer.cornerRadius = 18;
}

- (IBAction)actionBtnLeftClick:(UIButton *)sender {
    
    if (self.btnClick) {
        self.btnClick(1);
    }

}
- (IBAction)actionBtnRightClick:(UIButton *)sender {
    if (self.btnClick) {
        self.btnClick(2);
    }

}

@end
