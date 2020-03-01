//
//  PSHomeFooterView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/27.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSHomeFooterView.h"

@interface PSHomeFooterView ()
@property (nonatomic,strong) UILabel *label_app;
@property (nonatomic,strong) UILabel *label_notice;
@property (nonatomic,strong) UIImageView *imageView_left;
@property (nonatomic,strong) UIImageView *imageView_right;
@end
@implementation PSHomeFooterView


-(void)initBaseSubViews{
    
    [self addSubview:self.label_app];
    [self addSubview:self.label_notice];
    [self addSubview:self.imageView_left];
    [self addSubview:self.imageView_right];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.label_app mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(21);
    }];
    [self.imageView_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.label_app.mas_left).offset(-5);
        make.centerY.equalTo(self.label_app);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(1);
    }];
    
    [self.imageView_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_app.mas_right).offset(5);
        make.centerY.equalTo(self.label_app);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(1);
    }];
    
    [self.label_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_app.mas_bottom).offset(4);
        make.left.right.equalTo(self);
    }];
}

#pragma mark- lazy
-(UILabel *)label_app{
    if (!_label_app) {
        _label_app = [UILabel new];
        _label_app.font =[UIFont systemWEPingFangRegularOfSize:15];
        _label_app.textAlignment = NSTextAlignmentCenter;
        _label_app.textColor = color_DCDCDC;
        _label_app.text = @"石化销售APP";
    }
    return _label_app;
}
-(UILabel *)label_notice{
    if (!_label_notice) {
        _label_notice = [UILabel new];
        _label_notice.font =[UIFont systemWEPingFangRegularOfSize:12];
        _label_notice.textAlignment = NSTextAlignmentCenter;
        _label_notice.textColor = color_DCDCDC;
        _label_notice.text = @"丰富产品 · 便捷购买 · 支付灵活";
    }
    return _label_notice;
}
-(UIImageView *)imageView_left{
    if (!_imageView_left) {
        _imageView_left =[UIImageView new];
        _imageView_left.image = [UIImage imageNamed:@"hp_line_left"];
    }
    return _imageView_left;
}
-(UIImageView *)imageView_right{
    if (!_imageView_right) {
        _imageView_right =[UIImageView new];
        _imageView_right.image = [UIImage imageNamed:@"hp_line_right"];
    }
    return _imageView_right;
}

@end
