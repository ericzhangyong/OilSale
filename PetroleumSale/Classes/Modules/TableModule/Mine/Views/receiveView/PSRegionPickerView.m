//
//  PSRegionPickerView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSRegionPickerView.h"

@implementation PSRegionPickerView



-(void)showPickerView{
    [super showPickerView];
    
    [self.pickView selectRow:self.currentSelectIndex inComponent:0 animated:YES];
    [self.pickView reloadAllComponents];
}
/*{
    "option_value": "上海",
    "option_name": "上海",
    "selected": false
}*/
#pragma mark- PickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSource.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSDictionary *dict = self.dataSource[row];
    return self.dataSource[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.currentSelectIndex = row;
}


-(void)ensureBtnAction:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(onItemSelectedData:)]) {
//        NSDictionary *dict  = self.dataSource[self.currentSelectIndex];
        [self.delegate onItemSelectedData:self.dataSource[self.currentSelectIndex]];
    }
    [self hideshowPickerView];
}
@end
