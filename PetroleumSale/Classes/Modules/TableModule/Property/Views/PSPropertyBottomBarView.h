//
//  PSPropertyBottomBarView.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSPropertyBottomBarView : BaseView


/// 1.处理资产 2 新增资产 3.收回资产
@property (nonatomic,copy) void(^btnClickCallBack)(NSInteger clickType);



@end

NS_ASSUME_NONNULL_END
