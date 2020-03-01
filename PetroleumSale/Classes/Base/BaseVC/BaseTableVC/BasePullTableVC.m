//
//  FSBasePullTableVC.m
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullTableVC.h"
#import "BaseRefreshFooter.h"
#import "AFNetworkReachabilityManager.h"

@interface BasePullTableVC ()
{
    BOOL _isTaped;
    BOOL _isFirstLoad;
}
@end

@implementation BasePullTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableViewAdditional];
    _pullPageIndex  = 1;
    self.defaultPageSize = requestPageCount;
}

#pragma mark - 上下拉 及 空数据配置
-(void)setupTableViewAdditional
{
    self.pullDelegate = self;
    if (_pullDelegate) {
        if ([_pullDelegate needPullHeader]) {
            //            self.tableView.mj_header = [FFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTableViewHeader)];
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTableViewHeader)];
            
        }
        
        if ([_pullDelegate needPullFooter]) {
            self.tableView.mj_footer = [BaseRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadTableViewFooter)];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if ([_pullDelegate needEmptyTip]) {
            self.tableView.emptyDataSetSource = self;
            self.tableView.emptyDataSetDelegate = self;
            [self needAfterTap];
        }
    }
}

-(void)loadTableViewHeader
{
    if (_pullPageIndex == requestPageStart && _isLoading && self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
        return;
    }
    _pullPageIndex = requestPageStart;
    [self loadWebDataSource];
}
-(void)loadTableViewFooter
{
    if (_isLoading) {
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    _pullPageIndex++;
    [self loadWebDataSource];
}
-(void)loadWebDataSource
{
    _isLoading = YES;
    if (self.tableView.isEmptyDataSetVisible) {
        [self.tableView reloadEmptyDataSet];
    }
}
-(void)endRefreshingWithCount:(NSInteger)count
{
    _isLoading = NO;
    //    [self.tableView reloadEmptyDataSet];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (count < self.defaultPageSize-3) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.tableView.mj_footer resetNoMoreData];
    }
    [self.tableView reloadEmptyDataSet];
}

-(BOOL)needPullHeader
{
    return YES;
}
-(BOOL)needPullFooter
{
    return YES;
}
-(BOOL)needEmptyTip
{
    return YES;
}

-(BOOL)isShouldShowFFCustomEmptyView {
    return NO;
}


#pragma mark - DZNEmptyDataSetSource Methods

- (UIView *)viewForEmptyNoList
{
    return nil;
}
#pragma mark- CustomViewDelegate
-(UIImage *)ff_imageForCustomEmptyView {
    
    return [self imageForEmptyNoList];
}
-(NSString *)ff_buttonLeftLabelTitleForCustomEmpytView{
    return @"搜索中";
}
-(NSString *)ff_descriptionTitleForCustomEmptyView {
    return [self stringForEmptyNoList];
}
-(NSString *)ff_buttonTitleForCustomEmptyView{
    return nil;
}
-(UIImage *)ff_buttonBackgroundImageForCustomEmptyView {
    return nil;
}
#pragma mark- DZNEmptyDataSetSource
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_isLoading) {
        return nil;;
    }else if([AFNetworkReachabilityManager sharedManager].isReachable){
        if ([self isShouldShowFFCustomEmptyView]) {
            return [self viewForEmptyNoList];
        }
        return nil;
    }else{
        return nil;
    }
    return nil;
}

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.tableView.tableHeaderView) {
        return self.tableView.tableHeaderView.frame.size.height/2;
    }
    return 0.0f;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_isLoading) {
        return nil;;
    }else if([AFNetworkReachabilityManager sharedManager].isReachable){
        
        return [self imageForEmptyNoList];
    }else{
        return [self imageForNoNetEmptyNoList];
    }
    return nil;
}
- (UIImage *)imageForEmptyNoList
{
    return [UIImage imageNamed:@"qb_icon_zwlr"];
}

-(UIImage *)imageForNoNetEmptyNoList{
    return [UIImage imageNamed:@"qb_icon_wlyc"];
}
-(NSString*)stringForEmptyNoList
{
    return @"暂无数据";
}
-(NSString*)stringForNoNetEmptyNoList{
    return @"网络异常";
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]};
    if (_isLoading) {
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"努力加载中..." attributes:dic];
        return attr;
    }else if([AFNetworkReachabilityManager sharedManager].isReachable){
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:[self stringForEmptyNoList] attributes:dic];
        return attr;
    }else{
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:[self stringForNoNetEmptyNoList] attributes:dic];
        return attr;
    }
    return nil;
}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldShow:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
    //    if (self.tableView.tableHeaderView) {
    //        return YES;
    //    }
    //    return NO;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (_isTaped) {
        return;
    }
    [self loadTableViewHeader];
    [self needAfterTap];
}


-(void)needAfterTap
{
    _isTaped = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_isTaped = NO;
    });
}
-(void)dealloc{
    
}

- (UIImage *)ff_loadingGifImage
{
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 11; i++) {
        UIImage *tImage = [UIImage imageNamed:[NSString stringWithFormat:@"nolist_loading_0%d",i]];
        if (tImage) {
            [images addObject:tImage];
        }
    }
    UIImage *animatedImage = [UIImage animatedImageWithImages:images duration:1.0];
    return animatedImage;
}
@end
