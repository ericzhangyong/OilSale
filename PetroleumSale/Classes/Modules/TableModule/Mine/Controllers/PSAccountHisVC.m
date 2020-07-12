//
//  PSAccountHisVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/7/12.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSAccountHisVC.h"
#import "PSAccountHisCell.h"
#import "PSAccountHisHeaderView.h"
#import "PSAccountInfoRequest.h"
#import "PSAccountInfoModel.h"

@interface PSAccountHisVC ()
@property (nonatomic,strong) PSAccountHisHeaderView *view_header;

@property (nonatomic,strong) PSAccountInfoModel *accountInfoModel;
@end

@implementation PSAccountHisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)initNavView{
    
    self.navigationItem.title = @"余额历史";
}
-(void)initBaseViews{
    

    self.tableView.backgroundColor = color_lightDart_white;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSAccountHisCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSAccountHisCell.class)];

    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 70);
    [view addSubview:self.view_header];
    self.tableView.tableHeaderView = view;
        
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
//    PSAccountInfoRequest *accountInfo =[PSAccountInfoRequest new];
//    [accountInfo postRequestCompleted:^(BaseResponse * _Nonnull response) {
//        if (response.isFinished) {
//
//            weakSelf.accountInfoModel = [PSAccountInfoModel convertModelWithJsonDic:response.result];
//            [weakSelf reloadHeaderView];
//            [weakSelf.tableView reloadData];
//        }
//        [weakSelf endRefreshingWithCount:-1];
//    }];
}

-(void)reloadHeaderView{
    
//    NSString *account_balance = self.accountInfoModel.account_balance;
//    NSString *fuel_card_balance = self.accountInfoModel.fuel_card_balance;
//    if (![BaseVerifyUtils isNullOrSpaceStr:account_balance]) {
//        self.view_header.label_accountBalance.text = account_balance;
//    }
//    if (![BaseVerifyUtils isNullOrSpaceStr:fuel_card_balance]) {
//        self.view_header.label_accountFarpBalance.text = fuel_card_balance;
//    }
}

#pragma mark- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;//self.accountInfoModel.bill_list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 50);
    view.backgroundColor = color_lightDart_f3f3f3;
    UILabel *label = [UILabel new];
    label.text = @"历史记录";
    label.textColor = color_lightDart_333333;
    label.font  = [UIFont systemWEPingFangRegularOfSize:15];
    [view addSubview:label];
    label.frame = CGRectMake(15, 15, kScreenWidth-30, 20);
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    PSAccountHisCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSAccountHisCell.class) forIndexPath:indexPath];
    
//    if (indexPath.row <self.accountInfoModel.bill_list.count) {
        PSAccountBillModel *billModel = self.accountInfoModel.bill_list[indexPath.row];
        NSString *content = [NSString stringWithFormat:@"充值金额：%@",@"xxxxxxx"];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemWEPingFangRegularOfSize:14],NSForegroundColorAttributeName:color_4084FF}];
        NSRange range = [content rangeOfString:@"充值金额："];
        if (range.location != NSNotFound) {
            [attr addAttributes:@{NSForegroundColorAttributeName:color_666666} range:range];
        }
        cell.label_accountMoney.attributedText = attr;
        cell.label_residue.text = [NSString stringWithFormat:@"%@元",@"37893.23"];//billModel.amount;
        cell.label_kouTime.text  = [NSString stringWithFormat:@"扣款时间:%@",@"2020.7.20"];//billModel.pay_time;
        cell.label_payType.text = @"余额";//billModel.pay_type;
//    }
    return cell;
}


#pragma mark- layz
-(PSAccountHisHeaderView *)view_header{
    if (!_view_header) {
        _view_header = [PSAccountHisHeaderView initNibView];
        _view_header.frame = CGRectMake(0, 0, kScreenWidth, 70);
    }
    return _view_header;
}


@end
