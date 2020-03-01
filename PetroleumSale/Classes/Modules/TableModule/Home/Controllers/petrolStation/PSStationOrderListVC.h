//
//  PSStationOrderListVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/18.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "ZJScrollPageView.h"
#import "PSPetrolOrderViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSStationOrderListVC : BasePullTableVC<ZJScrollPageViewChildVcDelegate>


-(instancetype)initWithListType:(PSStationOrderListType)listType;

@end

NS_ASSUME_NONNULL_END
