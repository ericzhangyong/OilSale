//
//  PSHeadImageCell.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/5/16.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSHeadImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_icon;
@property (weak, nonatomic) IBOutlet UIButton *btn_update;

@end

NS_ASSUME_NONNULL_END
