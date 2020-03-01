//
//  FSPopSheetView.m
//  FireStore
//
//  Created by eric on 2019/9/5.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePopSheetView.h"
#import "UIView+BaseCategory.h"
#import "UIImage+BaseImageCategory.h"
//#import "UIColor+Expand.h"
#import "UIButton+EnlargeArea.h"
#import "UIView+BaseFrame.h"


#define PopSheetLineColor   [UIColor colorWithHexString:@"F5F5F5"]

#define ButtonTitleNormalColor  [UIColor colorWithHexString:@"207DF3"]
#define ButtonTitleHighColor  [UIColor whiteColor]

#define ButtonCancelTitleNormalColor  [UIColor colorWithHexString:@"333333"]


#define CancelButtonNormalImageColor [UIColor colorWithHexString:@"e6e8ed" ]
#define ConfirmButtonNormalImageColor [UIColor colorWithHexString:@"b9bcc2"]

static CGFloat KPopSheetCellHeight          =   45;
NSInteger const PopSheetCancel         =   403;
@interface BasePopSheetView ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *backView;

/**
 *  操作按钮titles
 */
@property (nonatomic, strong) NSMutableArray *titles;

/**
 *  内容高度
 */
@property (nonatomic, assign) NSInteger containerHeight;
@property (nonatomic, copy) PopSheetActionHandler actionHandler;


@end

@implementation BasePopSheetView


+ (BasePopSheetView *)showPopSheet:(UIView *)view
                    buttonTitles:(NSArray *)buttonTitles{
    [view endEditing:YES];
    BasePopSheetView *popSheet = [[self alloc] initWithFrame:view.bounds];
    [view addSubview:popSheet];
    popSheet.isAutoQuitView = YES;
    popSheet.titles = [NSMutableArray arrayWithArray:buttonTitles];
    return popSheet;
}

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    if (self = [super initWithFrame:frame   ]) {
        
        [self commonInit];
        self.titles = [NSMutableArray arrayWithArray:titles];
        self.isAutoQuitView = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    
    if (!_backView) {
        self.backView = [self setUpBackView];
    }
    
    if (!_containerView) {
        self.containerView = [self setUpContentView];
    }
}

#pragma mark - back View
- (UIView *)setUpBackView {
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.0f;
    [self addSubview:backView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopSheet)];
    tapGesture.delegate = self;
    [backView addGestureRecognizer:tapGesture];
    return backView;
}

#pragma mark - 容器View
- (UIView *)setUpContentView {
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:contentView];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.alpha = 0.9;
    return contentView;
}

#pragma mark - Content frame
- (void)setTitles:(NSMutableArray *)titles {
    
    _titles = [NSMutableArray arrayWithArray:titles];
    [_titles addObject:@"取消"];
    self.containerHeight = _titles.count * KPopSheetCellHeight;
    self.containerView.frame = CGRectMake(0, 0, self.width, self.containerHeight+SafeBottom);
    self.containerView.center = CGPointMake(self.centerX, self.height + self.containerHeight * 0.5);
    WEAK_SELF;
    [_titles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx + 1 == weakSelf.titles.count) {
            [weakSelf.containerView addSubview:[weakSelf addCancelButton:idx]];
        }
        else {
            [weakSelf.containerView addSubview:[weakSelf addConfirmButton:idx]];
        }
        
        CGFloat LineHeight;
        if (idx + 1 == weakSelf.titles.count) {
            LineHeight = 7;
        }else{
            LineHeight = 1;
        }
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, idx * KPopSheetCellHeight, weakSelf.containerView.width, LineHeight)];
        lineView.backgroundColor = PopSheetLineColor;
        [weakSelf.containerView addSubview:lineView];
    }];
}

#pragma mark - Action buttons
- (UIButton *)addActionButton:(NSInteger)idx
                        title:(NSString *)title
                  normalImage:(UIImage *)normalImage
                    highImage:(UIImage *)highImage {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, idx * KPopSheetCellHeight, self.containerView.width, KPopSheetCellHeight);
    btn.titleLabel.font = [UIFont systemWEPingFangRegularOfSize:18];
    [btn setDefaultEnlargeEdge];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    [btn setTitleColor:ButtonTitleNormalColor forState:UIControlStateNormal];
    if (idx +1 == _titles.count) {
        [btn setTitleColor:ButtonCancelTitleNormalColor forState:UIControlStateNormal];
    }
    [btn setTitleColor:ButtonTitleHighColor forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = idx+1000;
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (UIButton *)addConfirmButton:(NSInteger)idx {
    
    UIImage *normalImage = [UIImage imageWithColor:[UIColor whiteColor]];
    UIImage *highImage = [UIImage imageWithColor:ConfirmButtonNormalImageColor];
    return [self addActionButton:idx
                           title:_titles[idx]
                     normalImage:normalImage
                       highImage:highImage];
}

- (UIButton *)addCancelButton:(NSInteger)idx {
    
    //    UIImage *normalImage = [UIImage ff_imageWithColor:CancelButtonNormalImageColor];
    UIImage *normalImage = [UIImage imageWithColor:[UIColor whiteColor]];
    
    UIImage *highImage = [UIImage imageWithColor:CancelButtonNormalImageColor];
    return [self addActionButton:idx
                           title:_titles[idx]
                     normalImage:normalImage
                       highImage:highImage];
}

- (void)clickAction:(UIButton *)sender {
    
    if (self.isAutoQuitView ||sender.tag == self.titles.count - 1+1000) {
        [self hidePopSheet];
    }
    if (sender.tag == self.titles.count - 1+1000) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.actionHandler) {
                self.actionHandler(sender.titleLabel.text, PopSheetCancel);
            }
        });
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.actionHandler) {
            self.actionHandler(sender.titleLabel.text, sender.tag-1000);
        }
    });
    
}

#pragma mark - show/hide
- (void)showPopSheet {
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.backView.alpha = 0.6;
                         self.containerView.center = CGPointMake(self.centerX, self.height - self.containerHeight * 0.5);
                     }
                     completion:^(BOOL finished) {
                         //self.backView.hidden = NO;
                     }];
}

- (void)showPopSheetWithAction:(PopSheetActionHandler)handler {
    
    [self showPopSheet];
    self.actionHandler = handler;
}

-(void)reloadTitleWithTitle:(NSString *)title AtIndex:(NSInteger)index{
    
    UIButton *button = [self.containerView viewWithTag:index+1000];
    if ([button isKindOfClass:[UIButton class]]) {
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (void)hidePopSheet {
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.backView.alpha = 0.0f;
                         self.containerView.center = CGPointMake(self.centerX, self.height + self.containerHeight * 0.5);
                     }
                     completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                     }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isDescendantOfView:self.containerView]) {
        return NO;
    }
    return YES;
}

- (void)dealloc {
    
    
}
@end
