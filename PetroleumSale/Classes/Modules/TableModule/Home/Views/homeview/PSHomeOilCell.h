//
//  PSHomeOilCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/29.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSAddShopCartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSHomeOilCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_price;
@property (weak, nonatomic) IBOutlet UIButton *btn_containTax;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_containTax;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_notConatinTax;


@property (weak, nonatomic) IBOutlet UIButton *btn_notContainTax;



@property (weak, nonatomic) IBOutlet PSAddShopCartView *view_addShopCart;
@property (nonatomic,copy) void(^addShopCartClick)(BOOL isClick,NSString *buyNum);

@property (nonatomic,copy) void(^bottomBtnClick)(BOOL isLeftBtn,BOOL isSelected);



@end

NS_ASSUME_NONNULL_END
