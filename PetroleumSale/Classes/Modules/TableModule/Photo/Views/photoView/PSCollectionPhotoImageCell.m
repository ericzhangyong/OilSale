//
//  PSCollectionPhotoImageCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/20.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSCollectionPhotoImageCell.h"

@implementation PSCollectionPhotoImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    self.imageView_content.userInteractionEnabled = YES;
    [self.imageView_content addGestureRecognizer:ges];
    
    
}

-(void)tapClick{
    
    if (self.collectionDidClick) {
        self.collectionDidClick(1);
    }
}

- (IBAction)acioonDelete:(UIButton *)sender {
    
    if (self.collectionDidClick) {
        self.collectionDidClick(2);
    }
}


@end
