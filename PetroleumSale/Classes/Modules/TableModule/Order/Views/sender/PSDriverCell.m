//
//  PSDriverCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDriverCell.h"
#import "UIButton+EnlargeArea.h"

@implementation PSDriverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [self.btn_select setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



- (IBAction)actionSelectClick:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    if (self.selectDidClick) {
        self.selectDidClick(sender.selected);
    }
}

@end
