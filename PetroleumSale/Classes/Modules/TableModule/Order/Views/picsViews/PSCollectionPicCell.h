//
//  PSCollectionPicCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/7.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSCollectionPicCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView_pic;
@property (weak, nonatomic) IBOutlet UILabel *label_title;

@end

NS_ASSUME_NONNULL_END
