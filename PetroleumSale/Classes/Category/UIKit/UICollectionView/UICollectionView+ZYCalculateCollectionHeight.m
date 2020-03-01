//
//  UICollectionView+ZYCalculateCollectionHeight.m
//  YHEnterpriseB2B
//
//  Created by zhangyong on 2019/3/12.
//  Copyright © 2019年 yh. All rights reserved.
//

#import "UICollectionView+ZYCalculateCollectionHeight.h"
#import "NSString+RECategory.h"

@implementation UICollectionView (ZYCalculateCollectionHeight)

+(CGFloat)getContentViewHeightWithDataSource:(NSArray *)dataSource
                                    textFont:(UIFont *)font
                         collectionViewWidth:(CGFloat)width
                                   rowHeight:(CGFloat)rowHeight
                                     minLine:(CGFloat)minLine
                                     minItem:(CGFloat)minItem{
    
    //
    CGFloat CollectionWidth = width;//kScreenWidth-30;
    CGFloat sum = 0;
    CGFloat rowCount = 0;
    for (int i = 0; i<dataSource.count; i++) {
        NSString *title = dataSource[i];
//        CGFloat width = [UILabel ff_lableWithTextStringWidth:title andTextFont:font andLableHeight:20];
        CGFloat width = [title widthWithFont:font];
        CGFloat cellWidth = width+28;
        if (i == 0) {
            sum+= cellWidth;
        }else{
            sum  += (cellWidth+minItem);
        }
        if (sum>CollectionWidth) {
            rowCount++;
            sum = cellWidth;
        }
    }
    if (sum>0) {
        rowCount++;
    }
    CGFloat heigth = rowCount*rowHeight+minLine*(rowCount-1);
    if (heigth <=0 ) {
        heigth = 0;
    }
    return heigth;

}

@end
