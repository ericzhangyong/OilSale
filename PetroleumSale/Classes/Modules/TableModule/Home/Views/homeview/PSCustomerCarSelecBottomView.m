//
//  PSCustomerCarSelecBottomView.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/13.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSCustomerCarSelecBottomView.h"

@interface PSCustomerCarSelecBottomView ()

@property (nonatomic,strong) UIButton *btn_confirm;
@end
@implementation PSCustomerCarSelecBottomView

-(void)initBaseSubViews{
    
    [self addSubview:self.btn_confirm];
    [self.btn_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(62);
        make.right.equalTo(self).offset(-62);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(36);
    }];
    
}


-(void)btnClick{
    
    if (self.confirmClick) {
        self.confirmClick();
    }
}


#pragma mark- layz
-(UIButton *)btn_confirm{
    if (!_btn_confirm) {
        _btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_confirm.layer.masksToBounds = YES;
        _btn_confirm.layer.cornerRadius = 18;
        [_btn_confirm setTitle:@"确定" forState:UIControlStateNormal];
        _btn_confirm.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn_confirm.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        [_btn_confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_confirm addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _btn_confirm.backgroundColor = color_4084FF;
    }
    return _btn_confirm;
}

@end
