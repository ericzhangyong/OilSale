//
//  PSDeliveryCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/13.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSDeliveryCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *label_deliverNo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_deliverNo;

@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_address;
@property (weak, nonatomic) IBOutlet UIButton *btn_select;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_btnSelect;


@property (nonatomic,copy) void(^btnDidSelecBlock)(BOOL isSelected);


@end

NS_ASSUME_NONNULL_END
