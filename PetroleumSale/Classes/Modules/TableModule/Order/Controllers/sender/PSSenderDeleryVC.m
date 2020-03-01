//
//  PSSenderDeleryVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDeleryVC.h"
#import "PSSenderDelveryNavView.h"
#import "ZJScrollPageView.h"
#import "PSSenderDeliverListVC.h"

@interface PSSenderDeleryVC ()<ZJScrollPageViewChildVcDelegate,ZJScrollPageViewDelegate>

@property (nonatomic,strong) PSSenderDelveryNavView *view_nav;

@property (nonatomic,strong) ZJScrollSegmentView *view_segment;
@property (nonatomic,strong) ZJContentView *view_content;
@property (nonatomic,strong) NSMutableArray *childrenArr;
@end

@implementation PSSenderDeleryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)initBaseViews{
    
    
    [self.view addSubview:self.view_nav];
    [self.view_nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(MasNavHeight);
    }];
    
    PSSenderDeliverListVC *historyList= [[PSSenderDeliverListVC alloc] initWithListType:PSSenderDeliverListTypeUnSended];
       [self.childrenArr addObject:historyList];
    PSSenderDeliverListVC *curretnList = [[PSSenderDeliverListVC alloc] initWithListType:PSSenderDeliverListTypeSended];
    [self.childrenArr addObject:curretnList];
    PSSenderDeliverListVC *pickOneSelfList = [[PSSenderDeliverListVC alloc] initWithListType:PSSenderDeliverListTypePickOneSelf];
    [self.childrenArr addObject:pickOneSelfList];
   
    
    [self.view addSubview:self.view_segment];
    [self.view addSubview:self.view_content];
    
    [self.view_segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view_nav.mas_bottom);
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
    PSSenderDeliverListVC *vc = (PSSenderDeliverListVC*)reuseViewController;
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
        _view_segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, MasNavHeight, kScreenWidth, 50) segmentStyle:style delegate:self titles:@[@"未派单",@"已派单",@"自提单"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
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

-(PSSenderDelveryNavView *)view_nav{
    if (!_view_nav) {
        _view_nav = [PSSenderDelveryNavView  initViewWithFrame:CGRectMake(0, 0, kScreenWidth, MasNavHeight )];
    }
    return _view_nav;
}


@end
