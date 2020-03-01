//
//  PSDriverConfirmCell.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSDriverConfirmCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_tile;


@property (nonatomic,copy)void(^confirmClick)(BOOL isClick);

@end

NS_ASSUME_NONNULL_END
