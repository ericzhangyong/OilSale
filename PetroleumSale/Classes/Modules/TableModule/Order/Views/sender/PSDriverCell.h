//
//  PSDriverCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSDriverCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_select;
@property (weak, nonatomic) IBOutlet UILabel *label_driverName;
@property (weak, nonatomic) IBOutlet UILabel *label_count;



@property (nonatomic,copy) void(^selectDidClick)(BOOL isSelected);

@end

NS_ASSUME_NONNULL_END
