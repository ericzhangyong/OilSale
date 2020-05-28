//
//  PSSenderOrderCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView_background;

@property (weak, nonatomic) IBOutlet UILabel *label_deliverNo;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UILabel *label_buckettype;
@property (weak, nonatomic) IBOutlet UILabel *label_price;
@property (weak, nonatomic) IBOutlet UILabel *label_carNum;

@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_isDebt;

@property (weak, nonatomic) IBOutlet UILabel *label_phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *label_address;
@property (weak, nonatomic) IBOutlet UILabel *label_wareHouseStauts;

@property (weak, nonatomic) IBOutlet UILabel *label_finalStatus;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutFirstWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLastWidth;



/// <#des#>
@property (nonatomic,copy) void(^confirmClick)();
@end

NS_ASSUME_NONNULL_END
