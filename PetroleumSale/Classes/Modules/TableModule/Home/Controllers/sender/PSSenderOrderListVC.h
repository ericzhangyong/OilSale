//
//  PSSenderOrderListVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "PSSenderOrderViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderOrderListVC : BasePullTableVC

-(instancetype)initWithType:(SenderListType)listType;

@end

NS_ASSUME_NONNULL_END
