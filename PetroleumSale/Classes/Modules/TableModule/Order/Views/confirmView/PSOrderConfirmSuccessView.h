//
//  PSOrderConfirmSuccessView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSOrderConfirmSuccessView : BaseView


@property (nonatomic,copy) void(^confirmClick)(NSInteger clickType);
@end

NS_ASSUME_NONNULL_END
