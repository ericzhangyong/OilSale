//
//  PSMineHeaderView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMineHeaderView.h"
#import "UIView+BaseCategory.h"

@implementation PSMineHeaderView


-(void)initBaseSubViews{
    
    self.view_user.layer.cornerRadius = 5;
    self.view_user.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view_user addGestureRecognizer:tapGest];
    
    self.view_user.backgroundColor = color_lightDart_white;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.view_user zy_setShadowColor:color_333333 shadowOffset:CGSizeMake(0, 2) shadowRadius:6 shadowOpacity:0.05];
}

#pragma mark- click
-(void)tapClick{
    if (self.userClick) {
        self.userClick(YES);
    }
}


@end
