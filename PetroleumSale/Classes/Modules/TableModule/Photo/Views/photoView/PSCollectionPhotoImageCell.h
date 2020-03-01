//
//  PSCollectionPhotoImageCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/20.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSCollectionPhotoImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView_content;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_Delete;

/// 1.添加照片 2.删除照片
@property (nonatomic,copy) void(^collectionDidClick)(NSInteger clickType);

@end

NS_ASSUME_NONNULL_END
