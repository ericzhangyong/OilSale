//
//  UICollectionView+ZYCalculateCollectionHeight.h
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/3/12.
//  Copyright © 2019年 yh. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (ZYCalculateCollectionHeight)

/**
 计算collectionview的动态高度

 @param dataSource 数据数组
 @param font font
 @param width collectionviewWidth
 @param minLine 最小行距
 @param minItem 最小item间距
 @return 高度
 */
+(CGFloat)getContentViewHeightWithDataSource:(NSArray *)dataSource
                                    textFont:(UIFont *)font
                         collectionViewWidth:(CGFloat)width
                                   rowHeight:(CGFloat)rowHeight                                     minLine:(CGFloat)minLine
                                     minItem:(CGFloat)minItem;
@end

NS_ASSUME_NONNULL_END
