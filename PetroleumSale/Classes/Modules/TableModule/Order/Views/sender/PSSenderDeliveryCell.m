//
//  PSSenderDeliveryCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDeliveryCell.h"

@implementation PSSenderDeliveryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = color_lightDart_f3f3f3;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionPickSaveNum:(UIButton *)sender {
    
    if (self.saveClickBlock) {
        self.saveClickBlock(self.tf_pickerNum.text);
    }
    
}



//- (IBAction)actionGoSend:(UIButton *)sender {
//    
//    if (self.goToSendClick) {
//        self.goToSendClick();
//    }
//}

@end
