//
//  PSMineMessageCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSMineMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView_icon;

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWith_labelContent;

@end

NS_ASSUME_NONNULL_END
