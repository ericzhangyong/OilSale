//
//  PSPropertyBottomBarView.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSPropertyBottomBarView.h"

@interface PSPropertyBottomBarView ()

@property (nonatomic,strong) UIButton *btn_handle;
@property (nonatomic,strong) UIButton *btn_new;
@property (nonatomic,strong) UIButton *btn_collect;

@end
@implementation PSPropertyBottomBarView


-(void)initBaseSubViews{
    
    
    [self addSubview:self.btn_handle];
    [self addSubview:self.btn_new];
    [self addSubview:self.btn_collect];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnWidth = (kScreenWidth-26*2-20*2)/3.0;
    [self.btn_handle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(26);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(35);
        make.centerY.equalTo(self);
    }];
    [self.btn_new mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn_handle.mas_right).offset(20);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(35);
        make.centerY.equalTo(self);
    }];
    [self.btn_collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btn_new.mas_right).offset(20);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(35);
        make.centerY.equalTo(self);
    }];
}

-(void)btnHandleClick{
    if (self.btnClickCallBack) {
        self.btnClickCallBack(1);
    }
}
-(void)btnNewClick{
    if (self.btnClickCallBack) {
        self.btnClickCallBack(2);
    }
}
-(void)btnCollectClick{
    if (self.btnClickCallBack) {
        self.btnClickCallBack(3);
    }
}


#pragma mark- lazy
-(UIButton *)btn_handle{
    if (!_btn_handle) {
        _btn_handle = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_handle setTitle:@"处理资产" forState:UIControlStateNormal];
        [_btn_handle setTitleColor:color_4084FF forState:UIControlStateNormal];
        _btn_handle.layer.cornerRadius = 17.25;
        _btn_handle.layer.masksToBounds = YES;
        _btn_handle.layer.borderColor = color_4084FF.CGColor;
        _btn_handle.layer.borderWidth = 1;
        _btn_handle.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        [_btn_handle addTarget:self action:@selector(btnHandleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_handle;
}
-(UIButton *)btn_new{
    if (!_btn_new) {
        _btn_new = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_new setTitle:@"新增资产" forState:UIControlStateNormal];
        [_btn_new setTitleColor:color_4084FF forState:UIControlStateNormal];
        _btn_new.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        _btn_new.layer.cornerRadius = 17.25;
        _btn_new.layer.masksToBounds = YES;
        _btn_new.layer.borderColor = color_4084FF.CGColor;
        _btn_new.layer.borderWidth = 1;
        [_btn_new addTarget:self action:@selector(btnNewClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_new;
}
-(UIButton *)btn_collect{
    if (!_btn_collect) {
        _btn_collect = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_collect setTitle:@"回收资产" forState:UIControlStateNormal];
        _btn_collect.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        [_btn_collect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_collect.backgroundColor = color_4084FF;
        _btn_collect.layer.cornerRadius = 17.25;
        _btn_collect.layer.masksToBounds = YES;
        _btn_collect.layer.borderColor = color_4084FF.CGColor;
        _btn_collect.layer.borderWidth = 1;
        [_btn_collect addTarget:self action:@selector(btnCollectClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_collect;
}


@end
