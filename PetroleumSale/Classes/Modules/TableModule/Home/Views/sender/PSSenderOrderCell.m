//
//  PSSenderOrderCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderOrderCell.h"

@implementation PSSenderOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label_deliverNo.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)actionConfrimSend:(UIButton *)sender {
    
    if (self.confirmClick) {
        self.confirmClick();
    }
}

@end
