//
//  PSSenderDeliverListVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "ZJScrollPageView.h"
#import "PSSenderDeliverViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderDeliverListVC : BasePullTableVC<ZJScrollPageViewChildVcDelegate>

-(instancetype)initWithListType:(PSSenderDeliverListType)listType;

@end

NS_ASSUME_NONNULL_END
