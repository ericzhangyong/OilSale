//
//  PSWareHousePickerView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSWareHousePickerView.h"
#import "PSWareHouseModel.h"

@implementation PSWareHousePickerView


-(void)showPickerView{
    [super showPickerView];
    
}

#pragma mark- UIPickerDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSource.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    PSWareHouseModel *model = self.dataSource[row];
    return [NSString stringWithFormat:@"%@%@",model.WhAddress,model.WhName];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.currentIndex = row;
}




@end
