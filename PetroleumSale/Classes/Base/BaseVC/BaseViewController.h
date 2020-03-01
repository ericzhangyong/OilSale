//
//  FSBaseViewController.h
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

-(void)initNavView;
-(void)initBaseViews;
-(void)initBaseDatas;




#pragma mark- 设置导航栏

/**
 以图片形式设置导航栏rightBarButton

 @param image 图片
 @param target 目标对象
 @param selector selector
 */
- (void)rightBarButtonWithImage:(nullable UIImage *)image target:(nullable id)target selector:(nullable SEL)selector;

/**
 以图片形式设置导航栏leftBarButton

 @param image 图片
 @param target 目标对象
 @param selector selector
 */
- (void)leftBarButtonWithImage:(nullable UIImage *)image target:(nullable id)target selector:(nullable SEL)selector;

/**
 设置导航栏 rightBarButton 可显示高亮图片

 @param normalImage 默认图片
 @param highlightedImage 高亮图片
 @param target 目标对象
 @param selector selector
 */
- (void)rightBarButtonWithNormalImage:(nullable UIImage *)normalImage highlightedImage:(nullable UIImage *)highlightedImage targt:(nullable id)target selector:(nullable SEL)selector;

/**
 设置导航栏 leftBarButton 可显示高亮图片

 @param normalImage 默认图片
 @param highlightedImage 高亮图片
 @param target 目标对象
 @param selector selector
 */
- (void)leftBarButtonWithNormalImage:(nullable UIImage *)normalImage highlightedImage:(nullable UIImage *)highlightedImage target:(nullable id)target selector:(nullable SEL)selector;


/**
 以文字形式设置导航栏 rightBarButton

 @param text 文字
 @param textColor 文字颜色
 @param textFont 文字大小
 @param target 目标对象
 @param selector selector
 */
- (void)rightBarButtonWithText:(nullable NSString *)text textColor:(nonnull UIColor *)textColor textFont:(nonnull UIFont *)textFont target:(nullable id)target selector:(nullable SEL)selector;


/**
 以文字形式设置导航栏 leftBarButton

 @param text 文字
 @param textColor 文字颜色
 @param textFont 文字大小
 @param target 目标对象
 @param selector selector
 */
- (void)leftBarButtonWithText:(nullable NSString *)text textColor:(nonnull UIColor *)textColor textFont:(nonnull UIFont *)textFont target:(nullable id)target selector:(nullable SEL)selector;



@end

NS_ASSUME_NONNULL_END
