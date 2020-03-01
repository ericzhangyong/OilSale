//
//  PSPhotoHeaderView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,PhotoClickType){
    PhotoClickTypeSelect,//选择运单
    PhotoClickTypeBack,//返回按钮
    PhotoClickTypeConfirm, //确定按钮
    PhotoClickTypeLabelTilte //送货单行点击
};

@interface PSPhotoHeaderView : BaseView


@property (weak, nonatomic) IBOutlet UILabel *label_title;

@property (weak, nonatomic) IBOutlet UILabel *label_orderNo;
@property (weak, nonatomic) IBOutlet UILabel *label_region;
@property (weak, nonatomic) IBOutlet UILabel *label_addressDetail;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_name;

@property (weak, nonatomic) IBOutlet UILabel *label_phoneNum;




@property (nonatomic,copy) void(^didClickAction)(PhotoClickType clickType);

@end

NS_ASSUME_NONNULL_END
