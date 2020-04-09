//
//  PSKeeperHomeCell.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSKeeperHomeCell.h"
#import "UIView+BaseCategory.h"

@interface PSKeeperHomeCell ()
@property (weak, nonatomic) IBOutlet UIView *view_contain;

@end
@implementation PSKeeperHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.view_contain.layer.cornerRadius = 4;
    self.view_contain.layer.masksToBounds = YES;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
