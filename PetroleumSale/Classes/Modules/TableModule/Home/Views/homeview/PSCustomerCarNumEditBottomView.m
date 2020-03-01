//
//  PSCustomerCarNumEditBottomView.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/13.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSCustomerCarNumEditBottomView.h"

@interface PSCustomerCarNumEditBottomView ()

@property (nonatomic,strong) UIButton *btn_newCarNum;
@property (nonatomic,strong) UIButton *btn_deleteCarNum;
@end
@implementation PSCustomerCarNumEditBottomView



-(void)initBaseSubViews{
    
    CGFloat width = (kScreenWidth-20*2-25)*0.5;
    [self addSubview:self.btn_newCarNum];
    [self.btn_newCarNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(36);
    }];
    
    [self addSubview:self.btn_deleteCarNum];
    [self.btn_deleteCarNum mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self);
       make.right.equalTo(self).offset(-20);
        make.left.equalTo(self.btn_newCarNum.mas_right).offset(25);
       make.height.mas_equalTo(36);
    }];
}


-(void)confirBtnClick{
    
    if (self.bottomBtnClick) {
        self.bottomBtnClick(1);
    }
}

-(void)deleteBtnClick{
    if (self.bottomBtnClick) {
        self.bottomBtnClick(2);
    }
}

#pragma mark- lazy


-(UIButton *)btn_newCarNum{
    if (!_btn_newCarNum) {
        _btn_newCarNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_newCarNum.layer.masksToBounds = YES;
        _btn_newCarNum.layer.cornerRadius = 18;
        [_btn_newCarNum setTitle:@"新增车牌号" forState:UIControlStateNormal];
        _btn_newCarNum.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn_newCarNum.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        [_btn_newCarNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_newCarNum addTarget:self action:@selector(confirBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _btn_newCarNum.backgroundColor = color_FFB115;
    }
    return _btn_newCarNum;
}

-(UIButton *)btn_deleteCarNum{
    if (!_btn_deleteCarNum) {
        _btn_deleteCarNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_deleteCarNum.layer.masksToBounds = YES;
        _btn_deleteCarNum.layer.cornerRadius = 18;
        [_btn_deleteCarNum setTitle:@"删除" forState:UIControlStateNormal];
        _btn_deleteCarNum.titleLabel.textAlignment = NSTextAlignmentCenter;
        _btn_deleteCarNum.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        [_btn_deleteCarNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_deleteCarNum addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _btn_deleteCarNum.backgroundColor = color_EE5455;
    }
    return _btn_deleteCarNum;
}


@end
