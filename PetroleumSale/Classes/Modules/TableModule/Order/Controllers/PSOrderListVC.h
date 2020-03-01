//
//  PSOrderListVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "ZJScrollPageView.h"
#import "PSOrderViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSOrderListVC : BasePullTableVC<ZJScrollPageViewChildVcDelegate>

-(instancetype)initWithListType:(PSOrderListType)listType;
@end

NS_ASSUME_NONNULL_END
