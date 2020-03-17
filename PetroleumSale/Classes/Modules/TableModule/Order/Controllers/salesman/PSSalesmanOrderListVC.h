//
//  PSSalesmanOrderListVC.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "PSSalesmanOrderViewModel.h"
#import "ZJScrollPageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSSalesmanOrderListVC : BasePullTableVC<ZJScrollPageViewChildVcDelegate>


-(instancetype)initWithListType:(PSSalesmanOrderListType)listType;


@end

NS_ASSUME_NONNULL_END
