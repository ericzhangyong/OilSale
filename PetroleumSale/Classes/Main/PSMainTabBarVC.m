//
//  PSMainTabBarVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/24.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSMainTabBarVC.h"
#import "UIImage+BaseImageCategory.h"


@interface PSMainTabBarVC ()

@end

@implementation PSMainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)setUpApperance{
    
//    [PSPhotoButton registerPlusButton];
//    self.traitCollection.currentTraitCollection = self;

    UIColor *nColor = color_999999;
    UIColor *sColor = color_4084FF;
    NSDictionary *att  = [NSDictionary dictionaryWithObjectsAndKeys:nColor,NSForegroundColorAttributeName, nil];
    NSDictionary *att1 = [NSDictionary dictionaryWithObjectsAndKeys:sColor,NSForegroundColorAttributeName, nil];
    [[UITabBarItem appearance] setTitleTextAttributes:att forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:att1 forState:UIControlStateSelected];

    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc] init];
        tabBarAppearance.backgroundImage = [UIImage imageWithColor:color_lightDart_white_black];
        tabBarAppearance.shadowColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return color_333333;
            }else{
                return color_EFEFEF;
            }
        }];
        self.tabBar.standardAppearance = tabBarAppearance;
    }

}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
       
    [self setUpApperance];

}

@end
