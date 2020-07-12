//
//  PSOrderListVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/2.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSOrderListVC.h"
#import "PSOrdelListCell.h"
#import "PSOrderViewModel.h"
#import "UIImageView+BaseWebCache.h"
#import "PSOrderPicVC.h"
#import "UIView+BaseCategory.h"
#import "PSAgreementVC.h"
#import "MMAlertView+BaseAlertManger.h"

@interface PSOrderListVC ()

@property (nonatomic,strong) PSOrderViewModel *orderViewModel;
@end

@implementation PSOrderListVC
-(instancetype)initWithListType:(PSOrderListType)listType{
    if (self = [super init]) {
        self.orderViewModel.listType = listType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)initBaseDatas{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebDataSource) name:FSNotificationConfirmOrderSuccesKey object:nil];
    if (self.orderViewModel.listType == PSOrderListTypeHistory) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebDataSource) name:FSNotificationConfirmReceiveSuccesKey object:nil];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadWebDataSource];
}

-(void)initBaseViews{
    
    self.tableView.backgroundColor = color_lightDart_f3f3f3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSOrdelListCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSOrdelListCell.class)];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.orderViewModel requestOrderListWithPage:self.pullPageIndex Complete:^(BOOL isFinished, NSArray * _Nonnull dataArr) {
        if (isFinished) {
            [weakSelf.tableView reloadData];
            [self endRefreshingWithCount:dataArr.count];
        }else{
            [self endRefreshingWithCount:-1];
        }
    }];
}

#pragma mark- UITableVIewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderViewModel.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 235;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSOrdelListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSOrdelListCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger index = indexPath.row;
    
    [cell.imageView_header setImageWithUrl:[self.orderViewModel ps_getImageUrlAtIndex:index] placeholder:defaultHolder160_160];
    cell.label_tax.text = [self.orderViewModel ps_getOrderTaxStatusAtIndex:index];
    cell.label_tax.hidden = ![self.orderViewModel ps_getIsShowOrderTaxStatusAtIndex:index];
    cell.label_title.text = [self.orderViewModel ps_getOrderNoAtIndex:index];
    cell.label_orderTime.text  = [self.orderViewModel ps_getOrderTimeAtIndex:index];
    cell.label_oidCount.text = [self.orderViewModel ps_getBuckerTypeAtIndex:index];
    cell.label_orderStauts.text = [self.orderViewModel ps_getOrderStatusAtIndex:index];
    cell.label_orderStauts.textColor = [self.orderViewModel ps_getOrderStatusTextColorAtIndex:index];
    cell.label_price.attributedText = [self.orderViewModel ps_getOrderPriceAtIndex:index];
    cell.label_address.text = [self.orderViewModel ps_getOrderAddressAtIndex:index];
    
    [cell.btn_left setTitle:[self.orderViewModel ps_getLeftBottomBtnTitleAtIndex:index] forState:UIControlStateNormal];
    [cell.btn_right setTitle:[self.orderViewModel ps_getRightBottomBtnTitleAtIndex:index] forState:UIControlStateNormal];
    [cell.btn_left addTarget:self action:@selector(buttonLeftClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_right addTarget:self action:@selector(buttonRightClick:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_left.hidden = ![self.orderViewModel ps_getIsShowLeftBottomBtnTitleAtIndex:index];
    cell.btn_right.hidden = ![self.orderViewModel ps_getIsShowRightBottomBtnTitleAtIndex:index];
    
    cell.btn_checkPic.hidden = ![self.orderViewModel ps_getIsShowCheckBottomBtnTitleAtIndex:index];
    [cell.btn_checkPic setTitle:@"到货照片" forState:UIControlStateNormal];

    WEAK_SELF;
    cell.btn_checkPicClick = ^{
        PSOrderPicVC *picVC  = [[PSOrderPicVC alloc] initWithOrderViewModel:weakSelf.orderViewModel orderIndex:indexPath.row];
        [weakSelf.view.navViewController pushViewController:picVC animated:YES];
    };
    return cell;
}

-(void)buttonLeftClick:(UIButton *)button event:(UIEvent *)event{
    
    UITouch *touch =  [event.allTouches anyObject] ;
    CGPoint poit = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:poit];
    PSOrderBottomBtnType type = [self.orderViewModel ps_getBottomBtnTypeWithIsLeft:YES AtIndex:indexPath.row];
    WEAK_SELF;
    if (type == PSOrderBottomBtnTypeCancelOrder) {
        [MMAlertView showWithTitle:@"是否确定取消订单！" detail:@"" cancelBtn:@"取消" sureBtn:@"确定" handler:^{
            [weakSelf.orderViewModel requestOrderOperateWithOperateType:2 order_id:[weakSelf.orderViewModel ps_getOrderIdAtIndex:indexPath.row]  order_code:[weakSelf.orderViewModel ps_getOrderCodeAtIndex:indexPath.row] complete:^(BOOL isFinished,NSString *str) {
                if (isFinished) {
                    [weakSelf.orderViewModel ps_deleteOrderIndex:indexPath.row];
                    [weakSelf.tableView reloadData];
                }
            }];
        }];
      
    }else if(type == PSOrderBottomBtnTypeCheckContract){
        
        NSString *url = [self.orderViewModel ps_getOrderContractUrlAtIndex:indexPath.row];
        PSAgreementVC *aggreeMent = [[PSAgreementVC alloc] init];
        aggreeMent.webUrl = url;
        [self.navigationController pushViewController:aggreeMent animated:YES];
    }
}
-(void)buttonRightClick:(UIButton *)button event:(UIEvent *)event{

    UITouch *touch =  [event.allTouches anyObject] ;
    CGPoint poit = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:poit];
    PSOrderBottomBtnType type = [self.orderViewModel ps_getBottomBtnTypeWithIsLeft:NO AtIndex:indexPath.row];
    WEAK_SELF;
    if (type == PSOrderBottomBtnTypeConfirmReceive) {
        [MMAlertView showWithTitle:@"是否确认收货" detail:@"" cancelBtn:@"取消" sureBtn:@"确定" handler:^{
            [self.orderViewModel requestOrderOperateWithOperateType:1 order_id:[self.orderViewModel ps_getOrderIdAtIndex:indexPath.row]  order_code:[self.orderViewModel ps_getOrderCodeAtIndex:indexPath.row] complete:^(BOOL isFinished,NSString *contract_url) {
                
                if (isFinished) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:FSNotificationConfirmOrderSuccesKey object:nil];
                    [MBProgressHUD toastMessageAtMiddle:@"确认收货完成"];
                    [weakSelf.orderViewModel ps_deleteOrderIndex:indexPath.row];
                    [weakSelf.tableView reloadData];
                    PSAgreementVC *aggreeMent = [[PSAgreementVC alloc] init];
                    aggreeMent.webUrl = contract_url;
                    [self.navigationController pushViewController:aggreeMent animated:YES];
                }
            }];
        }];
        
    }else if(type == PSOrderBottomBtnTypeArrivePic){
        PSOrderPicVC *picVC  = [[PSOrderPicVC alloc] initWithOrderViewModel:self.orderViewModel orderIndex:indexPath.row];
        [self.view.navViewController pushViewController:picVC animated:YES];
    }else if (type == PSOrderBottomBtnTypeCancerReserve){
        [MMAlertView showWithTitle:@"是否取消预定" detail:@"" cancelBtn:@"取消" sureBtn:@"确定" sureOrCanceHandler:^(BOOL sureButton) {
            if (sureButton) {
                [self.orderViewModel requestOrderOperateWithOperateType:2 order_id:[self.orderViewModel ps_getOrderIdAtIndex:indexPath.row]  order_code:[self.orderViewModel ps_getOrderCodeAtIndex:indexPath.row] complete:^(BOOL isFinished,NSString *str) {
                    if (isFinished) {
                        [weakSelf.orderViewModel ps_deleteOrderIndex:indexPath.row];
                        [weakSelf.tableView reloadData];
                    }
                }];
            }
        }];
    }
}




#pragma mark- lazy
-(PSOrderViewModel *)orderViewModel{
    if (!_orderViewModel) {
        _orderViewModel = [PSOrderViewModel new];
    }
    return _orderViewModel;
}

@end
