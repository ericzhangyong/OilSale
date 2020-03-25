//
//  PSSenderDriverSelectVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDriverSelectVC.h"
#import "PSDriverCell.h"
#import "PSDriverViemModel.h"
#import "PSDriverBottomView.h"
#import "PSSenderDriverOrderListVC.h"


@interface PSSenderDriverSelectVC ()
@property (nonatomic,strong) PSDriverBottomView *view_bottom;


@property (nonatomic,strong) PSDriverViemModel *driverViewModel;
@property (nonatomic,assign) NSInteger currentSelectIndex;
@end

@implementation PSSenderDriverSelectVC

-(instancetype)initWithOrderIdArr:(NSArray *)orderIdArr{
    if (self = [super init]) {
        self.driverViewModel.orderIdArr = orderIdArr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}

-(void)initNavView{
    
    self.navigationItem.title = @"选择司机";
}

-(void)initBaseViews{
    
  

    self.view_bottom.title = @"确定";
    [self.view addSubview:self.view_bottom];
    [self.view_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-SafeBottom);
        make.height.mas_equalTo(56);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view_bottom.mas_top);
        make.top.left.right.equalTo(self.view);
    }];
    
    self.tableView.backgroundColor = color_lightDart_f3f3f3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSDriverCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSDriverCell.class)];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.driverViewModel requestDriverListComplete:^(BOOL isFinished) {
        if (isFinished) {
            
            [weakSelf.tableView reloadData];
        }
    }];
}
-(void)goToSendDidClick{
    
    [self.driverViewModel requestSendDeliveryComplete:^(BOOL isFinished) {
        if (isFinished) {
            
            [MBProgressHUD toastMessageAtMiddle:@"派单成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:FSNotificationSendSuccessNotifiKey object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
#pragma mark- UITableViewDelegate dataSOurce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.driverViewModel.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSDriverCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSDriverCell.class) forIndexPath:indexPath];
    
    cell.label_driverName.text = [self.driverViewModel ps_getDriverNameAtIndex:indexPath.section];
    cell.label_count.text = [self.driverViewModel ps_getDriverOrderCountAtIndex:indexPath.section];
    cell.btn_select.selected = [self.driverViewModel ps_getDriverIsSelectedAtIndex:indexPath.section];
    WEAK_SELF;
    cell.selectDidClick = ^(BOOL isSelected){
        [weakSelf.driverViewModel ps_setDriverIsSelectedAtIndex:indexPath.section isSelected:isSelected];
        [weakSelf.tableView reloadData];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PSSenderDriverOrderListVC *orderList = [[PSSenderDriverOrderListVC alloc] init];
    orderList.driverViewModel = [self.driverViewModel copy];
    orderList.driverViewModel.currentDriverIndex = indexPath.section;
    [self.navigationController pushViewController:orderList animated:YES];
}

#pragma mark- lazy
-(PSDriverViemModel *)driverViewModel{
    if (!_driverViewModel) {
        _driverViewModel= [PSDriverViemModel new];
    }
    return _driverViewModel;
}
-(PSDriverBottomView *)view_bottom{
    if (!_view_bottom) {
        _view_bottom = [PSDriverBottomView initViewWithFrame:CGRectMake(0, kScreenHeight-SafeBottom-56, kScreenWidth, 56)];
        WEAK_SELF;
           _view_bottom.goToSendDidClick = ^{
               [weakSelf goToSendDidClick];
           };
    }
    return _view_bottom;
}

@end
