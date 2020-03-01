//
//  PSPertrolStationView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/25.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPertrolStationView.h"
#import "UIView+BaseCategory.h"

@implementation PSPertrolStationView



-(void)initBaseSubViews{
    

    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.view_contain zy_setShadowColor:color_E9E9E9 shadowOffset:CGSizeMake(0, 0) shadowRadius:8 shadowOpacity:0.6];
}


- (IBAction)actionSelectPetrolStation:(UIControl *)sender {
    if (self.stationViewClick) {
        self.stationViewClick(PSStationClickTypeSelectStation);
    }

}

- (IBAction)acionSelectCarNum:(UIControl *)sender {
    if (self.stationViewClick) {
        self.stationViewClick(PSStationClickTypeCarNum);
    }
}

- (IBAction)actionReserve:(UIButton *)sender {
    if (self.stationViewClick) {
        self.stationViewClick(PSStationClickTypeReserve);
    }
}
@end
