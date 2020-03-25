//
//  PSOrderPicCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/7.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSOrderPicCell.h"
#import "PSCollectionPicCell.h"
#import "UIImageView+BaseWebCache.h"

@interface PSOrderPicCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView_pic;

@property (weak, nonatomic) IBOutlet UILabel *label_density;
@property (weak, nonatomic) IBOutlet UILabel *label_volume;
@property (weak, nonatomic) IBOutlet UILabel *label_weight;

@property (nonatomic,copy) PSOrderViewModel *orderViewModel;
@property (nonatomic,assign) NSInteger orderIndex;
@property (nonatomic,assign) NSInteger row;

@end
@implementation PSOrderPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = color_lightDart_f3f3f3;
    self.collectionView_pic.delegate = self;
    self.collectionView_pic.dataSource =self;
    [self.collectionView_pic registerNib:[UINib nibWithNibName:NSStringFromClass(PSCollectionPicCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(PSCollectionPicCell.class)];
}


-(void)configWithOrderViewModel:(PSOrderViewModel *)orderViewModel
                     OrderIndex:(NSInteger)orderIndex
                            row:(NSInteger)row{
    _orderViewModel = orderViewModel;
    self.orderViewModel = orderViewModel;
    self.row = row;
    self.orderIndex = orderIndex;
    
    
    self.label_title.text = [orderViewModel ps_getImageModelTitleAtInex:self.orderIndex row:row];
    self.label_volume.text = [orderViewModel ps_getImageModelVolumeAtInex:self.orderIndex row:row];
    self.label_density.text = [orderViewModel ps_getImageModelDestinyAtInex:self.orderIndex row:row];
    self.label_weight.text = [orderViewModel ps_getImageModelWeightAtInex:self.orderIndex row:row];
    
    
    [self.collectionView_pic reloadData];
}

#pragma mark- UITableViewDelegate DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;//[self.orderViewModel ps_getImageModelAtInex:self.orderIndex row:self.row].pic_url.count;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth-30*3)*1.0/3.0;
    return CGSizeMake(width, width+30);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PSCollectionPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(PSCollectionPicCell.class) forIndexPath:indexPath];
    
    [cell.imageView_pic setImageWithUrl:[self.orderViewModel ps_getOrderPicImageUrlAtIndex:self.orderIndex row:self.row picIndex:indexPath.row] placeholder:defaultHolder160_160];
    NSString *title = @"油品确认";
    if (indexPath.row == 0) {
        title = @"油品确认";
    }else if (indexPath.row == 1){
        title = @"油品测量中";
    }else if (indexPath.row == 2){
        title = @"油量测量读数";
    }
    cell.label_title.text = title;
    return cell;
}


@end
