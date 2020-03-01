//
//  PSOrderPicCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/7.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSOrderViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSOrderPicCell : UITableViewCell


-(void)configWithOrderViewModel:(PSOrderViewModel *)orderViewModel
                     OrderIndex:(NSInteger)orderIndex
                            row:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END
