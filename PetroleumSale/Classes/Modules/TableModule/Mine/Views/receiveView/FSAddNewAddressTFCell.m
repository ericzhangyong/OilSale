//
//  FSAddNewAddressTFCell.m
//  FireStore
//
//  Created by eric on 2019/8/31.
//  Copyright © 2019 eric. All rights reserved.
//

#import "FSAddNewAddressTFCell.h"

@interface FSAddNewAddressTFCell ()

@end
@implementation FSAddNewAddressTFCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *gest =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectArea)];
    self.label_selectArea.userInteractionEnabled = YES;
    [self.label_selectArea addGestureRecognizer:gest];
    
    [self.tf_input addTarget:self action:@selector(textFieldsDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldsDidChange:(UITextField *)textField{
    

    if (self.textFieldDidChangeBlock) {
        self.textFieldDidChangeBlock(textField.text);
    }
}


-(void)tapSelectArea{
    
    if (self.selectAreaTaped) {
        self.selectAreaTaped(YES);
    }
}

-(void)setIsSelectArea:(BOOL)isSelectArea{
    
    _isSelectArea = isSelectArea;
    
    self.tf_input.hidden = isSelectArea;
    self.label_selectArea.hidden = !isSelectArea;
   
}

@end
