//
//  PSSalesmanHomeCell.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSSalesmanHomeCell.h"

@implementation PSSalesmanHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)actionClickVisit:(UIButton *)sender {
    
//    if (sender.selected) {
//        sender.selected = NO;
//    }else{
//        sender.selected = YES;
//    }
//
    if (self.clickBlock) {
        self.clickBlock(YES);
    }
}

- (IBAction)actionCheckOrder:(UIButton *)sender {
    
    if (self.clickBlock) {
        self.clickBlock(NO);
    }
}



@end
