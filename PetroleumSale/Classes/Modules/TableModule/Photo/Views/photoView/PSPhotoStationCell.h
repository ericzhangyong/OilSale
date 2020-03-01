//
//  PSPhotoStationCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/6.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSPhotoViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSPhotoStationCell : UITableViewCell


-(void)configWithPhotoViewModel:(PSPhotoViewModel *)photoViewModel
                     OrderIndex:(NSInteger)orderIndex;



@end

NS_ASSUME_NONNULL_END
