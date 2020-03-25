//
//  PSDriverCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDriverOrderCell.h"

@implementation PSDriverOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = color_lightDart_f3f3f3;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
