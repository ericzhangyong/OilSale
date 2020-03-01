//
//  PSCustomerCarNumEditBottomView.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/13.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSCustomerCarNumEditBottomView : BaseView


@property (nonatomic,copy) void(^bottomBtnClick)(NSInteger clickType);


@end

NS_ASSUME_NONNULL_END
