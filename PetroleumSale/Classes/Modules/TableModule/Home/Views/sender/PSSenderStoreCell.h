//
//  PSSenderStoreCell.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/5/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSSenderStoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_icon;

/// <#describe#>
@property (nonatomic,assign) BOOL cellIsSelected;


@end

NS_ASSUME_NONNULL_END
