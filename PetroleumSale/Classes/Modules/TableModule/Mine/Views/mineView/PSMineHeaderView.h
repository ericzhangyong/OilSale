//
//  PSMineHeaderView.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSMineHeaderView : BaseView
@property (weak, nonatomic) IBOutlet UIView *view_user;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_header;
@property (weak, nonatomic) IBOutlet UILabel *label_nickName;
@property (weak, nonatomic) IBOutlet UILabel *label_phone;


@property (nonatomic,copy) void(^userClick)(BOOL isClick);
@end

NS_ASSUME_NONNULL_END
