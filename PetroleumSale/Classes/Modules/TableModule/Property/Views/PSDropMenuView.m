//
//  PSDropMenuView.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSDropMenuView.h"
#import "UIView+BaseFrame.h"
typedef void(^DropUpViewClick)(NSInteger clickType);
@interface PSDropMenuView ()
//菜单栏的内容view
@property (nonatomic,strong)UIView *containerView;

@end
@implementation PSDropMenuView

-(void)setContentVC:(UIViewController *)contentVC{
    
    _contentVC = contentVC;
    self.contentView = contentVC.view;
}

-(void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    
    [self addSubview:self.containerView];
    
    //调整内容的位置
    contentView.x=0;
    contentView.y=0;
    //
    //    //设置菜单的尺寸
    self.containerView.height=CGRectGetMaxY(contentView.frame)+10;
    self.containerView.width=CGRectGetMaxX(contentView.frame)+10;
    [self.containerView addSubview:_contentView];
    self.contentView.backgroundColor = color_lightDart_f3f3f3;
    
}


- (void)showDropUpViewFromParentView:(UIView *)fromView SuperView:(UIView *)superView{

//    if (superView == nil) {
    UIWindow *window =UIApplication.sharedApplication.windows.lastObject;
        superView = window;
//    }
    [superView addSubview:self];
    self.frame = superView.bounds;
    //调整灰色图片的位置
    //转换坐标
    CGRect newFrame=[fromView convertRect:fromView.bounds toView:superView];
    self.containerView.y=CGRectGetMaxY(newFrame)+10;
    self.containerView.centerX=CGRectGetMidX(newFrame)-50;

}

- (void)hideDropUpView{
    if (self.hiddenBlock) {
        self.hiddenBlock(YES);
    }
    [self removeFromSuperview];
}

-(UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
    }
    return _containerView;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    //点击返回时修改按钮的状态
//    if (_reflashBlock) {
//                _reflashBlock(NO);
//            }
//
    [self hideDropUpView];
}

@end
