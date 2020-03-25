//
//  PSStationSearchView.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/12.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSStationSearchView.h"


@interface PSStationSearchView()

@property (nonatomic,strong) UIView *view_contain;
@property (nonatomic,strong) UIImageView *imageView_icon;
@property (nonatomic,strong) UITextField *tf_search;


@end
@implementation PSStationSearchView

-(void)initBaseSubViews{
    
    
    [self addSubview:self.view_contain];
    [self.view_contain addSubview:self.imageView_icon];
    [self.view_contain addSubview:self.tf_search];
    
    
    [self.tf_search addTarget:self action:@selector(valueChaged:) forControlEvents:UIControlEventEditingChanged];
    
}

-(void)valueChaged:(UITextField *)tf{
    
    if (self.textfieldDidChange) {
        self.textfieldDidChange(tf.text);
    }
}


-(NSString *)getTextFieldText{
    return self.tf_search.text;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.view_contain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 15, 10, 15));
    }];
    
    [self.imageView_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_contain).offset(20);
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self.view_contain);
    }];
    
    [self.tf_search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView_icon.mas_right).offset(15);
        make.right.equalTo(self.view_contain.mas_right).offset(-15);
        make.centerY.equalTo(self.view_contain);
    }];
}




#pragma mark- layz

-(UIView *)view_contain{
    if (!_view_contain) {
        _view_contain = [UIView new];
        _view_contain.backgroundColor = color_lightDart_333333;
        _view_contain.layer.masksToBounds = YES;
        _view_contain.layer.cornerRadius = 20;
    }
    return _view_contain;
}

-(UIImageView *)imageView_icon{
    if (!_imageView_icon) {
        _imageView_icon = [UIImageView new];
        _imageView_icon.image = [UIImage imageNamed:@"hp_top_search_icon"];
    }
    return _imageView_icon;
}

-(UITextField *)tf_search{
    if (!_tf_search ) {
        _tf_search = [[UITextField alloc] init];
        _tf_search.placeholder = @"输入要搜索的车牌号";
        _tf_search.font = [UIFont systemWEPingFangRegularOfSize:14];
    }
    return _tf_search;
}


@end
