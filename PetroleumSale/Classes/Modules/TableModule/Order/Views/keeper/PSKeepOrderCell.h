//
//  PSKeepOrderCell.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSKeepOrderCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *label_orderTime;
@property (weak, nonatomic) IBOutlet UILabel *label_tieBucket;
@property (weak, nonatomic) IBOutlet UILabel *label_dunBucket;
@property (weak, nonatomic) IBOutlet UILabel *label_aggreLastBucket;
@property (weak, nonatomic) IBOutlet UILabel *label_aggreeLastDunBucket;
@property (weak, nonatomic) IBOutlet UIButton *btn_left;
@property (weak, nonatomic) IBOutlet UIButton *btn_right;


///
@property (nonatomic,copy) void(^btnClick)(NSInteger clickType);

@end

NS_ASSUME_NONNULL_END
