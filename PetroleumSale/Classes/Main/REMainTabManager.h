//
//  REMainTabManager.h
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CYLTabBarController.h"
#import "PSHomeVC.h"
#import "PSOrderVC.h"
#import "PSShopCartVC.h"
#import "PSMineVC.h"
#import "PSDriverHomeVC.h"
#import "PSSenderOrderListVC.h"
#import "PSSenderDeleryVC.h"
#import "PSPetrolStationHomeVC.h"
#import "PSSalemanHomeVC.h"
#import "PSSalesmanOrderVC.h"
#import "PSMainTabBarVC.h"
#import "PSKeeperHomeVC.h"
#import "PSKeeperOrderVC.h"
#import "PSPropertyVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface REMainTabManager : NSObject

+ (instancetype)sharedManager;



@property (strong, nonatomic, readonly) PSMainTabBarVC *tabBarController;

@property (nonatomic, strong, readonly) PSHomeVC *homeVC; // 首页
@property (nonatomic, strong, readonly) PSDriverHomeVC *driverHomeVC; // 司机首页
@property (nonatomic,strong,readonly) PSSenderOrderListVC *senderVC;//派单首页
@property (nonatomic,strong,readonly) PSPetrolStationHomeVC *petrolStationVC;//委托加油点首页
@property (nonatomic,strong,readonly) PSSalemanHomeVC *salesmanVC;//销售员首页
@property (nonatomic,strong,readonly) PSKeeperHomeVC *keepVC;//仓库管理员首页



@property (nonatomic, strong, readonly) PSOrderVC *orderVC; // 订单
@property (nonatomic, strong, readonly) PSSenderDeleryVC *sendDeliverVC; // 派单运单列表
@property (nonatomic, strong, readonly) PSSalesmanOrderVC *salesmanOrderVC; // 销售员订单列表
@property (nonatomic, strong, readonly) PSKeeperOrderVC *keepOrderVC; // 订单
@property (nonatomic, strong, readonly) PSShopCartVC *shopCartVC; // 购物车
@property (nonatomic, strong, readonly) PSPropertyVC *propertyVC; // 资产


@property (nonatomic, strong, readonly) PSMineVC *mineVC; // 我的


//更新版本
-(void)chectOutNewVersion;

//重新加载tabbarVC的子控制器
-(void)reloadAllChildrenVC;

@end

NS_ASSUME_NONNULL_END
