//
//  PSPropertyListVC.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "ZJScrollPageView.h"
#import "PSPropertyViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSPropertyListVC : BasePullTableVC<ZJScrollPageViewChildVcDelegate>


-(instancetype)initWithListType:(PSPropertyListType)listType;


@end

NS_ASSUME_NONNULL_END
