//
//  FSBaseViewController.m
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (@available(ios 13.0,*)) {
//        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//    }
    
    self.view.backgroundColor = color_lightDart_white;
    [self initBaseDatas];
    [self initNavView];
    [self initBaseViews];
}

-(void)initBaseDatas{
    
}

-(void)initNavView{
    
}
-(void)initBaseViews{
    
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    
}


#pragma mark- 设置导航栏
- (void)rightBarButtonWithImage:(nullable UIImage *)image target:(nullable id)target selector:(nullable SEL)selector {
    if (self.navigationItem) {
        self.navigationItem.rightBarButtonItem = [self barButtonWithImage:image target:target selector:selector];
    }
    
}

- (void)leftBarButtonWithImage:(nullable UIImage *)image target:(nullable id)target selector:(nullable SEL)selector {
    if (self.navigationItem) {
        [self hideBackBtn];
        self.navigationItem.leftBarButtonItem = [self barButtonWithImage:image target:target selector:selector];
    }
}

- (UIBarButtonItem *)barButtonWithImage:(UIImage *)image target:(id)target selector:(SEL)selector {
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:target action:selector];
    return btnItem;
}

- (void)rightBarButtonWithNormalImage:(nullable UIImage *)normalImage highlightedImage:(nullable UIImage *)highlightedImage targt:(nullable id)target selector:(nullable SEL)selector {
    if (self.navigationItem) {
        self.navigationItem.rightBarButtonItem = [self barButtonWithNormalImage:normalImage highlightedImage:highlightedImage target:target selector:selector];
    }
}

- (void)leftBarButtonWithNormalImage:(nullable UIImage *)normalImage highlightedImage:(nullable UIImage *)highlightedImage target:(nullable id)target selector:(nullable SEL)selector {
    if (self.navigationItem) {
        [self hideBackBtn];
        self.navigationItem.leftBarButtonItem = [self barButtonWithNormalImage:normalImage highlightedImage:highlightedImage target:target selector:selector];
    }
}

- (UIBarButtonItem *)barButtonWithNormalImage:(nullable UIImage *)normalImage highlightedImage:(nullable UIImage *)highlightedImage target:(nullable id)target selector:(nullable SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 44, self.navigationController.navigationBar.bounds.size.height);
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return btnItem;
}

- (void)rightBarButtonWithText:(nullable NSString *)text textColor:(nonnull UIColor *)textColor textFont:(nonnull UIFont *)textFont target:(nullable id)target selector:(nullable SEL)selector {
     if (self.navigationItem) {
        self.navigationItem.rightBarButtonItem = [self barButtonWithText:text textColor:textColor textFont:textFont target:target selector:selector];
    }
}

- (void)leftBarButtonWithText:(nullable NSString *)text textColor:(nonnull UIColor *)textColor textFont:(nonnull UIFont *)textFont target:(nullable id)target selector:(nullable SEL)selector {
    if (self.navigationItem) {
        [self hideBackBtn];
        self.navigationItem.leftBarButtonItem = [self barButtonWithText:text textColor:textColor textFont:textFont target:target selector:selector];
    }
}

- (UIBarButtonItem *)barButtonWithText:(nullable NSString *)text textColor:(nonnull UIColor *)textColor textFont:(nonnull UIFont *)textFont target:(nullable id)target selector:(nullable SEL)selector {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:target action:selector];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName,textColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName,textColor, NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    return barButtonItem;
}
- (void)hideBackBtn {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
        self.navigationItem.leftBarButtonItem = nil;
    } else {
        self.navigationItem.leftBarButtonItems = nil;
    }
}



@end
