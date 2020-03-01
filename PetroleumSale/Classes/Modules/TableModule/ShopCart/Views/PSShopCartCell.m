//
//  PSShopCartCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSShopCartCell.h"

@implementation PSShopCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
   
    self.control_select.selected = isSelected;
    if (self.control_select.selected) {
        self.imageView_select.image = [UIImage imageNamed:@"shoppingcart_choose_a"];
    }else{
        self.imageView_select.image = [UIImage imageNamed:@"shoppingcart_choose"];
    }
    
}
- (IBAction)actionSelect:(UIControl *)sender {
    
    sender.selected = !sender.selected;
    if (self.selectBlock) {
        self.selectBlock(sender.selected);
    }
}

@end
