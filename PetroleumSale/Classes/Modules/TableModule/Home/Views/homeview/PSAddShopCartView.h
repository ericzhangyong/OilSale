//
//  YHAddShopCartView.h
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/2/26.
//  Copyright © 2019年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,AddShopCartStyle){
    
    AddShopCartStyleProdcutDetailModel = 1,//
    AddShopCartStyleResourceItem //首页中
};

@protocol PSAddShopCartViewDelegate <NSObject>

@optional
//-(void)updateCartViewWithTouchView:(UIView *)actionView
//                       isTextField:(BOOL)isTextField;
-(void)btnClickIsAdd:(BOOL)isAdd complete:(void(^)(BOOL isFinish,id data))complete;
-(void)tf_inputDidEndEditing:(UITextField *)tf_input complete:(void(^)(BOOL isFinish,id data))complete;

@end

@interface PSAddShopCartView : UIView

@property (nonatomic,strong) id<PSAddShopCartViewDelegate> delegate;

@property (nonatomic,assign) AddShopCartStyle addCartStyle;

//folderView
@property (nonatomic,strong) UIButton *btn_folder;
@property (nonatomic,strong) UIView *view_folder;
//addView
@property (nonatomic,strong) UIView *view_add;
@property (nonatomic,strong) UIButton *btn_minus;
@property (nonatomic,strong) UIButton *btn_plus;
@property (nonatomic,strong) UITextField *tf_input;



/**
 是否显示View_add Yes显示view_add NO显示view_folder
 */
@property (nonatomic,assign) BOOL isShowView_add;




/** 刷新购买数量 */
-(void)refreshDataWithData:(id)data;



@end

NS_ASSUME_NONNULL_END
