//
//  PSDriverBottomView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDriverBottomView.h"


@interface PSDriverBottomView()

@property (nonatomic,strong) UIButton *btn_goToSend;
@end
@implementation PSDriverBottomView


-(void)initBaseSubViews{
    
    [self addSubview:self.btn_goToSend];
    [self.btn_goToSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(kScreenWidth-62*2);
    }];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self.btn_goToSend setTitle:title forState:UIControlStateNormal];
}

#pragma mark- click
-(void)goToSendClick{
    
    if (self.goToSendDidClick) {
        self.goToSendDidClick();
    }
}

#pragma mark- layz
-(UIButton *)btn_goToSend{
    if (!_btn_goToSend) {
        _btn_goToSend = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_goToSend.backgroundColor = color_4084FF;
        [_btn_goToSend setTitle:@"派单" forState:UIControlStateNormal];
        [_btn_goToSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_goToSend.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:14];
        _btn_goToSend.layer.masksToBounds = YES;
        _btn_goToSend.layer.cornerRadius = 18;
        [_btn_goToSend addTarget:self action:@selector(goToSendClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_goToSend;
}

@end
