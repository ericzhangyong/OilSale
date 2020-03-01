//
//  PSDriverConfirmCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDriverConfirmCell.h"

@interface PSDriverConfirmCell ()

@end
@implementation PSDriverConfirmCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionConfirm:(UIButton *)sender {
    
    if (self.confirmClick) {
        self.confirmClick(YES);
    }
}


@end
