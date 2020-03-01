//
//  PSDriverMessageVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/14.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDriverMessageVC.h"
#import "ZJScrollPageView.h"
#import "PSMessageVC.h"

@interface PSDriverMessageVC ()<ZJScrollPageViewDelegate>
@property (nonatomic,strong) ZJScrollSegmentView *view_segment;
//contentView
@property (nonatomic,strong) ZJContentView *view_content;

@property (nonatomic,strong) NSMutableArray *childrenArr;
@end

@implementation PSDriverMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)initBaseDatas{
    
    self.childrenArr = [NSMutableArray array];
    PSMessageVC *systemList = [[PSMessageVC alloc] initPSMeesageType:PSMeesageTypeDriverSystem];
    [self.childrenArr addObject:systemList];
    PSMessageVC *otherList = [[PSMessageVC alloc] initPSMeesageType:PSMeesageTypeDriverPunishment];
    [self.childrenArr addObject:otherList];
}
-(void)initNavView{
    self.navigationItem.title = @"消息通知";
}
-(void)initBaseViews{
    
    self.view.backgroundColor = color_F3F3F3;
    [self.view addSubview:self.view_segment];
    [self.view addSubview:self.view_content];
    
    [self.view_segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.view_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_segment.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}
#pragma mark-
-(NSInteger)numberOfChildViewControllers{
    return self.childrenArr.count;
}
-(UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index{
    
    PSMessageVC *listVC =(PSMessageVC *)reuseViewController;
    if (listVC ==nil) {
        listVC = self.childrenArr[index];
    }
    return listVC;
}
-(void)scrollTopageWithIndex:(NSInteger)index{
    
    CGPoint point = CGPointMake(self.view_content.frame.size.width*index, 0);
    [self.view_content setContentOffSet:point animated:YES];
}

-(BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}

#pragma mark- lazy

-(ZJScrollSegmentView *)view_segment{
    if (!_view_segment) {
        ZJSegmentStyle *style = [ZJSegmentStyle new];
        style.showLine = YES;
        style.scrollLineWidth = 36;
        style.normalTitleColor = color_999999;
        style.selectedTitleColor = color_4084FF;
        style.scrollLineColor = color_4084FF;
        style.titleFont = [UIFont systemWEPingFangBoldFontOfSize:17];
        style.autoAdjustTitlesWidth = YES;
        WEAK_SELF;
        _view_segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) segmentStyle:style delegate:self titles:@[@"系统通知",@"罚款通知"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            [weakSelf scrollTopageWithIndex:index];
        }];
        _view_segment.backgroundColor = [UIColor whiteColor];
        _view_segment.layer.masksToBounds = YES;
        _view_segment.layer.cornerRadius = 4;
    }
    return _view_segment;
}
-(ZJContentView *)view_content{
    if (!_view_content) {
        CGFloat headHeight = 50;

        _view_content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, headHeight, kScreenWidth, self.view.frame.size.height-headHeight) segmentView:self.view_segment parentViewController:self delegate:self];
    }
    return _view_content;
}


@end
