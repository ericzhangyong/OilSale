//
//  PSSalesmanHomeCell.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSSalesmanHomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_registTime;
@property (weak, nonatomic) IBOutlet UILabel *label_lastTime;
@property (weak, nonatomic) IBOutlet UILabel *label_status;

@property (weak, nonatomic) IBOutlet UIButton *btn_visit;


/// block
@property (nonatomic,copy) void(^clickBlock)(BOOL isVisit);
@end

NS_ASSUME_NONNULL_END
