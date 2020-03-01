//
//  PSPersonEditCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPersonEditCell.h"
#import "NSString+RECategory.h"


@implementation PSPersonEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [self.tf_content addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)valueChanged:(UITextField *)textField{
    
    if (self.textFieldDidChanged) {
        self.textFieldDidChanged(textField.text.getNoWhiteLineAndSpaceString);
    }
    
}

@end
