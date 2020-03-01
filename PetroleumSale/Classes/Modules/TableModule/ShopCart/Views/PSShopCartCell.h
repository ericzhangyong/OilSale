//
//  PSShopCartCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSShopCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIControl *control_select;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_select;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_price;
@property (weak, nonatomic) IBOutlet UILabel *label_money;


@property (nonatomic,copy) void(^selectBlock)(BOOL isSelected);

/// 是否被编辑选中
@property (nonatomic,assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
