//
//  FSAddNewAddressTVCell.h
//  FireStore
//
//  Created by eric on 2019/8/31.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSAddNewAddressTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_title;

@property (weak, nonatomic) IBOutlet PlaceHolderTextView *tv_input;



@end

NS_ASSUME_NONNULL_END
