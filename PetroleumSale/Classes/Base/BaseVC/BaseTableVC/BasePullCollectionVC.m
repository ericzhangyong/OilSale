//
//  FSBasePullCollectionVC.m
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BasePullCollectionVC.h"
#import "BaseRefreshFooter.h"
#import "AFNetworkReachabilityManager.h"


@interface BasePullCollectionVC ()
{
    BOOL _isTaped;
    BOOL _isFirstLoad;
}
@end

@implementation BasePullCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableViewAdditional];
    _pullPageIndex = 1;
}

#pragma mark - 上下拉 及 空数据配置
-(void)setupTableViewAdditional
{
    self.pullDelegate = self;
    if (_pullDelegate) {
        if ([_pullDelegate needPullHeader]) {
            self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTableViewHeader)];
        }
        
        if ([_pullDelegate needPullFooter]) {
            self.collectionView.mj_footer = [BaseRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadTableViewFooter)];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        if ([_pullDelegate needEmptyTip]) {
            self.collectionView.emptyDataSetSource = self;
            self.collectionView.emptyDataSetDelegate = self;
            [self needAfterTap];
        }
    }
}
-(void)loadTableViewHeader
{
    if (_pullPageIndex == requestPageStart && _isLoading && self.collectionView.mj_header.isRefreshing) {
        [self.collectionView.mj_header endRefreshing];
        return;
    }
    _pullPageIndex = requestPageStart;
    [self loadWebDataSource];
}
-(void)loadTableViewFooter
{
    if (_isLoading) {
        [self.collectionView.mj_footer endRefreshing];
        return;
    }
    _pullPageIndex++;
    [self loadWebDataSource];
}
-(void)loadWebDataSource
{
    _isLoading = YES;
    if (self.collectionView.isEmptyDataSetVisible) {
        [self.collectionView reloadEmptyDataSet];
    }
    
}
-(void)endRefreshingWithCount:(NSInteger)count
{
    _isLoading = NO;
    //    [self.tableView reloadEmptyDataSet];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    if (count < requestPageCount - 3) {//requestPageCount*2 - 3)
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.collectionView.mj_footer resetNoMoreData];
    }
    if (self.collectionView.isEmptyDataSetVisible) {
        [self.collectionView reloadEmptyDataSet];
    }
    //    [self.collectionView reloadEmptyDataSet];
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
    if (self.collectionView) {
        return YES;
    }
    return NO;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    
    //    NSLog(@"%s",__FUNCTION__);
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
        _isTaped = NO;
    });
}


#pragma mark - DZNEmptyDataSetSource Methods

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

@end
