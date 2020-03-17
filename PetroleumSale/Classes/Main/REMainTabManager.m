//
//  REMainTabManager.m
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "REMainTabManager.h"
#import "BaseNavViewController.h"
#import "UIImage+BaseImageCategory.h"
#import "UIImage+BaseImageCategory.h"
#import "UserInfoProfile.h"
#import "RELoginViewController.h"
#import "PSPhotoButton.h"



@interface REMainTabManager()<UITabBarControllerDelegate>
@property (strong, nonatomic, readwrite) CYLTabBarController *tabBarController;

@property (nonatomic, strong, readwrite) PSHomeVC *homeVC; // 首页
@property (nonatomic, strong, readwrite) PSDriverHomeVC *driverHomeVC; // 司机首页
@property (nonatomic, strong, readwrite) PSSenderOrderListVC *senderVC; // 派单首页
@property (nonatomic,strong,readwrite) PSPetrolStationHomeVC *petrolStationVC;//委托加油点首页
@property (nonatomic,strong,readwrite) PSSalemanHomeVC *salesmanVC;//销售员首页

@property (nonatomic, strong, readwrite) PSOrderVC *orderVC; // 订单
@property (nonatomic, strong, readwrite) PSSalesmanOrderVC *salesmanOrderVC; // 销售员订单列表

@property (nonatomic, strong, readwrite) PSSenderDeleryVC *sendDeliverVC; // 派单运单列表
@property (nonatomic, strong, readwrite) PSShopCartVC *shopCartVC; //购物车
@property (nonatomic, strong, readwrite) PSMineVC *mineVC; // 我的

@end
@implementation REMainTabManager


+ (instancetype)sharedManager{
    static REMainTabManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[REMainTabManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupApperance];
    }
    return self;

}
- (void)setupApperance {
    
//    [PSPhotoButton registerPlusButton];

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
        tabBarAppearance.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
        tabBarAppearance.shadowColor = color_EFEFEF;
        self.tabBarController.tabBar.standardAppearance = tabBarAppearance;
    }

}



- (CYLTabBarController *)addKidsViewControllers {
   
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeDriver) {
        return [self getDriverTabbarVC];
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeSender){
        return [self getSenderTabbarVC];
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypePetrolStation){
        return [self getPetrolStattionTabbarVC];
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeSalesman){
        return [self getSalesmanTabbarVC];
    }
    else{
        return [self getCustomerTabbarVC];
    }
}

-(CYLTabBarController *)getCustomerTabbarVC{
    
    BaseNavViewController *nav1 = [[BaseNavViewController alloc] initWithRootViewController:self.homeVC];
    BaseNavViewController *nav2 = [[BaseNavViewController alloc] initWithRootViewController:self.orderVC];
    BaseNavViewController *nav3 = [[BaseNavViewController alloc] initWithRootViewController:self.shopCartVC];
    BaseNavViewController *nav4 = [[BaseNavViewController alloc] initWithRootViewController:self.mineVC];
    
    UIImage *image_home_u = [[UIImage imageNamed:@"hp_home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_home_s = [[UIImage imageNamed:@"hp_home_icon_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_order_u = [[UIImage imageNamed:@"hp_icon_order"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_order_s = [[UIImage imageNamed:@"hp_icon_order_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_shopCart_u = [[UIImage imageNamed:@"hp_icon_shopcar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_shopCart_s = [[UIImage imageNamed:@"hp_icon_shopcar_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_mine_u = [[UIImage imageNamed:@"hp_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_mine_s = [[UIImage imageNamed:@"hp_icon_me_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"首页",
                            CYLTabBarItemImage:image_home_u,
                            CYLTabBarItemSelectedImage:image_home_s};
    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"订单",
                            CYLTabBarItemImage:image_order_u,
                            CYLTabBarItemSelectedImage:image_order_s};
    NSDictionary *dict3 = @{CYLTabBarItemTitle:@"购物车",
                            CYLTabBarItemImage:image_shopCart_u,
                            CYLTabBarItemSelectedImage:image_shopCart_s};
    NSDictionary *dict4 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:image_mine_u,
                            CYLTabBarItemSelectedImage:image_mine_s};
    
    
    NSArray *tabBarItemsAttributes = @[dict1, dict2,dict3,dict4];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    [tabBarController setViewControllers:@[nav1, nav2,nav3,nav4]];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}

-(CYLTabBarController *)getDriverTabbarVC{
    
    [PSPhotoButton registerPlusButton];

    BaseNavViewController *nav1 = [[BaseNavViewController alloc] initWithRootViewController:self.driverHomeVC];
    BaseNavViewController *nav2 = [[BaseNavViewController alloc] initWithRootViewController:self.mineVC];
    
    
    UIImage *image_home_u = [[UIImage imageNamed:@"hp_home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_home_s = [[UIImage imageNamed:@"hp_home_icon_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIImage *image_mine_u = [[UIImage imageNamed:@"hp_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
       UIImage *image_mine_s = [[UIImage imageNamed:@"hp_icon_me_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"首页",
                            CYLTabBarItemImage:image_home_u,
                            CYLTabBarItemSelectedImage:image_home_s};
    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:image_mine_u,
                            CYLTabBarItemSelectedImage:image_mine_s};
    NSArray *tabBarItemsAttributes = @[dict1, dict2];
    NSArray *tabBarViewControllers = @[nav1, nav2];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] initWithViewControllers:tabBarViewControllers tabBarItemsAttributes:tabBarItemsAttributes imageInsets:UIEdgeInsetsZero titlePositionAdjustment:UIOffsetZero];

    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}
-(CYLTabBarController *)getSenderTabbarVC{
    BaseNavViewController *nav1 = [[BaseNavViewController alloc] initWithRootViewController:self.senderVC];
    BaseNavViewController *nav2 = [[BaseNavViewController alloc] initWithRootViewController:self.sendDeliverVC];
    BaseNavViewController *nav3 = [[BaseNavViewController alloc] initWithRootViewController:self.mineVC];
    
    
    UIImage *image_home_u = [[UIImage imageNamed:@"hp_home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_home_s = [[UIImage imageNamed:@"hp_home_icon_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_delivery_u = [[UIImage imageNamed:@"hp_icon_waybill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_delivery_s = [[UIImage imageNamed:@"hp_icon_waybill_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_mine_u = [[UIImage imageNamed:@"hp_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_mine_s = [[UIImage imageNamed:@"hp_icon_me_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"首页",
                            CYLTabBarItemImage:image_home_u,
                            CYLTabBarItemSelectedImage:image_home_s};
    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"运单",
                            CYLTabBarItemImage:image_delivery_u,
                            CYLTabBarItemSelectedImage:image_delivery_s};
    NSDictionary *dict3 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:image_mine_u,
                            CYLTabBarItemSelectedImage:image_mine_s};
    NSArray *tabBarItemsAttributes = @[dict1, dict2,dict3];
    NSArray *tabBarViewControllers = @[nav1, nav2,nav3];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    [tabBarController setViewControllers:tabBarViewControllers];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}
-(CYLTabBarController *)getPetrolStattionTabbarVC{
    
    [PSPhotoButton registerPlusButton];

    
    BaseNavViewController *nav1 = [[BaseNavViewController alloc] initWithRootViewController:self.petrolStationVC];
    BaseNavViewController *nav2 = [[BaseNavViewController alloc] initWithRootViewController:self.mineVC];
    
    
    UIImage *image_home_u = [[UIImage imageNamed:@"hp_home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_home_s = [[UIImage imageNamed:@"hp_home_icon_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIImage *image_mine_u = [[UIImage imageNamed:@"hp_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
       UIImage *image_mine_s = [[UIImage imageNamed:@"hp_icon_me_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"首页",
                            CYLTabBarItemImage:image_home_u,
                            CYLTabBarItemSelectedImage:image_home_s};
    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:image_mine_u,
                            CYLTabBarItemSelectedImage:image_mine_s};
    NSArray *tabBarItemsAttributes = @[dict1, dict2];
    NSArray *tabBarViewControllers = @[nav1, nav2];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] initWithViewControllers:tabBarViewControllers tabBarItemsAttributes:tabBarItemsAttributes imageInsets:UIEdgeInsetsZero titlePositionAdjustment:UIOffsetZero];

    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}
-(CYLTabBarController *)getSalesmanTabbarVC{
    BaseNavViewController *nav1 = [[BaseNavViewController alloc] initWithRootViewController:self.salesmanVC];
    BaseNavViewController *nav2 = [[BaseNavViewController alloc] initWithRootViewController:self.salesmanOrderVC];
    BaseNavViewController *nav3 = [[BaseNavViewController alloc] initWithRootViewController:self.mineVC];
    
    UIImage *image_home_u = [[UIImage imageNamed:@"hp_home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_home_s = [[UIImage imageNamed:@"hp_home_icon_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_delivery_u = [[UIImage imageNamed:@"hp_icon_waybill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_delivery_s = [[UIImage imageNamed:@"hp_icon_waybill_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_mine_u = [[UIImage imageNamed:@"hp_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_mine_s = [[UIImage imageNamed:@"hp_icon_me_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"首页",
                            CYLTabBarItemImage:image_home_u,
                            CYLTabBarItemSelectedImage:image_home_s};
    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"订单",
                            CYLTabBarItemImage:image_delivery_u,
                            CYLTabBarItemSelectedImage:image_delivery_s};
    NSDictionary *dict3 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:image_mine_u,
                            CYLTabBarItemSelectedImage:image_mine_s};
    NSArray *tabBarItemsAttributes = @[dict1, dict2,dict3];
    NSArray *tabBarViewControllers = @[nav1, nav2,nav3];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    [tabBarController setViewControllers:tabBarViewControllers];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}


-(void)reloadAllChildrenVC{
    [self claarAllVC];
    self.tabBarController = [self addKidsViewControllers];
    UIApplication.sharedApplication.delegate.window.rootViewController = self.tabBarController;
}
-(void)claarAllVC{
    self.homeVC = nil;
    self.driverHomeVC  = nil;
    self.senderVC = nil;
    self.sendDeliverVC  = nil;
    self.mineVC = nil;
    self.orderVC = nil;
    self.shopCartVC = nil;
    self.petrolStationVC = nil;
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [_tabBarController updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeDriver) {
        
    }else{//客户模式
        if (tabBarController.selectedIndex != 0 ) {
               if ([UserInfoProfile shareUserInfo].userInfo == nil || UserInfoProfile.shareUserInfo.userInfo.isLogined == NO) {
                   tabBarController.selectedIndex = 0;
                   [RELoginViewController presentLoginWithLoginType:RELoginTypeSecretCode];
               }
           }
    }
   
}


-(void)chectOutNewVersion{
    

}


#pragma mark- lazy

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [self addKidsViewControllers];
    }
    return _tabBarController;
}

-(PSHomeVC *)homeVC{
    if (!_homeVC) {
        _homeVC = [PSHomeVC new];
    }
    return _homeVC;
}
-(PSDriverHomeVC *)driverHomeVC{
    if (!_driverHomeVC) {
        _driverHomeVC = [PSDriverHomeVC new];
    }
    return _driverHomeVC;
}
-(PSPetrolStationHomeVC *)petrolStationVC{
    if (!_petrolStationVC) {
        _petrolStationVC = [[PSPetrolStationHomeVC alloc] init];
    }
    return _petrolStationVC;
}
-(PSSalemanHomeVC *)salesmanVC{
    if (!_salesmanVC) {
        _salesmanVC = [PSSalemanHomeVC new];
    }
    return _salesmanVC;
}

- (PSSenderOrderListVC *)senderVC{
    if (!_senderVC) {
        _senderVC = [[PSSenderOrderListVC alloc] init];
    }
    return _senderVC;
}
-(PSOrderVC *)orderVC{
    if (!_orderVC) {
        _orderVC = [PSOrderVC new];
    }
    return _orderVC;
}

-(PSSenderDeleryVC *)sendDeliverVC{
    if (!_sendDeliverVC) {
        _sendDeliverVC = [[PSSenderDeleryVC alloc] init];
    }
    return _sendDeliverVC;
}

-(PSSalesmanOrderVC *)salesmanOrderVC{
    if (!_salesmanOrderVC) {
        _salesmanOrderVC = [PSSalesmanOrderVC new];
    }
    return _salesmanOrderVC;
}
-(PSShopCartVC *)shopCartVC{
    if (!_shopCartVC) {
        _shopCartVC = [[PSShopCartVC alloc] init];
    }
    return _shopCartVC;
}

-(PSMineVC *)mineVC{
    if (!_mineVC) {
        _mineVC = [PSMineVC new];
    }
    return _mineVC;
}




@end
