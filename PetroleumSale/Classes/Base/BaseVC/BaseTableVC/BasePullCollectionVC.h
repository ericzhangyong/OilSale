//
//  FSBasePullCollectionVC.h
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseCollectionVC.h"
#import "BasePullDelegate.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasePullCollectionVC : BaseCollectionVC<BasePullDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>


@property (nonatomic,assign) NSUInteger pullPageIndex;

@property (nonatomic,assign) BOOL isLoading;

@property (nonatomic,weak) id<BasePullDelegate> pullDelegate;


/**
 *  加载网络数据  需要重载
 */
-(void)loadWebDataSource;

/**
 *  下拉 调用
 */
-(void)loadTableViewHeader;
/**
 *  上拉 调用
 */
-(void)loadTableViewFooter;

/**
 *  加载完成 调用
 *  @param count 获取到的数据数。错误 传 -1
 */
-(void)endRefreshingWithCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
