//
//  PSSenderDeliverListVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDeliverListVC.h"
#import "PSSenderDeliveryCell.h"
#import "UIImageView+BaseWebCache.h"
#import "UIView+BaseCategory.h"
#import "PSSenderDriverSelectVC.h"
#import "PSDriverBottomView.h"

@interface PSSenderDeliverListVC ()
@property (nonatomic,strong) PSDriverBottomView *view_bottom;

@property (nonatomic,strong) PSSenderDeliverViewModel *deliveryViewModel;
@end

@implementation PSSenderDeliverListVC

-(instancetype)initWithListType:(PSSenderDeliverListType)listType{
    if (self = [super init]) {
        self.deliveryViewModel.listType = listType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadWebDataSource];
}

-(void)initBaseViews{
    
    
    if (self.deliveryViewModel.listType == PSSenderDeliverListTypeUnSended) {
        [self.view addSubview:self.view_bottom];
        [self.view_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view);
            make.height.mas_equalTo(56);
        }];
    
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view_bottom.mas_top);
            make.top.left.right.equalTo(self.view);
        }];
    }
    
    self.tableView.backgroundColor = color_F3F3F3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSSenderDeliveryCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSSenderDeliveryCell.class)];
}
-(void)initBaseDatas{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebDataSource) name:FSNotificationSendSuccessNotifiKey object:nil];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    WEAK_SELF;
    [self.deliveryViewModel requestDeliveryListWithPage:self.pullPageIndex Complete:^(BOOL isFinished,NSArray *data) {
        if (isFinished) {
            
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshingWithCount:data.count];

        }else{
            [weakSelf endRefreshingWithCount:-1];
        }
    }];
}
#pragma mark- click
-(void)goToSendDidClick{
    
    NSArray *selectOrderIdArr = [self.deliveryViewModel ps_getDeliverOrderIdArr];
    if (selectOrderIdArr.count==0) {
        [MBProgressHUD toastMessageAtMiddle:@"请先选择订单"];
        return;
    }
    PSSenderDriverSelectVC *selectDriver = [[PSSenderDriverSelectVC alloc] initWithOrderIdArr:selectOrderIdArr];
    [self.view.navViewController pushViewController:selectDriver animated:YES];
    
//    [self.driverViewModel requestSendDeliveryComplete:^(BOOL isFinished) {
//        if (isFinished) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
}

#pragma mark- UITableViewDelegate UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.deliveryViewModel.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.deliveryViewModel.listType == PSSenderDeliverListTypeUnSended) {
        return 216;
    }
    return 248;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSSenderDeliveryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSSenderDeliveryCell.class) forIndexPath:indexPath];
    
    NSInteger index = indexPath.row;
    cell.label_deliverNo.text = [self.deliveryViewModel ps_getDeliverNoAtIndex:index];
    [cell.imageView_header setImageWithUrl:[self.deliveryViewModel ps_getImageUrlAtIndex:index] placeholder:defaultHolder160_160];
    cell.label_buckettype.text = [self.deliveryViewModel ps_getBucketTypeAtIndex:index];
    cell.label_price.text = [self.deliveryViewModel ps_getPriceAtIndex:index];
    cell.label_name.text = [self.deliveryViewModel ps_getNameAtIndex:index];
    cell.label_siglePrice.text = [self.deliveryViewModel ps_getSiglePriceAtIndex:index];
    cell.label_siglePrice.hidden = ![self.deliveryViewModel ps_getIsShowSiglePriceAtIndex:index];
    
    cell.layoutWidth_name.constant = [self.deliveryViewModel ps_getNameWidthAtIndex:index];
    cell.label_phoneNum.text = [self.deliveryViewModel ps_getPhoneAtIndex:index];
    cell.label_address.text = [self.deliveryViewModel ps_getAddressAtIndex:index];
    cell.btn_select.hidden = ![self.deliveryViewModel ps_getIsShowBtnSelectedAtIndex:index];
    cell.btn_select.selected = [self.deliveryViewModel ps_getIsSelectedAtIndex:index];
    cell.label_sendStatus.text= [self.deliveryViewModel ps_getSenderStatusAtIndex:index];
    cell.label_sendStatus.hidden = ![self.deliveryViewModel ps_getIsShowSenderStatusAtIndex:index];
    cell.label_sendStatus.textColor = color_4084FF;
    
    cell.label_pickOneSelfTitle.text = [self.deliveryViewModel ps_getLabelPickOneSelfTitleAtIndex:index];
    cell.tf_pickerNum.text = [self.deliveryViewModel ps_getLabelPickOneSelfContentAtIndex:index];
    cell.tf_pickerNum.enabled = [self.deliveryViewModel ps_getIsEnablePickOneSelfTextFieldAtIndex:index];
    cell.view_pickOneself.hidden = NO;
    if (self.deliveryViewModel.listType == PSSenderDeliverListTypeUnSended) {
        cell.view_pickOneself.hidden = YES;
    }
    cell.btn_savePickerOneSelf.hidden =![self.deliveryViewModel ps_getIsEnablePickOneSelfTextFieldAtIndex:index];

    
    WEAK_SELF;
    cell.saveClickBlock = ^(NSString *num){
      
        [weakSelf.deliveryViewModel requestSavePickOneSelfWithCode:num way_bill_id:[weakSelf.deliveryViewModel ps_getDeliverWay_bill_idAtIndex:index] complete:^(BOOL isFinished) {
            if (isFinished) {
            
                [weakSelf.deliveryViewModel.dataSource removeObjectAtIndex:index];
                [weakSelf.tableView reloadData];
                [MBProgressHUD toastMessageAtMiddle:@"保存成功"];
            }
        }];
    };
    
    
    
    
    
    
    
//    cell.btn_goToSend.hidden = self.deliveryViewModel.listType == PSSenderDeliverListTypeSended;
//    WEAK_SELF;
//    cell.goToSendClick = ^{
//
//        PSSenderDriverSelectVC *selectDriver = [[PSSenderDriverSelectVC alloc] initWithOrderId:[self.deliveryViewModel ps_getDeliverOrderIdAtIndex:index]];
//        [weakSelf.view.navViewController pushViewController:selectDriver animated:YES];
//    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BOOL isSelected = [self.deliveryViewModel ps_getIsSelectedAtIndex:indexPath.row];
    [self.deliveryViewModel ps_setIsSelectedAtIndex:indexPath.row IsSelected:!isSelected];
    
    [self.tableView reloadData];
}

#pragma mark- lazy
-(PSSenderDeliverViewModel *)deliveryViewModel{
    if (!_deliveryViewModel) {
        _deliveryViewModel = [PSSenderDeliverViewModel new];
    }
    return _deliveryViewModel;
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
