//
//  PSDeliveryCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/13.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDeliveryCell.h"

@implementation PSDeliveryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor= color_lightDart_f3f3f3;
    self.imageView_header.layer.masksToBounds = YES;
    self.imageView_header.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionDidSelected:(UIButton *)sender {
    
    if (self.btnDidSelecBlock) {
        self.btnDidSelecBlock(YES);
    }
}


@end
