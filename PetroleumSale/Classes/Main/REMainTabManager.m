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
#import "UserInfoProfile.h"
#import "RELoginViewController.h"
#import "PSPhotoButton.h"




@interface REMainTabManager()<UITabBarControllerDelegate>
@property (strong, nonatomic, readwrite) PSMainTabBarVC *tabBarController;

@property (nonatomic, strong, readwrite) PSHomeVC *homeVC; // 首页
@property (nonatomic, strong, readwrite) PSDriverHomeVC *driverHomeVC; // 司机首页
@property (nonatomic, strong, readwrite) PSSenderOrderListVC *senderVC; // 派单首页
@property (nonatomic, strong, readwrite) PSSenderOrderListVC *senderStationVC; // 派单加油点

@property (nonatomic,strong,readwrite) PSPetrolStationHomeVC *petrolStationVC;//委托加油点首页
@property (nonatomic,strong,readwrite) PSSalemanHomeVC *salesmanVC;//销售员首页
@property (nonatomic,strong,readwrite) PSKeeperHomeVC *keepVC;//仓库管理员首页


@property (nonatomic, strong, readwrite) PSOrderVC *orderVC; // 订单
@property (nonatomic, strong, readwrite) PSSalesmanOrderVC *salesmanOrderVC; // 销售员订单列表

@property (nonatomic, strong, readwrite) PSKeeperOrderVC *keepOrderVC; // 仓库
@property (nonatomic, strong, readwrite) PSSenderDeleryVC *sendDeliverVC; // 派单运单列表
@property (nonatomic, strong, readwrite) PSShopCartVC *shopCartVC; //购物车
@property (nonatomic, strong, readwrite) PSPropertyVC *propertyVC; // 资产

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
        
        [self.tabBarController setUpApperance];
    }
    return self;

}


- (PSMainTabBarVC *)addKidsViewControllers {
   

    if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeDriver) {
        return [self getDriverTabbarVC];
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeSender){
        return [self getSenderTabbarVC];
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypePetrolStation){
        return [self getPetrolStattionTabbarVC];
    }else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeSalesman){
        return [self getSalesmanTabbarVC];
    }
    else if (UserInfoProfile.shareUserInfo.userInfo.userType == UserTypeKeeper){
        return [self getKeeperTabbarVC];
    }
    else{
        return [self getCustomerTabbarVC];
    }
}

-(PSMainTabBarVC *)getCustomerTabbarVC{
    
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
    
    
    PSMainTabBarVC *tabBarController = [[PSMainTabBarVC alloc] init];
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

-(PSMainTabBarVC *)getDriverTabbarVC{
    
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
    
    PSMainTabBarVC *tabBarController = [[PSMainTabBarVC alloc] initWithViewControllers:tabBarViewControllers tabBarItemsAttributes:tabBarItemsAttributes imageInsets:UIEdgeInsetsZero titlePositionAdjustment:UIOffsetZero];

    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}
-(PSMainTabBarVC *)getSenderTabbarVC{
    BaseNavViewController *nav1 = [[BaseNavViewController alloc] initWithRootViewController:self.senderVC];
    BaseNavViewController *nav2 = [[BaseNavViewController alloc] initWithRootViewController:self.senderStationVC];
    BaseNavViewController *nav3 = [[BaseNavViewController alloc] initWithRootViewController:self.sendDeliverVC];
    BaseNavViewController *nav4 = [[BaseNavViewController alloc] initWithRootViewController:self.mineVC];
    
    UIImage *image_home_u = [[UIImage imageNamed:@"hp_home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_home_s = [[UIImage imageNamed:@"hp_home_icon_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_home_refuel_u = [[UIImage imageNamed:@"hp_home_refuel_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_home_refuel_s = [[UIImage imageNamed:@"hp_home_refuel_u"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_delivery_u = [[UIImage imageNamed:@"hp_icon_waybill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_delivery_s = [[UIImage imageNamed:@"hp_icon_waybill_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_mine_u = [[UIImage imageNamed:@"hp_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_mine_s = [[UIImage imageNamed:@"hp_icon_me_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"首页",
                            CYLTabBarItemImage:image_home_u,
                            CYLTabBarItemSelectedImage:image_home_s};
    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"加油站",
                            CYLTabBarItemImage:image_home_refuel_u,
                            CYLTabBarItemSelectedImage:image_home_refuel_s};
    NSDictionary *dict3 = @{CYLTabBarItemTitle:@"运单",
                            CYLTabBarItemImage:image_delivery_u,
                            CYLTabBarItemSelectedImage:image_delivery_s};
    NSDictionary *dict4 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:image_mine_u,
                            CYLTabBarItemSelectedImage:image_mine_s};
    NSArray *tabBarItemsAttributes = @[dict1, dict2,dict3,dict4];
    NSArray *tabBarViewControllers = @[nav1, nav2,nav3,nav4];
    
    PSMainTabBarVC *tabBarController = [[PSMainTabBarVC alloc] init];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    [tabBarController setViewControllers:tabBarViewControllers];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}
-(PSMainTabBarVC *)getPetrolStattionTabbarVC{
    
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
    
    PSMainTabBarVC *tabBarController = [[PSMainTabBarVC alloc] initWithViewControllers:tabBarViewControllers tabBarItemsAttributes:tabBarItemsAttributes imageInsets:UIEdgeInsetsZero titlePositionAdjustment:UIOffsetZero];

    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}
-(PSMainTabBarVC *)getSalesmanTabbarVC{
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
    
    PSMainTabBarVC *tabBarController = [[PSMainTabBarVC alloc] init];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    [tabBarController setViewControllers:tabBarViewControllers];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}

-(PSMainTabBarVC *)getKeeperTabbarVC{
    
    BaseNavViewController *nav1 = [[BaseNavViewController alloc] initWithRootViewController:self.keepVC];
//    BaseNavViewController *nav2 = [[BaseNavViewController alloc] initWithRootViewController:self.keepOrderVC];
    BaseNavViewController *nav3 = [[BaseNavViewController alloc] initWithRootViewController:self.sendDeliverVC];
    BaseNavViewController *nav4 = [[BaseNavViewController alloc] initWithRootViewController:self.propertyVC];
    BaseNavViewController *nav5 = [[BaseNavViewController alloc] initWithRootViewController:self.mineVC];

    
    UIImage *image_home_u = [[UIImage imageNamed:@"hp_icon_stock"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_home_s = [[UIImage imageNamed:@"hp_icon_stock_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    UIImage *image_warehouse_u = [[UIImage imageNamed:@"hp_icon_warehouse"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage *image_warehouse_s = [[UIImage imageNamed:@"hp_icon_warehouse_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_shopCart_u = [[UIImage imageNamed:@"hp_icon_waybill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_shopCart_s = [[UIImage imageNamed:@"hp_icon_waybill_a"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_property_u = [[UIImage imageNamed:@"hp_icon_property"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_property_s = [[UIImage imageNamed:@"hp_icon_property_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image_mine_u = [[UIImage imageNamed:@"hp_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image_mine_s = [[UIImage imageNamed:@"hp_icon_me_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    PSMainTabBarVC *tabBarController = [[PSMainTabBarVC alloc] init];
    NSDictionary *dict1 = @{CYLTabBarItemTitle:@"进货",
                            CYLTabBarItemImage:image_home_u,
                            CYLTabBarItemSelectedImage:image_home_s};
//    NSDictionary *dict2 = @{CYLTabBarItemTitle:@"仓库",
//                            CYLTabBarItemImage:image_warehouse_u,
//                            CYLTabBarItemSelectedImage:image_warehouse_s};
    NSDictionary *dict3 = @{CYLTabBarItemTitle:@"运单",
                            CYLTabBarItemImage:image_shopCart_u,
                            CYLTabBarItemSelectedImage:image_shopCart_s};
    NSDictionary *dict4 = @{CYLTabBarItemTitle:@"资产",
                            CYLTabBarItemImage:image_property_u,
                            CYLTabBarItemSelectedImage:image_property_s};
    NSDictionary *dict5 = @{CYLTabBarItemTitle:@"我的",
                            CYLTabBarItemImage:image_mine_u,
                            CYLTabBarItemSelectedImage:image_mine_s};
    
    NSArray *tabBarItemsAttributes = @[dict1,dict3,dict4,dict5];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    [tabBarController setViewControllers:@[nav1,nav3,nav4,nav5]];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    tabBarController.delegate = self;
    return tabBarController;
}





-(void)reloadAllChildrenVC{
    [self claarAllVC];
    self.tabBarController = [self addKidsViewControllers];
    [self.tabBarController setUpApperance];
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

- (PSMainTabBarVC *)tabBarController {
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
-(PSKeeperHomeVC *)keepVC{
    if (!_keepVC) {
        _keepVC = [PSKeeperHomeVC new];
    }
    return _keepVC;
}

- (PSSenderOrderListVC *)senderVC{
    if (!_senderVC) {
        _senderVC = [[PSSenderOrderListVC alloc] initWithType:SenderListTypeHome];
    }
    return _senderVC;
}
- (PSSenderOrderListVC *)senderStationVC{
    if (!_senderStationVC) {
        _senderStationVC = [[PSSenderOrderListVC alloc] initWithType:SenderListTypeStation];
    }
    return _senderStationVC;
}

-(PSOrderVC *)orderVC{
    if (!_orderVC) {
        _orderVC = [PSOrderVC new];
    }
    return _orderVC;
}
-(PSKeeperOrderVC *)keepOrderVC{
    if (!_keepOrderVC) {
        _keepOrderVC     = [PSKeeperOrderVC new];
    }
    return _keepOrderVC;
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
-(PSPropertyVC *)propertyVC{
    if (!_propertyVC) {
        _propertyVC  = [PSPropertyVC    new];
    }
    return _propertyVC;
}

-(PSMineVC *)mineVC{
    if (!_mineVC) {
        _mineVC = [PSMineVC new];
    }
    return _mineVC;
}


@end
