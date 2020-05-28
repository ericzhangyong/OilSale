//
//  PSSenderStoreCell.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/5/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSSenderStoreCell.h"

@implementation PSSenderStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCellIsSelected:(BOOL)cellIsSelected{
    _cellIsSelected = cellIsSelected;
    
    if (cellIsSelected) {
        self.imageView_icon.image = [UIImage imageNamed:@"shoppingcart_choose_a"];
    }else {
        self.imageView_icon.image = [UIImage imageNamed:@"shoppingcart_choose"];
    }
}

@end
