//
//  PSSenderDeliveryCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderDeliveryCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *label_deliverNo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UILabel *label_buckettype;
@property (weak, nonatomic) IBOutlet UILabel *label_price;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_name;
//单价
@property (weak, nonatomic) IBOutlet UILabel *label_siglePrice;

@property (weak, nonatomic) IBOutlet UILabel *label_phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *label_address;
//@property (weak, nonatomic) IBOutlet UILabel *label_driverName;
@property (weak, nonatomic) IBOutlet UIButton *btn_select;

@property (weak, nonatomic) IBOutlet UILabel *label_sendStatus;

@property (weak, nonatomic) IBOutlet UIView *view_pickOneself;
@property (weak, nonatomic) IBOutlet UILabel *label_pickOneSelfTitle;
@property (weak, nonatomic) IBOutlet UITextField *tf_pickerNum;
@property (weak, nonatomic) IBOutlet UIButton *btn_savePickerOneSelf;

//@property (nonatomic,copy) void(^goToSendClick)(void);


@property (nonatomic,copy) void(^saveClickBlock)(NSString *num);

@end

NS_ASSUME_NONNULL_END
