//
//  PSOrderConfirmSuccessView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSOrderConfirmSuccessView.h"

@interface PSOrderConfirmSuccessView ()

@property (nonatomic,strong) UIView *view_background;
@property (nonatomic,strong) UIView *view_contain;
@property (nonatomic,strong) UIImageView *imageView_background;
@property (nonatomic,strong) UILabel *label_notice;
@property (nonatomic,strong) UIButton *btn_close;
@property (nonatomic,strong) UIButton *btn_checkOrder;
@end
@implementation PSOrderConfirmSuccessView

-(void)initBaseSubViews{
    
    [self addSubview:self.view_background];
    [self addSubview:self.view_contain];
    [self.view_contain addSubview:self.imageView_background];
    [self.view_contain addSubview:self.label_notice];
    [self.view_contain addSubview:self.btn_checkOrder];
    [self.view_contain addSubview:self.btn_close];
    
    [self.view_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [self.view_contain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(438);
    }];
    
    [self.imageView_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view_contain);
        make.height.mas_equalTo(338);
    }];
    
    [self.label_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_contain).offset(197);
        make.left.right.equalTo(self.view_contain);
    }];
    [self.btn_checkOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_notice.mas_bottom).offset(30);
        make.width.mas_equalTo(230);
        make.height.mas_equalTo(45);
        make.centerX.equalTo(self.view_contain);
    }];
    
    [self.btn_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView_background.mas_bottom).offset(60);
        make.width.height.mas_equalTo(36);
        make.centerX.equalTo(self.view_contain);
    }];
    
}

#pragma mark- btnClick
-(void)btnCloseClick{
    
    if (self.confirmClick) {
        self.confirmClick(2);
    }
}

-(void)btnCheckClick{
    
    if (self.confirmClick) {
        self.confirmClick(1);
    }
}

#pragma mark- lazy
-(UIView *)view_contain{
    if (!_view_contain) {
        _view_contain = [UIView new];
    }
    return _view_contain;
}

-(UIImageView *)imageView_background{
    if (!_imageView_background) {
        _imageView_background = [UIImageView new];
        _imageView_background.image = [UIImage imageNamed:@"pop_img_success"];
    }
    return _imageView_background;
}
-(UIButton *)btn_close{
    if (!_btn_close) {
        _btn_close =[UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_close setImage:[UIImage imageNamed:@"pop_icon_close"] forState:UIControlStateNormal];
        [_btn_close addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_close;
}
-(UILabel *)label_notice{
    if (!_label_notice) {
        _label_notice = [UILabel new];
        _label_notice.textColor = color_333333;
        _label_notice.font = [UIFont systemWEPingFangBoldFontOfSize:25];
        _label_notice.text = @"恭喜你下单成功";
        _label_notice.textAlignment = NSTextAlignmentCenter;
    }
    return _label_notice;
}
-(UIButton *)btn_checkOrder{
    if (!_btn_checkOrder) {
        _btn_checkOrder =[UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_checkOrder setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_btn_checkOrder addTarget:self action:@selector(btnCheckClick) forControlEvents:UIControlEventTouchUpInside];
        [_btn_checkOrder setTitle:@"查看订单" forState:UIControlStateNormal];
        [_btn_checkOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_checkOrder.backgroundColor = color_4084FF;
        _btn_checkOrder.layer.masksToBounds = YES;
        _btn_checkOrder.layer.cornerRadius = 22.5;
        
    }
    return _btn_checkOrder;
}
-(UIView *)view_background{
    if (!_view_background) {
        _view_background = [UIView new];
        _view_background.backgroundColor = [UIColor blackColor];
        _view_background.alpha = 0.7;
    }
    return _view_background;
}

@end
