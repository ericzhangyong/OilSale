//
//  PSOrderConfirmVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "PSShopCartViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSOrderConfirmVC : BasePullTableVC


-(instancetype)initWithShopCartViewModel:(PSShopCartViewModel *)cartViewModel;
@end

NS_ASSUME_NONNULL_END
