//
//  PSMineFooterView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSMineFooterView : BaseView
@property (nonatomic,strong) UILabel *label_notice;

@property (nonatomic,copy) void(^outLoginClick)(BOOL isClick);

@end

NS_ASSUME_NONNULL_END
