//
//  FSBasePickerView.h
//  FireStore
//
//  Created by eric on 2019/9/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BasePickerViewDelegate <NSObject>

-(void)onItemSelectedData:(id)data;


@end

@interface BasePickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>


@property (strong, nonatomic) UIPickerView *pickView;
@property(nonatomic, assign) id<BasePickerViewDelegate> delegate;


@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) UILabel *titleLabel;

-(void)showPickerView;
-(void)showPickerViewAtSuperView:(UIView *)superView;

-(void)hideshowPickerView;

//设置label
-(UIFont *)getLabelFont;
-(UIColor *)getLabelColor;

- (void)ensureBtnAction:(UIButton *)button;
@end

NS_ASSUME_NONNULL_END
