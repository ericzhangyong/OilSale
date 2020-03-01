//
//  PSSpecBtn.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/27.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSpecBtn.h"

@interface PSSpecBtn()

@property (nonatomic,strong) UILabel *label_line;
@end
@implementation PSSpecBtn


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.label_line];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [self.label_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(2);
        make.centerX.equalTo(self);
    }];
    
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.label_line.hidden = !selected;
}

-(UILabel *)label_line{
    if (!_label_line) {
        _label_line = [UILabel new];
        _label_line.backgroundColor = color_4084FF;
    }
    return _label_line;
}


@end
