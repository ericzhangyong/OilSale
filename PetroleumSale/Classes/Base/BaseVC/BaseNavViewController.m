//
//  FSBaseNavViewController.m
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) id<UINavigationControllerDelegate> navDelegate;
@property (nonatomic , strong) NSMutableArray *showNavBarVcClassArr;
@property (nonatomic , strong) NSMutableArray *hideNavBarVcClassArr;

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    
    UINavigationBar *navigationBar = self.navigationBar;
    UIImage *image = [UIImage imageNamed:@"hp_icon_back_a"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image;
    navigationBar.backIndicatorTransitionMaskImage = image;
    //    [navigationBar.backItem.backBarButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    
    //去掉下划线
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //黑线
    UIImageView *lineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    lineImageView.hidden = YES;
    
    self.navigationBar.translucent = NO;
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    
    
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view{
    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))return  NO;
    
    if (self.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
    
        return YES;
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    Class fromClsss = NSClassFromString(@"CYLTabBarController");
    BOOL isHomeToMessage = ([self.topViewController isKindOfClass:fromClsss]);
    if (self.viewControllers.count) {
        if ( !isHomeToMessage ) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"hp_icon_back_a"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onNavLeftBar:)];
    }
    [super pushViewController:viewController animated:animated];
}




- (void)onNavLeftBar:(id)sender {
    [self popViewControllerAnimated:YES];
}
#pragma mark- 显示隐藏导航栏
-(void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    if (delegate != self) {
        self.navDelegate = delegate;
    }
    [super setDelegate:self];
}
-(void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    
}

-(void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.navDelegate) {
        [self.navDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
    NSString *vcStr = NSStringFromClass([viewController class]);
    if ([self.showNavBarVcClassArr containsObject:vcStr]) {
        if (navigationController.isNavigationBarHidden) {
            [super setNavigationBarHidden:NO animated:animated];
        }
    }else if([self.hideNavBarVcClassArr containsObject:vcStr]){
        if (!navigationController.isNavigationBarHidden) {
            [super setNavigationBarHidden:YES animated:animated];
        }
    }else{
        if (navigationController.isNavigationBarHidden) {
            [super setNavigationBarHidden:NO animated:animated];
        }
    }
}

-(NSMutableArray *)showNavBarVcClassArr
{
    if (!_showNavBarVcClassArr) {
        _showNavBarVcClassArr = [@[] mutableCopy];
    }
    return _showNavBarVcClassArr;
}
-(NSMutableArray *)hideNavBarVcClassArr
{
    if (!_hideNavBarVcClassArr) {
        _hideNavBarVcClassArr = [NSMutableArray array];
        NSArray *hiddenArr = @[@"CYLTabBarController",@"PSMineVC",@"PSHomeVC",@"PSDriverHomeVC",@"PSPhotoConfirmVC",@"PSSenderOrderListVC",@"PSSenderDeleryVC",@"PSPetrolStationHomeVC",@"PSSalemanHomeVC"];
        [_hideNavBarVcClassArr setArray:hiddenArr];
    }
    return _hideNavBarVcClassArr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
