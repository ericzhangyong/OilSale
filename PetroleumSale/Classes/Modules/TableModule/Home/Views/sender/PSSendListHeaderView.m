//
//  PSSendListHeaderView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSendListHeaderView.h"

@interface PSSendListHeaderView ()

@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UIImageView *imageView_background;

@end
@implementation PSSendListHeaderView

-(void)initBaseSubViews{
    
    [self addSubview:self.imageView_background];
    [self.imageView_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    [self addSubview:self.label_title];
    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self.mas_bottom).offset(-22);
    }];
}

#pragma mark- lazy

-(UIImageView *)imageView_background{
    if (!_imageView_background) {
        _imageView_background = [UIImageView new];
        _imageView_background.image = [UIImage imageNamed:@"Background"];
        _imageView_background.contentMode = UIViewContentModeScaleAspectFill;
        _imageView_background.clipsToBounds = YES;
    }
    return _imageView_background;
}

-(UILabel *)label_title{
    if (!_label_title) {
        _label_title = [UILabel new];
        _label_title.textColor  = [UIColor whiteColor];
        _label_title.font = [UIFont systemWEPingFangMediumFontOfSize:17];
        _label_title.textAlignment = NSTextAlignmentCenter;
        _label_title.text = @"订单";
    }
    
    return _label_title;
}

@end
