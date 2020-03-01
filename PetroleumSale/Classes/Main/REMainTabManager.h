//
//  REMainTabManager.h
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTabBarController.h"
#import "PSHomeVC.h"
#import "PSOrderVC.h"
#import "PSShopCartVC.h"
#import "PSMineVC.h"
#import "PSDriverHomeVC.h"
#import "PSSenderOrderListVC.h"
#import "PSSenderDeleryVC.h"
#import "PSPetrolStationHomeVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface REMainTabManager : NSObject

+ (instancetype)sharedManager;



@property (strong, nonatomic, readonly) CYLTabBarController *tabBarController;

@property (nonatomic, strong, readonly) PSHomeVC *homeVC; // 首页
@property (nonatomic, strong, readonly) PSDriverHomeVC *driverHomeVC; // 司机首页
@property (nonatomic,strong,readonly) PSSenderOrderListVC *senderVC;//派单首页
@property (nonatomic,strong,readonly) PSPetrolStationHomeVC *petrolStationVC;//委托加油点首页


@property (nonatomic, strong, readonly) PSOrderVC *orderVC; // 订单
@property (nonatomic, strong, readonly) PSSenderDeleryVC *sendDeliverVC; // 派单运单列表
@property (nonatomic, strong, readonly) PSShopCartVC *shopCartVC; // 购物车
@property (nonatomic, strong, readonly) PSMineVC *mineVC; // 我的


//更新版本
-(void)chectOutNewVersion;

//重新加载tabbarVC的子控制器
-(void)reloadAllChildrenVC;

@end

NS_ASSUME_NONNULL_END
