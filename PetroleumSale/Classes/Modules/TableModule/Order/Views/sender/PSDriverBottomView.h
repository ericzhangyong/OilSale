//
//  PSDriverBottomView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSDriverBottomView : BaseView


@property (nonatomic,copy) void(^goToSendDidClick)(void);

@property (nonatomic,copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
