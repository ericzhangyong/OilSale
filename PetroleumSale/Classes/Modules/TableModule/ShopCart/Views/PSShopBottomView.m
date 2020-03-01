//
//  PSShopBottomView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSShopBottomView.h"

@interface PSShopBottomView ()
@property (nonatomic,strong) UIButton *btn_All;
@property (nonatomic,strong) UILabel *label_totalMoney;
@end
@implementation PSShopBottomView

-(void)initBaseSubViews{
    
    
    [self addSubview:self.btn_All];
    [self addSubview:self.btn_confirm];
    [self addSubview:self.label_totalMoney];
    
    
    [self.btn_All mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.height.mas_offset(25);
        make.width.mas_equalTo(56);
    }];
    
    [self.btn_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(93);
    }];
    
    [self.label_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn_All.mas_right).offset(10);
        make.right.equalTo(self.btn_confirm.mas_left).offset(-15);
        make.centerY.equalTo(self);
    }];
    
    [self.btn_All addTarget:self action:@selector(allCick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_confirm addTarget:self action:@selector(confirmCick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setIsSelectAll:(BOOL)isSelectAll{
    _isSelectAll = isSelectAll;
    self.btn_All.selected = isSelectAll;
}

-(void)setMonyeStr:(NSMutableAttributedString *)monyeStr{
    
    self.label_totalMoney.attributedText = monyeStr;
}

-(void)setEditType:(PSShopCartEidtType)editType{
    _editType = editType;
    
    if (editType == PSShopCartEidtTypeEidt) {
        self.label_totalMoney.hidden = YES;
        self.btn_confirm.backgroundColor = color_EE5455;
        [self.btn_confirm setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        self.label_totalMoney.hidden = NO;
        self.btn_confirm.backgroundColor = color_FFB115;
        [self.btn_confirm setTitle:@"确认购买" forState:UIControlStateNormal];
    }
}
#pragma mark- click
-(void)allCick:(UIButton *)button{
    
    button.selected = !button.selected;
    if (self.didClick) {
        self.didClick(1);
    }
}

-(void)confirmCick:(UIButton *)button{
    
    if (self.editType == PSShopCartEidtTypeDefault) {
        if (self.didClick) {
            self.didClick(2);
        }
    }else{
        if (self.didClick) {
            self.didClick(3);
        }
    }
    
}



#pragma mark- lazy
-(UIButton *)btn_All{
    if (!_btn_All) {
        _btn_All = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_All setTitle:@"全选" forState:UIControlStateNormal];
        _btn_All.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        [_btn_All setTitleColor:color_666666 forState:UIControlStateNormal];
        [_btn_All setTitleColor:color_4084FF forState:UIControlStateSelected];
        [_btn_All setImage:[UIImage imageNamed:@"shoppingcart_choose"] forState:UIControlStateNormal];
        [_btn_All setImage:[UIImage imageNamed:@"shoppingcart_choose_a"] forState:UIControlStateSelected];
        _btn_All.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    }
    return _btn_All;
}

-(UILabel *)label_totalMoney{
    if (!_label_totalMoney) {
        _label_totalMoney = [UILabel new];
    }
    return _label_totalMoney;
}

-(UIButton *)btn_confirm{
    if (!_btn_confirm) {
        _btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_confirm.backgroundColor = color_FFB115;
        [_btn_confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_confirm.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        _btn_confirm.layer.cornerRadius = 17.5;
        _btn_confirm.layer.masksToBounds = YES;
    }
    return _btn_confirm;
}
@end
