//
//  PSKeeperOrderVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSKeeperOrderVC.h"
#import "PSKeeperOrderViewModel.h"
#import "PSKeepOrderCell.h"
#import "PSKeepOrderHeaderView.h"

@interface PSKeeperOrderVC ()

@property (nonatomic,strong) PSKeeperOrderViewModel *keeperOrder;
@property (nonatomic,strong) PSKeepOrderHeaderView *view_header;
@end

@implementation PSKeeperOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}

-(void)initNavView{
    self.navigationItem.title = @"订单";
    self.view.backgroundColor = color_lightDart_f3f3f3;
}

-(void)initBaseViews{
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSKeepOrderCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSKeepOrderCell.class)];
    
    [self reloadHeaderView];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.keeperOrder requestOrderListWithPage:self.pullPageIndex complete:^(BOOL isFinished, NSArray * _Nonnull dataArr) {
        if (isFinished) {
            
            [weakSelf reloadHeaderView];
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshingWithCount:dataArr.count];
        }else{
            [weakSelf endRefreshingWithCount:-1];
        }
    }];

}
-(UITableViewStyle)re_tableViewStryle{
    return UITableViewStyleGrouped;
}

-(void)reloadHeaderView{
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 61);
    [view addSubview:self.view_header];
    self.view_header.frame = view.bounds;
    self.tableView.tableHeaderView = view;
    self.view_header.label_count.text = self.keeperOrder.ps_getCurrentOidCount;
}


#pragma mark- TableVIewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.keeperOrder.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section+1 == self.keeperOrder.dataSource.count) {
        return 10;
    }
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 161;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSKeepOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSKeepOrderCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger index = indexPath.section;
    cell.label_orderTime.text = [self.keeperOrder ps_orderTimeAtIndex:index];
    cell.label_tieBucket.text = [self.keeperOrder ps_orderTieBucketCountAtIndex:index];
    cell.label_aggreLastBucket.attributedText = [self.keeperOrder ps_orderTieLastBucketCountAtIndex:index];
    cell.label_aggreeLastDunBucket.attributedText = [self.keeperOrder ps_orderDunLastBucketCountAtIndex:index];
    
    
    WEAK_SELF;
    cell.btnClick = ^(NSInteger clickType) {
        
        if (clickType == 1) {
            [weakSelf.keeperOrder requestAggreeStatus:NO complete:^(BOOL isFinished) {
                [weakSelf loadWebDataSource];
            }];
        }else{
            [weakSelf.keeperOrder requestAggreeStatus:YES complete:^(BOOL isFinished) {
                [weakSelf loadWebDataSource];
            }];
        }
    };
    
    
    return cell;
}




#pragma mark- lazy

-(PSKeeperOrderViewModel *)keeperOrder{
    if (!_keeperOrder) {
        _keeperOrder = [PSKeeperOrderViewModel new];
    }
    return _keeperOrder;;
}
-(PSKeepOrderHeaderView *)view_header{
    if (!_view_header) {
        _view_header = [PSKeepOrderHeaderView initNibView];
    
    }
    return _view_header;
}



@end
