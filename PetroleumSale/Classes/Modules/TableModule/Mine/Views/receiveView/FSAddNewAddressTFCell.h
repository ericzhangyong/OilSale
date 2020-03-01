//
//  FSAddNewAddressTFCell.h
//  FireStore
//
//  Created by eric on 2019/8/31.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSAddNewAddressTFCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UITextField *tf_input;

@property (weak, nonatomic) IBOutlet UILabel *label_selectArea;

/** tf_input change */
@property (nonatomic,copy) void(^textFieldDidChangeBlock)(NSString *text);

@property (nonatomic,copy) void(^selectAreaTaped)(BOOL isTaped);


/** isSelectArea */
@property (nonatomic,assign) BOOL isSelectArea;

@end

NS_ASSUME_NONNULL_END
