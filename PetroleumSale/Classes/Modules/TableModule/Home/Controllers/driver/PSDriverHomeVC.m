//
//  PSDriverHomeVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/10.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSDriverHomeVC.h"
#import "ZJScrollPageView.h"
#import "PSDeliveryListVC.h"

@interface PSDriverHomeVC ()<ZJScrollPageViewDelegate>

@property (nonatomic,strong) UIView *view_header;
@property (nonatomic,strong) UILabel *label_title;
@property (nonatomic,strong) UIImageView *imageView_background;
@property (nonatomic,strong) ZJScrollSegmentView *view_segment;
//contentView
@property (nonatomic,strong) ZJContentView *view_content;

@property (nonatomic,strong) NSMutableArray *childrenArr;
@end

@implementation PSDriverHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    


    
}

-(void)initBaseDatas{
    
    self.childrenArr = [NSMutableArray array];
    PSDeliveryListVC *todayList = [[PSDeliveryListVC alloc] initWithDeliveryListTypeL:DeliveryListTypeToaday];
    [self.childrenArr addObject:todayList];
    PSDeliveryListVC *otherList = [[PSDeliveryListVC alloc] initWithDeliveryListTypeL:DeliveryListTypeOther];
    [self.childrenArr addObject:otherList];
}

-(void)initBaseViews{
    
    self.view.backgroundColor = color_lightDart_f3f3f3;
    [self.view addSubview:self.view_header];
    [self.view_header addSubview:self.imageView_background];
    [self.view_header addSubview:self.label_title];
    [self.view_header addSubview:self.view_segment];
    [self.view addSubview:self.view_content];
    
    CGFloat headHeight = 147-20+SafeTop;
    [self.view_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(headHeight);
    }];
    
    [self.imageView_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(headHeight-37);
    }];
    
    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_header).offset(10+SafeTop);
        make.left.right.equalTo(self.view_header);
    }];
    
    [self.view_segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view_header);
        make.left.equalTo(self.view_header).offset(15);
        make.right.equalTo(self.view_header).offset(-15);
        make.height.mas_equalTo(74);
    }];
    
    [self.view_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_header.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
}


#pragma mark-
-(NSInteger)numberOfChildViewControllers{
    return self.childrenArr.count;
}
-(UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index{
    
    PSDeliveryListVC *listVC =(PSDeliveryListVC *)reuseViewController;
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
-(UIView *)view_header{
    if (!_view_header) {
        _view_header = [UIView new];
        _view_header.backgroundColor = color_lightDart_f3f3f3;
    }
    return _view_header;
}

-(UILabel *)label_title{
    if (!_label_title) {
        _label_title = [UILabel new];
        _label_title.text = @"石化销售平台";
        _label_title.font = [UIFont systemWEPingFangMediumFontOfSize:17];
        _label_title.textColor = [UIColor whiteColor];
        _label_title.textAlignment  = NSTextAlignmentCenter;
    }
    return _label_title;
}

-(UIImageView *)imageView_background{
    if (!_imageView_background) {
        _imageView_background = [UIImageView new];
        _imageView_background.image = [UIImage imageNamed:@"Background"];
    }
    return _imageView_background;
}

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
        _view_segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 49+SafeTop, kScreenWidth-15*2, 74) segmentStyle:style delegate:self titles:@[@"待送货",@"历史送货单"] titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            [weakSelf scrollTopageWithIndex:index];
        }];
        _view_segment.backgroundColor = color_lightDart_white;
        _view_segment.layer.masksToBounds = YES;
        _view_segment.layer.cornerRadius = 4;
    }
    return _view_segment;
}
-(ZJContentView *)view_content{
    if (!_view_content) {
        CGFloat headHeight = 147-20+SafeTop;

        _view_content = [[ZJContentView alloc] initWithFrame:CGRectMake(0, headHeight, kScreenWidth, self.view.frame.size.height-headHeight) segmentView:self.view_segment parentViewController:self delegate:self];
    }
    return _view_content;
}


@end
