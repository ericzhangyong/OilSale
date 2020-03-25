//
//  PSOrdelListCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSOrdelListCell.h"

@implementation PSOrdelListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = color_lightDart_f3f3f3;
    self.view_contain.layer.masksToBounds = YES;
    self.view_contain.layer.cornerRadius = 4;
    
    self.btn_left.layer.borderColor = color_979797.CGColor;
    self.btn_left.layer.borderWidth= 1;
    self.btn_left.layer.masksToBounds = YES;
    self.btn_left.layer.cornerRadius = 15;
    [self.btn_left setTitleColor:color_979797 forState:UIControlStateNormal];
    
    self.btn_right.layer.borderColor = color_4084FF.CGColor;
    self.btn_right.layer.borderWidth= 1;
    self.btn_right.layer.masksToBounds = YES;
    self.btn_right.layer.cornerRadius = 15;
    [self.btn_right setTitleColor:color_4084FF forState:UIControlStateNormal];
    
    self.btn_checkPic.layer.borderColor = color_4084FF.CGColor;
    self.btn_checkPic.layer.borderWidth= 1;
    self.btn_checkPic.layer.masksToBounds = YES;
    self.btn_checkPic.layer.cornerRadius = 15;
    [self.btn_checkPic setTitleColor:color_4084FF forState:UIControlStateNormal];
       
    
    
    [self.btn_checkPic addTarget:self action:@selector(btn_checkPicClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)btn_checkPicClicked{
    
    if (self.btn_checkPicClick) {
        self.btn_checkPicClick();
    }
}

@end
