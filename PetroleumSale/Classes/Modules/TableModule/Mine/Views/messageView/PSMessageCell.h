//
//  PSMessageCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_upDown;
@property (weak, nonatomic) IBOutlet UILabel *label_time;

@property (weak, nonatomic) IBOutlet UIImageView *imageView_dot;
@property (weak, nonatomic) IBOutlet UILabel *label_content;


@property (nonatomic,copy) PSMessageModel *messageModel;

@property (nonatomic,copy) void(^btnUpDownClick)(BOOL isSelected);

@end

NS_ASSUME_NONNULL_END
