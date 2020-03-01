//
//  PSOrdelListCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSOrdelListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_contain;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UILabel *label_tax;

@property (weak, nonatomic) IBOutlet UILabel *label_title;

@property (weak, nonatomic) IBOutlet UILabel *label_orderTime;

@property (weak, nonatomic) IBOutlet UILabel *label_oidCount;
@property (weak, nonatomic) IBOutlet UILabel *label_price;

@property (weak, nonatomic) IBOutlet UILabel *label_orderStauts;
@property (weak, nonatomic) IBOutlet UILabel *label_address;


@property (weak, nonatomic) IBOutlet UIView *view_btns;
@property (weak, nonatomic) IBOutlet UIButton *btn_left;
@property (weak, nonatomic) IBOutlet UIButton *btn_right;

@property (weak, nonatomic) IBOutlet UIButton *btn_checkPic;


@property (nonatomic,copy) void(^btn_checkPicClick)(void);


@end

NS_ASSUME_NONNULL_END
