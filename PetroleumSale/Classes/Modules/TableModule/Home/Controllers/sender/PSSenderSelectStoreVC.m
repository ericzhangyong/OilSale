//
//  PSSenderSelectStoreVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/5/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSSenderSelectStoreVC.h"
#import "PSDriverCell.h"
#import "PSDriverViemModel.h"
#import "PSDriverBottomView.h"
#import "PSSenderDriverOrderListVC.h"
#import "PSSenderStoreCell.h"
#import "PSSenderStoreListRequest.h"
#import "PSDriverModel.h"
#import "PSSenderDriverSelectVC.h"
#import "PSSenderSendRequest.h"
#import "MMAlertView+BaseAlertManger.h"

@interface PSSenderSelectStoreVC ()
@property (nonatomic,strong) PSDriverBottomView *view_bottom;

//@property (nonatomic,strong) PSDriverViemModel *driverViewModel;
@property (nonatomic,assign) NSInteger currentSelectIndex;
/// 是否选过
@property (nonatomic,assign) BOOL isHaveSelected;

@property (nonatomic,strong) NSString *selectDriverId;
/// <#des#>
@property (nonatomic,copy) NSArray *orderIdArr;
@end

@implementation PSSenderSelectStoreVC
-(instancetype)initWithOrderIdArr:(NSArray *)orderIdArr{
    if (self = [super init]) {
        self.orderIdArr = orderIdArr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
    // Do any additional setup after loading the view.
}

-(void)initNavView{
    
    self.navigationItem.title = @"选择仓库";
    
    [self rightBarButtonWithText:@"选择司机" textColor:color_666666 textFont:[UIFont systemWEPingFangRegularOfSize:15] target:self selector:@selector(rightClick)];
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSSenderStoreCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSSenderStoreCell.class)];
}

-(void)rightClick{

    PSSenderDriverSelectVC *driverList = [[PSSenderDriverSelectVC alloc] init];
    driverList.selectCompleteBlock = ^(NSString * _Nonnull dirverId) {
        if (![BaseVerifyUtils isNullOrSpaceStr:dirverId]) {
            self.selectDriverId = dirverId;
        }
    };
    [self.navigationController pushViewController:driverList animated:YES];

}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    PSSenderStoreListRequest *listReqeust = [PSSenderStoreListRequest new];
    [listReqeust postRequestCompleted:^(BaseResponse * _Nonnull response) {
        
        NSArray *data = [PSDriverModel convertModelWithJsonArr:response.result];
        [self.dataSource setArray:data];
        [self endRefreshingWithCount:-1];
        [self.tableView reloadData];
    }];
    
}
-(void)goToSendDidClick{
    
    if (!self.isHaveSelected) {
        [MBProgressHUD toastMessageAtMiddle:@"请选择仓库"];
        return;
    }
    
    PSSenderSendRequest *sendRequest =[ PSSenderSendRequest new];
    sendRequest.driver_id = self.selectDriverId.integerValue;
    sendRequest.way_bill_id = self.orderIdArr;
    if (self.currentSelectIndex<self.dataSource.count) {
        PSDriverModel *model = self.dataSource[self.currentSelectIndex];
        sendRequest.storekeeper_id = model.storekeeper_id.integerValue;
    }
    [sendRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            [MMAlertView showWithTitle:@"派单成功！" sureBtn:@"知道了"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
//    [self.driverViewModel requestSendDeliveryComplete:^(BOOL isFinished) {
//        if (isFinished) {
//
//            [MBProgressHUD toastMessageAtMiddle:@"派单成功"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:FSNotificationSendSuccessNotifiKey object:nil];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
}
#pragma mark- UITableViewDelegate dataSOurce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSSenderStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSSenderStoreCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger index = indexPath.section;
    PSDriverModel *model = self.dataSource[index];
    
    
    
    cell.label_title.text = model.storekeeper_name;
    cell.label_content.text = [NSString stringWithFormat:@"地址:%@",model.warehouse_address];
    cell.cellIsSelected = model.isSelcted;
    

//    cell.label_driverName.text = [self.driverViewModel ps_getDriverNameAtIndex:indexPath.section];
//    cell.label_count.text = [self.driverViewModel ps_getDriverOrderCountAtIndex:indexPath.section];
//    cell.btn_select.selected = [self.driverViewModel ps_getDriverIsSelectedAtIndex:indexPath.section];
//    WEAK_SELF;
//    cell.selectDidClick = ^(BOOL isSelected){
//        [weakSelf.driverViewModel ps_setDriverIsSelectedAtIndex:indexPath.section isSelected:isSelected];
//        [weakSelf.tableView reloadData];
//    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    PSDriverModel *model = self.dataSource[indexPath.section];
    if (!model.isSelcted) {
        for (int i = 0; i<self.dataSource.count; i++) {
            PSDriverModel *model = self.dataSource[i];
            if (indexPath.row == i) {
                model.isSelcted = YES;
            }else{
                model.isSelcted = NO;
            }
        }
        [self.tableView reloadData];
    }
    self.isHaveSelected = YES;
//    PSSenderDriverOrderListVC *orderList = [[PSSenderDriverOrderListVC alloc] init];
//    orderList.driverViewModel = [self.driverViewModel copy];
//    orderList.driverViewModel.currentDriverIndex = indexPath.section;
//    [self.navigationController pushViewController:orderList animated:YES];
}

#pragma mark- lazy
//-(PSDriverViemModel *)driverViewModel{
//    if (!_driverViewModel) {
//        _driverViewModel= [PSDriverViemModel new];
//    }
//    return _driverViewModel;
//}
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
