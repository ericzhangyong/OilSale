//
//  PSOrderConfirmVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/3.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSOrderConfirmVC.h"
#import "PSConfirmHeaderView.h"
#import "PSConfirmCell.h"
#import "UIImageView+BaseWebCache.h"
#import "PSConfirmFooterView.h"
#import "PSWareHousePickerView.h"
#import "PSAgreementVC.h"
#import "PSOrderConfirmSuccessView.h"
#import "REMainTabManager.h"
#import "PSAddNewAddressVC.h"
#import "PSAddresReceiveModel.h"

@interface PSOrderConfirmVC ()<BasePickerViewDelegate>

@property (nonatomic,strong) PSConfirmHeaderView *view_header;
@property (nonatomic,strong) PSConfirmFooterView *view_footer;
@property (nonatomic,strong) PSShopCartViewModel *cartViewModel;

@property (nonatomic,strong) PSWareHousePickerView *view_picker;
@property (nonatomic,strong) PSOrderConfirmSuccessView *view_success;

@end

@implementation PSOrderConfirmVC

-(instancetype)initWithShopCartViewModel:(PSShopCartViewModel *)cartViewModel{
    if (self = [super init]) {
        
        NSArray *data = cartViewModel.ps_getSelectedDataArr;
        self.cartViewModel  = [cartViewModel copy];
        [self.cartViewModel.dataSource setArray:data];
//        self.cartViewModel.rec_addr_list = cartViewModel.rec_addr_list;
//        self.cartViewModel.warehouse_list = cartViewModel.warehouse_list;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)initNavView{
    
    self.navigationItem.title= @"确认订单";
    
}

-(void)initBaseViews{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSConfirmCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSConfirmCell.class)];
    
    [self reloadHeaderAndFooter];
    
}

-(void)reloadHeaderAndFooter{
    
    self.tableView.backgroundColor = color_F3F3F3;
    UIView *headerView  = [UIView new   ];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 100);
    [headerView addSubview:self.view_header];
    self.tableView.tableHeaderView = headerView;
    PSAddresReceiveModel *addressModel =  [self.cartViewModel ps_getAddressModel];
    self.view_header.label_name.text= addressModel.consignee;
    self.view_header.label_phone.text = addressModel.phone_num;
    self.view_header.label_region.text = addressModel.region;
    self.view_header.label_completeAdd.text = addressModel.complete_address;
    
    BOOL isHidden = YES;
    if ([BaseVerifyUtils isNullOrSpaceStr:addressModel.rec_addr_id]) {
        isHidden = NO;
    }
    self.view_header.btn_AddAddressNotice.hidden = isHidden;
    
    WEAK_SELF;
    self.view_header.selectAddBlock = ^(BOOL isClick) {
        if (isClick) {
            
        
            PSAddNewAddressVC *address= [[PSAddNewAddressVC alloc] init];
            address.selectAddressBlock = ^(BOOL isSelect,PSAddresReceiveModel *address) {
                
                FSAddNewViewModel *addressViewModel = [FSAddNewViewModel new];
                [addressViewModel requestAddressParamMessageComplete:^(BOOL isFinished,PSAddresReceiveModel *model) {
                    if (isFinished) {
                        
                        [weakSelf.cartViewModel ps_setAddressModelWithModel:model];
                        [weakSelf reloadHeaderAndFooter];
                    }
                }];
                
            };
            [weakSelf.navigationController pushViewController:address animated:YES];
        }
    };
    
    
    UIView *footerView  = [UIView new   ];
    footerView.frame = CGRectMake(0, 0, kScreenWidth, 347);
    self.view_footer.frame = footerView.bounds;
    [footerView addSubview:self.view_footer];
    self.tableView.tableFooterView = footerView;
    self.view_footer.label_totalMoney.attributedText = self.cartViewModel.ps_getSelectedTotalMoneyAtConfirmVC;
    self.view_footer.label_wareHouse.text = self.cartViewModel.ps_getSelectedWareHouseName;
    
    self.view_footer.didClick = ^(FooterClickType clickType) {
        if (clickType == FooterClickTypeSelectWareHouse) {
            [weakSelf showPickerView];
        }else if (clickType == FooterClickTypeAggreeBtn){
            weakSelf.cartViewModel.isAggree = !weakSelf.cartViewModel.isAggree;
        }else if (clickType == FooterClickTypeAggressment){
            [weakSelf showAggreemengtVC];
        }else if (clickType == FooterClickTypeConfirm){
            [weakSelf confirmAction];
        }
    };
    
}

-(void)showAggreemengtVC{
    
    PSAgreementVC *agreeVC =[[PSAgreementVC alloc] init];
    
    [self.navigationController pushViewController:agreeVC animated:YES];
}

-(void)confirmAction{
    
    if (!self.cartViewModel.isAggree) {
        [MBProgressHUD toastMessageAtMiddle:@"请同意购买协议！"];
        return;
    }
    WEAK_SELF;
    NSString *payType = @"1";
    if (self.view_footer.control_accountOidCardd.selected) {//加油卡
        payType = @"2";
    }
    [self.cartViewModel requesShopCartEditType:1 pay_type:payType Complete:^(BOOL isFinished) {
        if (isFinished) {
            
            [weakSelf showConfirmSuccessView];
            [[NSNotificationCenter defaultCenter] postNotificationName:FSNotificationConfirmOrderSuccesKey object:nil];
        }
    }];
}

-(void)showConfirmSuccessView{
    
    WEAK_SELF;
    [self.view addSubview:self.view_success];
    self.view_success.confirmClick = ^(NSInteger clickType) {
        [weakSelf.view_success removeFromSuperview];
        if (clickType == 1) {//查看订单
            REMainTabManager *manager = [REMainTabManager sharedManager];
            manager.tabBarController.selectedIndex = 1;
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else if (clickType == 2){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
}


-(void)showPickerView{
    
    [self.view_picker.dataSource setArray:self.cartViewModel.warehouse_list];
    [self.view_picker showPickerView];
    
}
#pragma mark- BasePickerViewDelegate
-(void)onItemSelectedData:(id)data{
    
    self.cartViewModel.currentWareHouseSelectIndex = self.view_picker.currentIndex;
    [self reloadHeaderAndFooter];
}

#pragma mark- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cartViewModel.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSConfirmCell.class) forIndexPath:indexPath];
    [cell.imageView_header setImageWithUrl:[self.cartViewModel ps_getImageUrlAtIndex:indexPath.row] placeholder:defaultHolder160_160];
    cell.label_title.text = [self.cartViewModel ps_getTitlelAtIndex:indexPath.row];
    cell.label_price.text  = [self.cartViewModel ps_getPriceAtIndex:indexPath.row];
    return cell;
}




#pragma mark- lazy
-(PSShopCartViewModel *)cartViewModel{
    if (!_cartViewModel) {
        _cartViewModel = [PSShopCartViewModel   new];
    }
    return _cartViewModel;
}
-(PSConfirmHeaderView *)view_header{
    if (!_view_header) {
        _view_header = [PSConfirmHeaderView initNibView];
        _view_header.frame = CGRectMake(0, 0, kScreenWidth, 100);
    }
    return _view_header;
}

- (PSConfirmFooterView *)view_footer{
    if (!_view_footer) {
        _view_footer = [PSConfirmFooterView initNibView];
    }
    return _view_footer;
}
-(PSWareHousePickerView *)view_picker{
    if (!_view_picker) {
        _view_picker = [[PSWareHousePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _view_picker.delegate = self;
    }
    return _view_picker;
}
-(PSOrderConfirmSuccessView *)view_success{
    if (!_view_success) {
        _view_success = [PSOrderConfirmSuccessView initViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _view_success;
}

@end
