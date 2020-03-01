//
//  BaseBlueNavView.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/18.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseBlueNavView.h"

@interface BaseBlueNavView ()
@property (nonatomic,strong) UIImageView *imageView_blue;
@property (nonatomic,strong) UILabel *label_title;
@end
@implementation BaseBlueNavView

-(void)initBaseSubViews{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imageView_blue];
    [self addSubview:self.label_title];
    
    [self.imageView_blue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SafeTop+10);
        make.left.right.equalTo(self);
    }];;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.label_title.text = title;
}

#pragma mark- lazy
-(UIImageView *)imageView_blue{
    if (!_imageView_blue) {
        _imageView_blue = [UIImageView new];
        _imageView_blue.image = [UIImage imageNamed:@"Background"];
        _imageView_blue.contentMode = UIViewContentModeScaleToFill;
        _imageView_blue.clipsToBounds = YES;
    }
    return _imageView_blue;
}

-(UILabel *)label_title{
    if (!_label_title) {
        _label_title =[ UILabel new];
        _label_title.font =[UIFont systemWEPingFangMediumFontOfSize:17];
        _label_title.textAlignment = NSTextAlignmentCenter;
        _label_title.textColor = [UIColor whiteColor];
        _label_title.text = @"石化销售平台";
    }
    return _label_title;
}

@end
