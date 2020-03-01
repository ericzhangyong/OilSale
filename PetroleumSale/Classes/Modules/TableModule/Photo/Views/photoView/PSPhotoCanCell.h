//
//  PSPhotoCanCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSPhotoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSPhotoCanCell : UITableViewCell


-(void)configWithPhotoViewModel:(PSPhotoViewModel *)photoViewModel
                     OrderIndex:(NSInteger)orderIndex;

@end

NS_ASSUME_NONNULL_END
