//
//  WEAddressPickerView.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/26.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "FSAddressPickerView.h"
#import "UIView+BaseFrame.h"

#define bottomHeight (SafeBottom+220+55+34)
@interface FSAddressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIPickerView *pickView;

@property (nonatomic,strong) UIImageView *topImageView;

@property (nonatomic,strong) UIView *bottomView;

@end
@implementation FSAddressPickerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self setBaseView];
    }
    return self;
}
-(FSAddressManager *)manager{
    if (!_manager) {
        _manager = [FSAddressManager new];
        [_manager getAddressInfo];
    }
    return _manager;
}
- (void)setBaseView {
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    self.topImageView = [UIImageView new];
    self.topImageView.backgroundColor = [UIColor blackColor];
    self.topImageView.alpha = 0;
    self.topImageView.userInteractionEnabled = YES;
    self.topImageView.frame  = CGRectMake(0, 0, width, height);
    [self addSubview:self.topImageView];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateCancleAction)];
    [self.topImageView addGestureRecognizer:ges];
    
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.frame = CGRectMake(0, kScreenHeight-bottomHeight, width, bottomHeight);
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomView];

    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 55)];
    selectView.backgroundColor = [UIColor colorWithHexString:@"F7FBFF"];
    [self.bottomView addSubview:selectView];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:0];
    cancleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [cancleBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:0];
    cancleBtn.frame = CGRectMake(36, 12.5, 30, 30);
    [cancleBtn addTarget:self action:@selector(dateCancleAction) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:cancleBtn];

    UILabel *label = [UILabel new];
    label.text = @"请选择城市";
    label.frame = CGRectMake(kScreenWidth*0.5-50, 17.5, 100, 20);
    label.textColor = [UIColor colorWithHexString:@"333333"];
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [selectView addSubview:label];

    
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:0];
    [ensureBtn setTitleColor:[UIColor colorWithHexString:@"207DF3"] forState:UIControlStateNormal];
    ensureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    ensureBtn.frame = CGRectMake(width-36-30, 12.5, 30, 30);
    [ensureBtn addTarget:self action:@selector(dateEnsureAction) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:ensureBtn];
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(selectView.frame), width,  220)];
    self.pickView.delegate   = self;
    self.pickView.dataSource = self;
    self.pickView.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.pickView];
    
    [self bringSubviewToFront:self.bottomView];
    [self.pickView reloadAllComponents];
    [self updateAddressWithComponet:0 Row:0];
}

- (void)updateAddressAtProvince:(NSString *)province city:(NSString *)city town:(NSString *)town {
    self.province = province;
    self.city = city;
    self.area = town;
    if (self.province) {
        for (NSInteger i = 0; i < self.manager.provinceArray.count; i++) {
            NSString *provinceName = [self.manager getProvinceNameAtIndex:i];
            if ([provinceName isEqualToString:self.province]) {
                [self.pickView selectRow:i inComponent:0 animated:YES];
                [self.manager getCityArrayAtIndex:i];
                self.provinceCode = [self.manager getProvinceCodeAtIndex:i];
                break;
            }
        }
        for (NSInteger i = 0; i < self.manager.cityArray.count; i++) {
            NSString *cityName = [self.manager getCityNameAtIndex:i];;
            if ([cityName isEqualToString:self.city]) {
                [self.pickView selectRow:i inComponent:1 animated:YES];
                [self.manager getAreaArrayAtIndex:i];
                self.cityCode = [self.manager getCityCodeAtIndex:i];
                break;
            }
        }
        for (NSInteger i = 0; i < self.manager.areaArray.count; i++) {
            NSString *townName = [self.manager getAreaNameAtIndex:i];
            if ([townName isEqualToString:self.area]) {
                [self.pickView selectRow:i inComponent:2 animated:YES];
                self.areaCode = [self.manager getAreaCodeAtIndex:i];
                break;
            }
        }
    }
    [self setDefault];
    
    [self.pickView reloadAllComponents];
}

-(void)setDefault{
    
    self.province = [self.manager getProvinceNameAtIndex:[self.pickView selectedRowInComponent:0]];
    self.city  = [self.manager getCityNameAtIndex:[self.pickView selectedRowInComponent:1]];
    self.area  = [self.manager getAreaNameAtIndex:[self.pickView selectedRowInComponent:2]];
    self.provinceCode = [self.manager getProvinceCodeAtIndex:[self.pickView selectedRowInComponent:0]];
    self.cityCode = [self.manager getCityCodeAtIndex:[self.pickView selectedRowInComponent:1]];
    self.areaCode = [self.manager getAreaCodeAtIndex:[self.pickView selectedRowInComponent:2]];
}

- (void)dateCancleAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.y = kScreenHeight;
        self.topImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)showPickerViewAtSuperView:(UIView *)superView{
    
    
    [superView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.y = kScreenHeight-bottomHeight;
        self.topImageView.alpha = 0.3;
    }];
}

- (void)dateEnsureAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addressPickerWithProvince:city:area:ProvinceCode:cityCode:areaCode:)]) {
        [self.delegate addressPickerWithProvince:self.province city:self.city area:self.area ProvinceCode:self.provinceCode cityCode:self.cityCode areaCode:self.areaCode];
    }
    [self dateCancleAction];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:self.font?:[UIFont boldSystemFontOfSize:14]];
        pickerLabel.textColor = [UIColor colorWithHexString:@"666666"];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark- PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.manager getProviceCount];
    } else if (component == 1) {
        
        return [self.manager getCityCount];
    } else {
        return [self.manager getAreaCount];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.manager getProvinceNameAtIndex:row];
    } else if (component == 1) {
        return [self.manager getCityNameAtIndex:row];
    } else {
        return [self.manager getAreaNameAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width / 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        
        [self.manager getCityArrayAtIndex:[pickerView selectedRowInComponent:0]];
        [self.manager getAreaArrayAtIndex:[pickerView selectedRowInComponent:1]];
        [pickerView reloadComponent:1];
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
    }
    if (component == 1) {
        
        [self.manager getAreaArrayAtIndex:[pickerView selectedRowInComponent:1]];
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
    }
    if (component == 2) {
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
    }
    [self updateAddressWithComponet:component Row:row];
}

- (void)updateAddressWithComponet:(NSInteger)component Row:(NSInteger)row {
    
    
    //NSMutableDictionary *addressDict = [NSMutableDictionary dictionary];
    self.province = [self.manager getProvinceNameAtIndex:[self.pickView selectedRowInComponent:0]];
    self.city  = [self.manager getCityNameAtIndex:[self.pickView selectedRowInComponent:1]];
    self.area  = [self.manager getAreaNameAtIndex:[self.pickView selectedRowInComponent:2]];
    self.provinceCode = [self.manager getProvinceCodeAtIndex:[self.pickView selectedRowInComponent:0]];
    self.cityCode = [self.manager getCityCodeAtIndex:[self.pickView selectedRowInComponent:1]];
    self.areaCode = [self.manager getAreaCodeAtIndex:[self.pickView selectedRowInComponent:2]];
}


@end
