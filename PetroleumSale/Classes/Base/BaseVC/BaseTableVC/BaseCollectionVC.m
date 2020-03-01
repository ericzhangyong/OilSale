//
//  FSBaseCollectionVC.m
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseCollectionVC.h"

@interface BaseCollectionVC ()

@end

@implementation BaseCollectionVC

- (void)viewDidLoad {
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    [super viewDidLoad];
}

#pragma mark - 懒加载属性


-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) collectionViewLayout:self.flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //        if (@available(iOS 11.0, *)){
        //            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //        }
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowlayout
{
    if (!_flowlayout) {
        _flowlayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //        _flowlayout.sectionInset = UIEdgeInsetsZero;
        _flowlayout.minimumLineSpacing = 3;//5;
        _flowlayout.minimumInteritemSpacing = 3;//2.5;
    }
    return _flowlayout;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

#pragma mark - UITableView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
