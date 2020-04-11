//
//  PSDropMenuView.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSDropMenuView : BaseView



/// 需要显示的内容
@property (nonatomic,strong) UIView *contentView;
/// 显示内容的vc
@property (nonatomic,strong) UIViewController *contentVC;

- (void)showDropUpViewFromParentView:(UIView *)view SuperView:(UIView *)superView;

- (void)hideDropUpView;

@end

NS_ASSUME_NONNULL_END
