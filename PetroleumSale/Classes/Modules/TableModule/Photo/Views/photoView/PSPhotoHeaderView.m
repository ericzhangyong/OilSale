//
//  PSPhotoHeaderView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPhotoHeaderView.h"

@interface PSPhotoHeaderView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_nav;

@end
@implementation PSPhotoHeaderView

-(void)initBaseSubViews{
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.layoutHeight_nav.constant = MasNavHeight;
}

- (IBAction)acionSelect:(UIControl *)sender {

    if (self.didClickAction) {
        self.didClickAction(PhotoClickTypeSelect);
    }

}


- (IBAction)actionBack:(UIButton *)sender {
    if (self.didClickAction) {
        self.didClickAction(PhotoClickTypeBack);
    }
    
}


- (IBAction)acitonConfirm:(UIButton *)sender {
    
    if (self.didClickAction) {
        self.didClickAction(PhotoClickTypeConfirm);
    }
}
- (IBAction)actionLabelTitleClick:(UIControl *)sender {
    
    if (self.didClickAction) {
        self.didClickAction(PhotoClickTypeLabelTilte);
    }
}

@end
