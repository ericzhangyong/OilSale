//
//  FSBasePickerView.m
//  FireStore
//
//  Created by eric on 2019/9/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePickerView.h"
#import "UIView+BaseCategory.h"
#import "UIView+BaseFrame.h"
#define bottomHeight 279

@interface BasePickerView()
@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UIView *bottomView;
@end
@implementation BasePickerView

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setBaseView];
    }
    return self;
}
- (void)setBaseView {
    //    CGFloat height = self.frame.size.height;
    //    CGFloat width = self.frame.size.width;
    
    self.topImageView = [UIImageView new];
    self.topImageView.backgroundColor = [UIColor blackColor];
    self.topImageView.alpha = 0.3;
    self.topImageView.frame = self.bounds;
    [self addSubview:self.topImageView];

    self.topImageView.userInteractionEnabled = YES;
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, bottomHeight+SafeBottom)];
    bottomView.userInteractionEnabled = YES;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    selectView.backgroundColor = fsColor_FFFAFA;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:0];
    cancleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [cancleBtn setTitleColor:fsColor_666666 forState:0];
    cancleBtn.frame = CGRectMake(0, 5, 60, 40);
    [cancleBtn addTarget:self action:@selector(hideshowPickerView) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:cancleBtn];
    [bottomView addSubview:selectView];

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
    label.centerX = selectView.centerX;
    label.centerY = selectView.centerY;
    label.text = @"请选择城市";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [selectView addSubview:label];
    self.titleLabel = label;
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:0];
    [ensureBtn setTitleColor:fsColor_FF4053 forState:UIControlStateNormal];
    ensureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    ensureBtn.frame = CGRectMake(kScreenWidth - 80, 0, 60, 40);
    [ensureBtn addTarget:self action:@selector(ensureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:ensureBtn];

    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 49 , kScreenWidth,  230)];
    self.pickView.delegate   = self;
    self.pickView.dataSource = self;
    self.pickView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:self.pickView];

    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideshowPickerView)];
    [self.topImageView addGestureRecognizer:ges];
    
    [self.pickView reloadAllComponents];
    //[self updateAddressWithComponet:0 Row:0];
}
#pragma mark-UIPickerViewDelegate- UIPickerDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSource.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"";
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = NO;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[self getLabelFont]];
        pickerLabel.textColor = fsColor_666666;
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
    
}
-(UIFont *)getLabelFont{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:18];
}
-(UIColor *)getLabelColor{
    return color_lightDart_333333;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

#pragma mark- clikc


- (void)ensureBtnAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onItemSelectedData:)]) {
        [self.delegate onItemSelectedData:@""];
    }
    [self hideshowPickerView];
}


-(void)showPickerView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.bottomView.y = kScreenHeight;
    self.topImageView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.topImageView.alpha = 0.3;
        self.bottomView.y = kScreenHeight-SafeBottom-bottomHeight;
    }];
}
-(void)showPickerViewAtSuperView:(UIView *)superView{
    
    [superView addSubview:self];
    self.bottomView.y = kScreenHeight;
    self.topImageView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.topImageView.alpha = 0.3;
        self.bottomView.y = superView.frame.size.height-SafeBottom-bottomHeight;
    }];
}
-(void)hideshowPickerView{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bottomView.y = kScreenHeight;
        self.topImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
