//
//  PSOrderPicVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/7.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "PSOrderViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSOrderPicVC : BasePullTableVC

-(instancetype)initWithOrderViewModel:(PSOrderViewModel *)orderViewModel orderIndex:(NSInteger)orderIndex;


@end

NS_ASSUME_NONNULL_END
