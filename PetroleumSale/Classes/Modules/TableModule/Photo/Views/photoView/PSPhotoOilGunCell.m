//
//  PSPhotoOilGunCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPhotoOilGunCell.h"

@interface PSPhotoOilGunCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView_dot;

@end
@implementation PSPhotoOilGunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView_dot.layer.borderColor = color_B6B6B6.CGColor;
    self.imageView_dot.layer.borderWidth = 0.5;
    
    [self.tf_oilGunCount addTarget:self action:@selector(actionValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)actionValueChanged:(UITextField *)textField{
    if (self.oidCountDidChanged) {
        self.oidCountDidChanged(textField.text);
    }
    
}


@end
