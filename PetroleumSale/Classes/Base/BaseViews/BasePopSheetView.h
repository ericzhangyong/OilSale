//
//  FSPopSheetView.h
//  FireStore
//
//  Created by eric on 2019/9/5.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PopSheetActionHandler)(NSString *title, NSInteger idx);
extern NSInteger const PopSheetCancel;
@interface BasePopSheetView : UIView
/**
 *  选择sheet
 *
 *  @param view         parentView
 *  @param buttonTitles button titles
 *
 *  @return FFPopSheet
 */
+ (BasePopSheetView *)showPopSheet:(UIView *)view
                    buttonTitles:(NSArray *)buttonTitles;


-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/** 点击之后是否自动退出view */
@property (nonatomic,assign) BOOL isAutoQuitView;

-(void)hidePopSheet;

/**
 sheet 回调
 
 @param handler 回调handler
 */
- (void)showPopSheetWithAction:(PopSheetActionHandler)handler;

/**
 更新标题
 */
-(void)reloadTitleWithTitle:(NSString *)title AtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
