//
//  PSHomeHeaderView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"
#import "PSHomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSHomeHeaderView : BaseView

@property (nonatomic,copy) void(^bannerDidSelect)(NSString *webUrl);

@property (nonatomic,strong) PSHomeViewModel *homeViewModel;

@end

NS_ASSUME_NONNULL_END
