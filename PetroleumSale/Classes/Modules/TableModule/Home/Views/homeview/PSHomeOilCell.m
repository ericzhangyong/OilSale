//
//  PSHomeOilCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/29.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSHomeOilCell.h"
#import "UIView+BaseCategory.h"

@interface PSHomeOilCell ()

@property (weak, nonatomic) IBOutlet UIView *view_contain;
@property (weak, nonatomic) IBOutlet UIView *view_tax;

@end
@implementation PSHomeOilCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = color_lightDart_white;
    self.view_tax.backgroundColor = color_lightDart_fafafa;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.view_contain zy_setShadowColor:color_E9E9E9 shadowOffset:CGSizeMake(0, 0) shadowRadius:4 shadowOpacity:0.6];
}


- (IBAction)actionAddShopCart:(UIButton *)sender {
    
    

    if (self.addShopCartClick) {
        self.view_addShopCart.isShowView_add = NO;
        self.addShopCartClick(YES,self.view_addShopCart.tf_input.text);
    }
}

- (IBAction)actionLeftBtnClick:(UIButton *)sender {
    if (sender.selected == NO){
        sender.selected = YES;
        self.btn_notContainTax.selected = NO;
        if (self.bottomBtnClick) {
            self.bottomBtnClick(YES, sender.selected);
        }
    }
    
}
- (IBAction)actionRightBtnClick:(UIButton *)sender {
    if (sender.selected == NO){
        sender.selected = YES;
        self.btn_containTax.selected = NO;
        if (self.bottomBtnClick) {
            self.bottomBtnClick(NO, sender.selected);
        }
    }
}



@end
