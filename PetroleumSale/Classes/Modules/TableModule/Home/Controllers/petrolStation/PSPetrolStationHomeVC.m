//
//  PSPetrolStationVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSPetrolStationHomeVC.h"
#import "PSPetrolOrderViewModel.h"
#import "BaseBlueNavView.h"
#import "ZJScrollPageView.h"
#import "PSStationOrderListVC.h"

@interface PSPetrolStationHomeVC ()<ZJScrollPageViewChildVcDelegate,ZJScrollPageViewDelegate>

@property (nonatomic,strong) ZJScrollSegmentView *view_segment;
@property (nonatomic,strong) UIView *view_segmentContain;
@property (nonatomic,strong) ZJContentView *view_content;
@property (nonatomic,strong) NSMutableArray *childrenArr;

@property (nonatomic,strong) BaseBlueNavView *view_nav;
@end

@implementation PSPetrolStationHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

-(void)initNavView{
    
    self.view.backgroundColor = color_F3F3F3;
    [self.view addSubview:self.view_nav];
    [self.view_nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(MasNavHeight + 46);
    }];

}

-(void)initBaseViews{
    
    PSStationOrderListVC *curretnList = [[PSStationOrderListVC alloc] initWithListType:PSStationOrderListTypeCurrent];
    [self.childrenArr addObject:curretnList];
    PSStationOrderListVC *historyList= [[PSStationOrderListVC alloc] initWithListType:PSStationOrderListTypeHistory];
    [self.childrenArr addObject:historyList];
    
    [self.view addSubview:self.view_segmentContain];
    [self.view_segmentContain addSubview:self.view_segment];
    [self.view addSubview:self.view_content];
    
    [self.view_segmentContain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(MasNavHeight+5);
        make.height.mas_equalTo(74);
    }];
    [self.view_segment mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//        make.top.equalTo(self.view).offset(MasNavHeight+5);
        make.top.left.right.equalTo(self.view_segmentContain);
        make.height.mas_equalTo(60);
    }];
    [self.view_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_segmentContain.mas_bottom);
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
    PSStationOrderListVC *vc = (PSStationOrderListVC*)reuseViewController;
    if (vc == nil) {
        vc = self.childrenArr[index];
    }
    return vc;
}
#pragma mark- Layz


-(BaseBlueNavView *)view_nav{
    if (!_view_nav) {
        _view_nav = [BaseBlueNavView initViewWithFrame:CGRectMake(0, 0, kScreenWidth, MasNavHeight+46)];
    }
    return _view_nav;
}
-(UIView *)view_segmentContain{
    if (!_view_segmentContain) {
        _view_segmentContain = [UIView new];
        _view_segmentContain.backgroundColor = [UIColor whiteColor];
        _view_segmentContain.layer.cornerRadius= 4;
        _view_segmentContain.clipsToBounds = YES;
    }
    return _view_segmentContain;
}
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
        _view_segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, MasNavHeight+5, kScreenWidth, 60) segmentStyle:style delegate:self titles:@[@"当前订单",@"历史订单"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            [weakSelf scroToPageIndex:index];
        }];
        _view_segment.backgroundColor = [UIColor whiteColor];
    }
    return _view_segment;
}

-(ZJContentView *)view_content{
    if (!_view_content) {
        _view_content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, MasNavHeight+5+74, kScreenWidth, kScreenHeight-SafeBottom-49-MasNavHeight-5-74) segmentView:self.view_segment parentViewController:self delegate:self];
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
