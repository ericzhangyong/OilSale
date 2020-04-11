//
//  PSPropertyListCell.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSPropertyListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_tunBucketCount;
@property (weak, nonatomic) IBOutlet UILabel *label_tieBucketType;
@property (weak, nonatomic) IBOutlet UILabel *label_oidGun;

@property (weak, nonatomic) IBOutlet UILabel *label_addresss;

@end

NS_ASSUME_NONNULL_END
