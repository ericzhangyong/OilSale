//
//  PSNewCarNumVC.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/13.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSNewCarNumVC : BaseViewController


@property (nonatomic,copy) void(^createCarNumComplete)(NSString *car_info_id);
@end

NS_ASSUME_NONNULL_END
