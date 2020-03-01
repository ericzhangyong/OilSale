//
//  PSStationOrderCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/18.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSStationOrderCell.h"

@implementation PSStationOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 4;
}


@end
