//
//  PSShopBottomView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"
#import "PSShopCartViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSShopBottomView : BaseView
@property (nonatomic,strong) UIButton *btn_confirm;

@property (nonatomic,assign) PSShopCartEidtType editType;

/// 是否全选
@property (nonatomic,assign) BOOL isSelectAll;
@property (nonatomic,copy) NSMutableAttributedString *monyeStr;

/// clickType:1-->全选  2.确认 3.删除
@property (nonatomic,copy) void(^didClick)(NSInteger clickType);

@end

NS_ASSUME_NONNULL_END
