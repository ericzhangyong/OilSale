//
//  PSAccountVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSAccountVC.h"
#import "PSAccountHeaderView.h"
#import "PSAccountCell.h"
#import "PSAccountInfoRequest.h"
#import "PSAccountInfoModel.h"
#import "BaseVerifyUtils.h"
#import "PSAccountHisVC.h"

@interface PSAccountVC ()

@property (nonatomic,strong) PSAccountHeaderView *view_header;

@property (nonatomic,strong) PSAccountInfoModel *accountInfoModel;
@end

@implementation PSAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}

-(void)initNavView{
    
    self.navigationItem.title = @"余额和对账单";
}
-(void)initBaseViews{
    

    self.tableView.backgroundColor = color_lightDart_white;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSAccountCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSAccountCell.class)];

    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 70);
    [view addSubview:self.view_header];
    self.tableView.tableHeaderView = view;
    
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    PSAccountInfoRequest *accountInfo =[PSAccountInfoRequest new];
    [accountInfo postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            weakSelf.accountInfoModel = [PSAccountInfoModel convertModelWithJsonDic:response.result];
            [weakSelf reloadHeaderView];
            [weakSelf.tableView reloadData];
        }
        [weakSelf endRefreshingWithCount:-1];
    }];
}

-(void)reloadHeaderView{
    
    NSString *account_balance = self.accountInfoModel.account_balance;
//    NSString *fuel_card_balance = self.accountInfoModel.fuel_card_balance;
    if (![BaseVerifyUtils isNullOrSpaceStr:account_balance]) {
        self.view_header.label_accountBalance.text = account_balance;
    }
    
    WEAK_SELF;
    self.view_header.restMoreClik = ^(BOOL isClick) {
        PSAccountHisVC *his = [[PSAccountHisVC alloc] initWithMoney:self.accountInfoModel.account_balance];
        [weakSelf.navigationController pushViewController:his animated:YES];
    };
//    if (![BaseVerifyUtils isNullOrSpaceStr:fuel_card_balance]) {
//        self.view_header.label_accountFarpBalance.text = fuel_card_balance;
//    }
}

#pragma mark- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.accountInfoModel.bill_list.count>0?1:0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.accountInfoModel.bill_list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 211;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 50);
    view.backgroundColor = color_lightDart_f3f3f3;
    UILabel *label = [UILabel new];
    label.text = @"对账单";
    label.textColor = color_lightDart_333333;
    label.font  = [UIFont systemWEPingFangRegularOfSize:15];
    [view addSubview:label];
    label.frame = CGRectMake(15, 15, kScreenWidth-30, 20);
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSAccountCell.class) forIndexPath:indexPath];

    if (indexPath.row<self.accountInfoModel.bill_list.count) {
        PSAccountBillModel *billModel = self.accountInfoModel.bill_list[indexPath.row];
        
        
        cell.label_title.text  = [NSString stringWithFormat:@"%@ x %@",billModel.bucket_type,billModel.buy_num];
        cell.label_accoutBalance.text = [NSString stringWithFormat:@"%@",billModel.amount];
        cell.label_time.text = [NSString stringWithFormat:@"扣款时间:%@",billModel.pay_time];
        cell.label_payType.text = billModel.pay_type;
        cell.label_oilCount.text = [NSString stringWithFormat:@"买油的升数：%@",billModel.real_volume];
        
        cell.label_bucketCount.text = [NSString stringWithFormat:@"价格：%@",billModel.unit_price];
        cell.label_tieCount.text = [NSString stringWithFormat:@"欠铁桶数量：%@",billModel.owe_bucket_number];
        cell.label_isNeddGun.text = [NSString stringWithFormat:@"是否需要加油枪：%@",billModel.buy_nozzle];
        cell.label_gunCount.text = [NSString stringWithFormat:@"欠加油机数：%@",billModel.owe_nozzle_number];
        cell.label_dirverName.text = [NSString stringWithFormat:@"送货司机姓名：%@",billModel.driver_name];
        cell.label_orderTime.text = [NSString stringWithFormat:@"下单时间：%@",billModel.buy_time];
        cell.label_price.text = [NSString stringWithFormat:@"欠吨桶数量：%@",billModel.owe_ibc_number];
        cell.label_sendTime.text = [NSString stringWithFormat:@"送货时间：%@",billModel.operate_time];
        
    }
    return cell;
}


#pragma mark- layz
-(PSAccountHeaderView *)view_header{
    if (!_view_header) {
        _view_header = [PSAccountHeaderView initNibView];
        _view_header.frame = CGRectMake(0, 0, kScreenWidth, 70);
    }
    return _view_header;
}


@end
