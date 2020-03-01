//
//  PSPersonEditCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSPersonEditCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UITextField *tf_content;


@property (nonatomic,copy) void(^textFieldDidChanged)(NSString *value);

@end

NS_ASSUME_NONNULL_END
