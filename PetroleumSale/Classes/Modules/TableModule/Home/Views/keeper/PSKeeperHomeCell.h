//
//  PSKeeperHomeCell.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSKeeperHomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_orderNum;
@property (weak, nonatomic) IBOutlet UILabel *label_variety;
@property (weak, nonatomic) IBOutlet UILabel *label_totalWeight;
@property (weak, nonatomic) IBOutlet UILabel *label_time;

@property (weak, nonatomic) IBOutlet UILabel *label_number;
@property (weak, nonatomic) IBOutlet UILabel *label_density;
@property (weak, nonatomic) IBOutlet UILabel *label_pinxiang;

@end

NS_ASSUME_NONNULL_END
