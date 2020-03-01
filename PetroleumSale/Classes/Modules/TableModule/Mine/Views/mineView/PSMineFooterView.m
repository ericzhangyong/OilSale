//
//  PSMineFooterView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMineFooterView.h"

@interface PSMineFooterView ()

@property (nonatomic,strong) UIButton  *btn_outLogin;
@end
@implementation PSMineFooterView


-(void)initBaseSubViews{
    
    
    [self addSubview:self.btn_outLogin];
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.label_notice];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.btn_outLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    [self.label_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn_outLogin.mas_bottom).offset(30);
        make.left.right.equalTo(self);
    }];
}

-(void)outLogin{
    
    if (self.outLoginClick) {
        self.outLoginClick(YES);
    }
}


#pragma mark- lazy

-(UILabel *)label_notice{
    if (!_label_notice) {
        _label_notice = [UILabel new];
        NSString *content = @"售后服务：021-123456";
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:14],NSForegroundColorAttributeName:color_999999}];
        NSRange range = [content rangeOfString:@"021-123456"];
        if (range.location != NSNotFound) {
            [attr addAttribute:NSForegroundColorAttributeName value:color_4084FF range:range];
        }
        _label_notice.attributedText = attr;
        _label_notice.textAlignment = NSTextAlignmentCenter;
    }
    return _label_notice;
}

-(UIButton *)btn_outLogin{
    if (!_btn_outLogin) {
        _btn_outLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_outLogin setTitle:@"退出登录" forState:UIControlStateNormal];
        [_btn_outLogin setTitleColor:color_666666 forState:UIControlStateNormal];
        _btn_outLogin.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        _btn_outLogin.backgroundColor = [UIColor whiteColor];
        _btn_outLogin.layer.masksToBounds = YES;
        _btn_outLogin.layer.cornerRadius = 4;
        [_btn_outLogin addTarget:self action:@selector(outLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_outLogin;
}
@end
