//
//  PSStationOrderListVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/1/18.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSStationOrderListVC.h"
#import "PSStationOrderCell.h"
#import "PSStationOrderHistoryCell.h"
#import "UIImageView+BaseWebCache.h"


@interface PSStationOrderListVC ()

@property (nonatomic,strong) PSPetrolOrderViewModel *stationViewModel;

@end

@implementation PSStationOrderListVC
-(instancetype)initWithListType:(PSStationOrderListType)listType{
    if (self = [super init]) {
        self.stationViewModel.listType = listType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}

-(void)initBaseViews{
    
    self.tableView.backgroundColor = color_F3F3F3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSStationOrderCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSStationOrderCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSStationOrderHistoryCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSStationOrderHistoryCell.class)];
}


-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.stationViewModel requestDataWithPage:self.pullPageIndex Complete:^(BOOL isFinished, NSArray * _Nonnull dataArr) {
        if (isFinished) {
            
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshingWithCount:dataArr.count];
        }else{
            [weakSelf endRefreshingWithCount:-1];
        }
    }];
}

#pragma mark- UITableViewDelegate UTIableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.stationViewModel.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.stationViewModel.ps_getStationOrderCellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = color_F3F3F3;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSStationOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSStationOrderCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger index = indexPath.section;
    cell.label_stationOrder.text = [self.stationViewModel ps_getStationOrderCodeAtIndex:index];
    [cell.imageView_pic setImageWithUrl:[self.stationViewModel ps_getStationorderImageAtIndex:index] placeholder:defaultHolder160_160];
    cell.label_carMsg.text = [self.stationViewModel ps_getStationOrderCarNumAtIndex:index];
    cell.label_petrolTime.text = [self.stationViewModel ps_getStationOrderTimeAtIndex:index];
    cell.label_address.text= [self.stationViewModel ps_getStationOrderAddressAtIndex:index];
    cell.label_petrolVolume.text=[self.stationViewModel ps_getStationOrderVolumeAtIndex:index];
    cell.label_petrolVolume.hidden = !self.stationViewModel.ps_getIsShowBottomPic;
    
    cell.view_pic.hidden = !self.stationViewModel.ps_getIsShowBottomPic;
    [cell.imageView_carNum setImageWithUrl:[self.stationViewModel ps_getStationOrderPicAtIndex:index row:0] placeholder:defaultHolder160_160];
    [cell.imageView_volume setImageWithUrl:[self.stationViewModel ps_getStationOrderPicAtIndex:index row:1] placeholder:defaultHolder160_160];

    
    return cell;
}

#pragma mark- lazy
-(PSPetrolOrderViewModel *)stationViewModel{
    if (!_stationViewModel) {
        _stationViewModel = [PSPetrolOrderViewModel new];
    }
    return _stationViewModel;
}

@end
