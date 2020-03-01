//
//  PSPhotoButton.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/10.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPhotoButton.h"
#import "UserInfoProfile.h"
#import "PSPhotoConfirmVC.h"
#import "BaseNavViewController.h"


@interface PSPhotoButton ()
{
    CGFloat _buttonImageHeight;
}

@end
@implementation PSPhotoButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}  

+ (id)plusButton {
    PSPhotoButton *button = [PSPhotoButton buttonWithType:UIButtonTypeCustom];
    // 图片尺寸：56*56、67*66、49*48（凸出 15）
    UIImage *normalButtonImage = [UIImage imageNamed:@"hp_icon_photo"];
//    UIImage *hlightButtonImage = [UIImage imageNamed:@"hp_icon_photo_a"];
    [button setImage:normalButtonImage forState:UIControlStateNormal];
//    [button setImage:hlightButtonImage forState:UIControlStateHighlighted];
//    [button setImage:hlightButtonImage forState:UIControlStateSelected];
    // 设置背景图片
//    UIImage *normalButtonBackImage = [UIImage imageNamed:@"tabBar_post_back"];
//    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateNormal];
//    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateSelected];


    [button setTitle:@"拍照" forState:UIControlStateNormal];
//    [button setTitleColor:color_4084FF forState:UIControlStateHighlighted];
//    [button setTitleColor:color_4084FF forState:UIControlStateSelected];
    [button setTitleColor:color_999999 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightBold];
    button.frame = CGRectMake(0.0, 0.0, kScreenWidth/3.0, 49);
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
     [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)clickPublish{
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeDriver||
        UserInfoProfile.shareUserInfo.userInfo.userType == UserTypePetrolStation) {
        [PSPhotoConfirmVC presentConfirmVC];
    }
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
      
    // 控件大小,间距大小
    CGFloat const imageViewEdge   = 24;//self.bounds.size.width * 0.6;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
     
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = 6+imageViewEdge * 0.5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdge, imageViewEdge);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
      
    //title position 位置
    CGFloat const centerOfTitleLabel = CGRectGetMaxY(self.imageView.frame)+5+labelLineHeight * 0.5;
    
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}
  

#pragma mark- CYLPlusButtonSubclassing


+ (NSUInteger)indexOfPlusButtonInTabBar{
    return 1;
}

+ (BOOL)shouldSelectPlusChildViewController {
    BOOL isSelected = CYLExternPlusButton.selected;
    if (isSelected) {
//        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
    } else {
//        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
    }
    return YES;
}

//+(UIViewController *)plusChildViewController{
//    return nil;
//}
//+ (CGFloat)multiplerInCenterY {
//    return  0.3;
//}
+(CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight{
    return 0.5;
}

+(CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? - SafeBottom*0.5 : 0);//(CYL_IS_IPHONE_X ? - 6 : 4);
}
@end
