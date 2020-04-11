//
//  PSPropertyVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/2.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSPropertyVC.h"
#import "ZJScrollPageView.h"
#import "PSPropertyViewModel.h"
#import "PSPropertyListVC.h"

@interface PSPropertyVC ()<ZJScrollPageViewDelegate>

@property (nonatomic,strong) ZJScrollSegmentView *view_segment;
@property (nonatomic,strong) ZJContentView *view_content;
@property (nonatomic,strong) NSMutableArray *childrenArr;
@end

@implementation PSPropertyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)initNavView{
    
    self.navigationItem.title = @"资产";
    self.navigationController.navigationBar.barTintColor = color_4084FF;
}

-(void)initBaseViews{
    
    
    PSPropertyListVC *mineList = [[PSPropertyListVC alloc] initWithListType:PSPropertyListTypeMine];
     [self.childrenArr addObject:mineList];
    PSPropertyListVC *clientList= [[PSPropertyListVC alloc] initWithListType:PSPropertyListTypeClient];
    [self.childrenArr addObject:clientList];
 
  

    [self.view addSubview:self.view_segment];
    [self.view addSubview:self.view_content];
    
    [self.view_segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.view_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_segment.mas_bottom);
        make.bottom.right.left.equalTo(self.view);
    }];
}




-(void)scroToPageIndex:(NSInteger)index{
    CGPoint poit = CGPointMake(self.view_content.frame.size.width*index, 0);
    [self.view_content setContentOffSet:poit animated:YES];
}

-(BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}
#pragma mark- ZJScrollPageViewDelegate
-(NSInteger)numberOfChildViewControllers{
    return self.childrenArr.count;
}
-(UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index{
    PSPropertyListVC *vc = (PSPropertyListVC*)reuseViewController;
    if (vc == nil) {
        vc = self.childrenArr[index];
    }
    return vc;
}

#pragma mark- lazy
-(ZJScrollSegmentView *)view_segment{
    if (!_view_segment) {
        ZJSegmentStyle *style = [ZJSegmentStyle new];
        style.showLine = YES;
        style.scrollLineColor = color_4084FF;
        style.selectedTitleColor = color_4084FF;
        style.normalTitleColor = color_666666;
        style.autoAdjustTitlesWidth = YES;
        style.scrollLineWidth = 36;
        style.titleFont = [UIFont systemWEPingFangBoldFontOfSize:14];
        WEAK_SELF;
        _view_segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, MasNavHeight, kScreenWidth, 50) segmentStyle:style delegate:self titles:@[@"我的仓库",@"客户的仓库"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            [weakSelf scroToPageIndex:index];
        }];
    }
    return _view_segment;
}

-(ZJContentView *)view_content{
    if (!_view_content) {
        _view_content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, 50+MasNavHeight, kScreenWidth, kScreenHeight-SafeBottom-MasNavHeight-50) segmentView:self.view_segment parentViewController:self delegate:self];
    }
    return _view_content;
}

-(NSMutableArray *)childrenArr{
    if (!_childrenArr) {
        _childrenArr = @[].mutableCopy;
    }
    return _childrenArr;
}





@end
