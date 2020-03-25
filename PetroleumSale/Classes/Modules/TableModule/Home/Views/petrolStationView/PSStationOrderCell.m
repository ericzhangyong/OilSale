//
//  PSStationOrderCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/18.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSStationOrderCell.h"

@interface PSStationOrderCell ()

@property (weak, nonatomic) IBOutlet UIView *view_carMessage;

@end
@implementation PSStationOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.view_carMessage.backgroundColor = color_lightDart_white;
    self.contentView.backgroundColor = color_lightDart_f3f3f3;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 4;
}


@end
