//
//  PSPhotoOilGunCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSPhotoOilGunCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *tf_oilGunCount;



@property (nonatomic,copy) void(^oidCountDidChanged)(NSString *value);

@end

NS_ASSUME_NONNULL_END
