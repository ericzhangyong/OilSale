//
//  PSHomeVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSHomeVC.h"
#import "PSHomeHeaderView.h"
#import "PSHomeFooterView.h"
#import "PSHomeViewModel.h"
#import "PSHomeOilCell.h"
#import "UIImageView+BaseWebCache.h"
#import "PSPertrolStationView.h"
#import "PSPetrolStationVC.h"
#import "PSCarNumVC.h"
#import "PSReserveStationConfirmVC.h"

@interface PSHomeVC ()

@property (nonatomic,strong) PSHomeHeaderView *view_header;
@property (nonatomic,strong) PSPertrolStationView *view_footer;
@property (nonatomic,strong) PSHomeViewModel *homeViewModel;

@end

@implementation PSHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
    
}

-(void)initBaseViews{
    
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSHomeOilCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSHomeOilCell.class)];
    [self reloadHeaderView];
    [self reloadFooterView];
   
    
}



-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.homeViewModel requestHomeDataListComplete:^(BOOL isFinished) {
        if (isFinished) {
            
            weakSelf.view_header.homeViewModel = weakSelf.homeViewModel;
            [weakSelf reloadHeaderView];
            [weakSelf reloadFooterView];
            [weakSelf.tableView reloadData];
        }
        [weakSelf endRefreshingWithCount:-1];
    }];

}

-(void)reloadHeaderView{
    self.view_header.frame = CGRectMake(0, 0, kScreenWidth, self.homeViewModel.ps_getHeaderHeight);
    self.tableView.tableHeaderView = self.view_header;
}

-(void)reloadFooterView{
    WEAK_SELF;
    if (self.homeViewModel.homeModel.farp_product != nil) {
        UIView *footerView = [UIView new];
        footerView.frame = CGRectMake(0, 0, kScreenWidth, 255);
        [footerView addSubview:self.view_footer];
        self.view_footer.frame = footerView.bounds;
        self.tableView.tableFooterView = footerView;
        self.view_footer.label_price.text = [self.homeViewModel ps_getFarpStationPrice];
        self.view_footer.tf_carNum.text = [self.homeViewModel ps_getFarpStationSelectCar];
        self.view_footer.label_perolStation.text = [self.homeViewModel ps_getSelectFarpAddressName];
        self.view_footer.stationViewClick = ^(PSStationClickType clickType) {
            if (clickType == PSStationClickTypeSelectStation) {
                PSPetrolStationVC *petrolSelect = [[PSPetrolStationVC alloc] initWithStationArr:[weakSelf.homeViewModel ps_getFarpListFarpAddressArr]];
                petrolSelect.selectStationBlock = ^(PSStationModel * _Nonnull stationModel,NSInteger index) {
                    weakSelf.view_footer.label_perolStation.text = stationModel.farp_name;
                    [weakSelf.homeViewModel ps_setFarpStationWithFarp_id:stationModel.farp_id];
                };
                [weakSelf.navigationController pushViewController:petrolSelect animated:YES];
            }else if (clickType == PSStationClickTypeCarNum){
                PSCarNumVC *carNumVC  = [[PSCarNumVC alloc]initWithDataArray:[weakSelf.homeViewModel ps_getFarpListArr]];
                carNumVC.selectCarNumBlock = ^(NSArray * _Nonnull dataArr) {
                    
                    [weakSelf.homeViewModel ps_setCarListWithArr:dataArr];
                    weakSelf.view_footer.tf_carNum.text = [weakSelf.homeViewModel ps_getFarpStationSelectCar];
                };
                [weakSelf.navigationController pushViewController:carNumVC animated:YES];
            }else if (clickType == PSStationClickTypeReserve){
                

                NSArray *selectCarArr = [weakSelf.homeViewModel ps_getFarpStationSelectCarArr];
                PSReserveStationConfirmVC *reservewConfirmVC  =[[PSReserveStationConfirmVC alloc] initWithCarNumArr:selectCarArr stationModel:[weakSelf.homeViewModel ps_getSelectFarpModel]];
                [weakSelf.navigationController pushViewController:reservewConfirmVC animated:YES];
            }
        };
    }else{
        self.tableView.tableFooterView = [UIView new];
    }
    
}

-(UITableViewStyle)re_tableViewStryle{
    return UITableViewStyleGrouped;
}
#pragma mark- UITableViewDelegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.homeViewModel.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return  [self.homeViewModel.dataSource[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 24;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[UIView new];
    view.frame  = CGRectMake(15, 0, 200, 24);
    view.backgroundColor= color_lightDart_white;
    UILabel *label = [UILabel new];
    label.text = [NSString stringWithFormat:@"桶装油¥%@",self.homeViewModel.homeModel.oil_price_today.oil_price];//oil_price
    if (self.homeViewModel.dataSource.count>0 && self.homeViewModel.homeModel.product_list.count>0 && section == 0) {
        label.text = [NSString stringWithFormat:@"桶装油¥%@",self.homeViewModel.homeModel.oil_price_today.oil_price];;
    }else{
        label.text = self.homeViewModel.ps_getCarPrice;
    }
    
    label.frame  = CGRectMake(15, 0, 200, 24);
    label.font = [UIFont systemWEPingFangBoldFontOfSize:17];
    label.textColor = color_lightDart_333333;
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.homeViewModel.dataSource.count>0 && self.homeViewModel.homeModel.product_list.count>0 && indexPath.section == 0) {
        return 115+7;
    }else{
        return 150;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSHomeOilCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSHomeOilCell.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    
    cell.label_title.text = [self.homeViewModel ps_getTitleAtSection:section Index:index];
    [cell.imageView_header setImageWithUrl:[self.homeViewModel ps_getImageUrlAtSection:section Index:index] placeholder:defaultHolder160_160];
    cell.label_price.attributedText = [self.homeViewModel ps_getPriceAtSection:section Index:index];
    //leftbtn
    [cell.btn_containTax setTitle:[self.homeViewModel ps_getLeftBtnContentAtSection:section index:index] forState:UIControlStateNormal];
    [cell.btn_containTax setTitle:[self.homeViewModel ps_getLeftBtnContentAtSection:section index:index] forState:UIControlStateSelected];
    cell.layoutWidth_containTax.constant = [self.homeViewModel ps_getLeftBtnWidthAtSection:section index:index];
    cell.btn_containTax.selected = [self.homeViewModel ps_getLeftBtnIsSelectedAtSection:section index:index];
    
    //rightbtn
    [cell.btn_notContainTax setTitle:[self.homeViewModel ps_getRightBtnContentAtSection:section index:index] forState:UIControlStateNormal];
    [cell.btn_notContainTax setTitle:[self.homeViewModel ps_getRightBtnContentAtSection:section index:index] forState:UIControlStateSelected];
    cell.layoutWidth_notConatinTax.constant = [self.homeViewModel ps_getRightBtnWidthAtSection:section index:index];
    cell.btn_notContainTax.selected = [self.homeViewModel ps_getRightBtnIsSelectedAtSection:section index:index];
    BOOL rightEnable = [self.homeViewModel ps_getRightBtnEnabledAtSection:section index:index];
    cell.btn_notContainTax.enabled = rightEnable;
    UIColor *color = rightEnable?color_666666:fsColor_CCCCCC;
    [cell.btn_notContainTax setTitleColor:color forState:UIControlStateNormal];
    
    if (self.homeViewModel.dataSource.count>0 && self.homeViewModel.homeModel.product_list.count>0 && indexPath.section == 0) {
        cell.view_tax.hidden = YES;
    }else{
        cell.view_tax.hidden = NO;
    }
    WEAK_SELF;

    cell.bottomBtnClick = ^(BOOL isLeftBtn, BOOL isSelected) {
        if (isLeftBtn && isSelected) {//
            [weakSelf.homeViewModel ps_setLeftBtnIsSelectedAtSection:section index:index withState:isSelected];
        }else{
            [weakSelf.homeViewModel ps_setRightBtnIsSelectedAtSection:section index:index withState:YES];
        }
        [weakSelf.tableView reloadData];
    };

    cell.addShopCartClick = ^(BOOL isClick,NSString *buyNum) {
        [weakSelf.homeViewModel requestAddShopCartAtSection:section Index:index buyNum:buyNum Complete:^(BOOL isFinished) {
            
        }];
    };
    cell.view_addShopCart.showDunOrTongType = [self.homeViewModel ps_getUnitTypeAtSection:section Index:index];
    
    return cell;
}

#pragma mark- lazy

-(PSHomeHeaderView *)view_header{
    if (!_view_header) {
        _view_header = [[PSHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 360)];
    }
    return _view_header;
}
-(PSPertrolStationView *)view_footer{
    if (!_view_footer) {
        _view_footer =[PSPertrolStationView initNibView];
        
    }
    return _view_footer;
}
-(PSHomeViewModel *)homeViewModel{
    if (!_homeViewModel) {
        _homeViewModel = [PSHomeViewModel new];
    }
    return _homeViewModel;
}


-(BOOL)needPullFooter{
    return NO;
}

@end
