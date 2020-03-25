//
//  PSMineMessageCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSMineMessageCell.h"

@implementation PSMineMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label_content.layer.masksToBounds = YES;
    self.label_content.layer.cornerRadius = 8;
    
    self.contentView.backgroundColor = color_lightDart_white;

}


@end
