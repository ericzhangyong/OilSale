//
//  PSSalesmanOrderVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSSalesmanOrderVC.h"
#import "ZJScrollPageView.h"
#import "PSSalesmanOrderListVC.h"


@interface PSSalesmanOrderVC ()<ZJScrollPageViewChildVcDelegate,ZJScrollPageViewDelegate>
@property (nonatomic,strong) ZJScrollSegmentView *view_segment;
@property (nonatomic,strong) ZJContentView *view_content;
@property (nonatomic,strong) NSMutableArray *childrenArr;
@end

@implementation PSSalesmanOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)initNavView{
    
    self.navigationItem.title = @"订单信息";
    self.navigationController.navigationBar.barTintColor = color_4084FF;
}

-(void)initBaseViews{
    
    PSSalesmanOrderListVC *unOrderedList = [[PSSalesmanOrderListVC alloc] initWithListType:PSSalesmanOrderListTypeUnOrdered];
    [self.childrenArr addObject:unOrderedList];
    PSSalesmanOrderListVC *orderedList = [[PSSalesmanOrderListVC alloc] initWithListType:PSSalesmanOrderListTypeOrdered];
    [self.childrenArr addObject:orderedList];
    PSSalesmanOrderListVC *finishedList = [[PSSalesmanOrderListVC alloc] initWithListType:PSSalesmanOrderListTypeOrderFinished];
    [self.childrenArr addObject:finishedList];
    PSSalesmanOrderListVC *cancelList = [[PSSalesmanOrderListVC alloc] initWithListType:PSSalesmanOrderListTypeOrderCancel];
    [self.childrenArr addObject:cancelList];
    
    [self.view addSubview:self.view_segment];
    [self.view addSubview:self.view_content];
    
    
    [self.view_segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
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
    PSSalesmanOrderListVC *vc = (PSSalesmanOrderListVC *)reuseViewController;
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
        _view_segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) segmentStyle:style delegate:self titles:@[@"未下单",@"已下单",@"已完成",@"已取消"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            [weakSelf scroToPageIndex:index];
        }];
    }
    return _view_segment;
}

-(ZJContentView *)view_content{
    if (!_view_content) {
        _view_content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight-SafeBottom-MasNavHeight-50) segmentView:self.view_segment parentViewController:self delegate:self];
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
