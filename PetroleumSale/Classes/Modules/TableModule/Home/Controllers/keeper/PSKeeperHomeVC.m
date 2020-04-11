//
//  PSKeeperHomeVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/2.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSKeeperHomeVC.h"
#import "PSKeeperHomeViewModel.h"
#import "PSKeeperHomeCell.h"
#import "PSKeeperHomeHeaderView.h"
#import "BaseBlueNavView.h"
#import "PSKeeperCrateOrderVC.h"

@interface PSKeeperHomeVC ()
@property (nonatomic,strong) PSKeeperHomeViewModel *keepViewModel;
@property (nonatomic,strong) PSKeeperHomeHeaderView *view_header;
@property (nonatomic,strong) BaseBlueNavView *view_nav;

@end

@implementation PSKeeperHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}

-(void)initBaseViews{
    
    self.view.backgroundColor = color_lightDart_f3f3f3;
    [self.view addSubview:self.view_nav];
    self.view_nav.title = @"仓库";
    [self.view_nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(MasNavHeight + 46);
    }];
    [self.view insertSubview:self.view_nav atIndex:0];
    WEAK_SELF;
    [self.view_nav showRightBtnWithTitle:@"创建进货订单" callBack:^(BOOL isClick) {
        
        PSKeeperCrateOrderVC *createOrderVC = [PSKeeperCrateOrderVC new];
        [weakSelf.navigationController pushViewController:createOrderVC animated:YES];
    }];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSKeeperHomeCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSKeeperHomeCell.class)];
    
    [self reloadHeaderView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(MasNavHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
}
-(void)reloadHeaderView{
    
    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 0, kScreenWidth, 86);
    [header addSubview:self.view_header];
    self.view_header.frame = header.bounds;
    self.tableView.tableHeaderView = header;
    self.view_header.label_todayPrice.text = self.keepViewModel.oil_price;
    self.view_header.label_oilCount.text = self.keepViewModel.oil_total;
     
}

-(UITableViewStyle)re_tableViewStryle{
    return UITableViewStyleGrouped;
}

-(void)loadWebDataSource{
    
    WEAK_SELF;
    [self.keepViewModel requestHomelistWithPage:self.pullPageIndex Complete:^(BOOL isFinished, NSArray * _Nonnull dataArr) {
        
        if (isFinished) {
            [weakSelf reloadHeaderView];
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshingWithCount:dataArr.count];
        }else{
            [weakSelf endRefreshingWithCount:-1];
        }
    }];
}

#pragma mark- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.keepViewModel.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *view = [UIView new];
    view.backgroundColor  = [UIColor clearColor];

    UIView *containView = [UIView new];
    containView.frame = CGRectMake(15, 0, kScreenWidth-15*2, 10);
    containView.backgroundColor  = color_F3F3F3;
    [view addSubview:containView];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section+1 == self.keepViewModel.dataSource.count) {
        return 10;
    }else{
        return 0.001;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor  = [UIColor clearColor];

    UIView *containView = [UIView new];
    containView.frame = CGRectMake(15, 0, kScreenWidth-15*2, 10);
    containView.backgroundColor  = color_F3F3F3;
    [view addSubview:containView];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSKeeperHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSKeeperHomeCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger index = indexPath.section;
    
    cell.label_orderNum.text = [self.keepViewModel ps_getOrderNumAtIndex:index];
    cell.label_variety.text = [self.keepViewModel ps_getVarityAtIndex:index];
    cell.label_totalWeight.text = [self.keepViewModel ps_getWeightAtIndex:index];
    cell.label_time.text = [self.keepViewModel ps_getTimeAtIndex:index];
    cell.label_number.text = [self.keepViewModel ps_getCodeAtIndex:index];
    cell.label_density.text =[self.keepViewModel ps_getDensityAtIndex:index];
    cell.label_pinxiang.text = [self.keepViewModel ps_getPinXiangAtIndex:index];
    
    return cell;
}


#pragma mark- keeper
-(PSKeeperHomeViewModel *)keepViewModel{
    if (!_keepViewModel) {
        _keepViewModel = [PSKeeperHomeViewModel new];
    }
    return _keepViewModel;
}

-(PSKeeperHomeHeaderView *)view_header{
    if (!_view_header) {
//        _view_header = [[PSKeeperHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 96)];
        _view_header = [PSKeeperHomeHeaderView initNibView];
        _view_header.frame = CGRectMake(0, 0, kScreenWidth, 96);
    }
    return _view_header;
}

-(BaseBlueNavView *)view_nav{
    if (!_view_nav) {
        _view_nav = [BaseBlueNavView initViewWithFrame:CGRectMake(0, 0, kScreenWidth, MasNavHeight+46)];
    }
    return _view_nav;
}



@end
