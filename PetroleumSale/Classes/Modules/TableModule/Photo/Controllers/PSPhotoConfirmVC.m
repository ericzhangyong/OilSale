//
//  PSPhotoConfirmVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/13.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPhotoConfirmVC.h"
#import "PSPhotoCanCell.h"
#import "PSPhotoOilGunCell.h"
#import "PSPhotoHeaderView.h"
#import "PSPhotoViewModel.h"
#import "BaseNavViewController.h"
#import "PSDeliveryListVC.h"
#import "NSString+RECategory.h"
#import "PSPhotoStationCell.h"
#import "UserInfoProfile.h"
#import "PSStationCarSelectVC.h"
#import "MMAlertView+BaseAlertManger.h"
#import "PSGetCanVC.h"

@interface PSPhotoConfirmVC ()
@property (nonatomic,strong) PSPhotoHeaderView *view_header;
@property (nonatomic,strong) PSPhotoViewModel *photoViewModel;

@end

@implementation PSPhotoConfirmVC

+(void)presentConfirmVC{
    PSPhotoConfirmVC *driverHome = [[PSPhotoConfirmVC alloc] init];
    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:driverHome];
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [vc presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self loadWebDataSource];
}

-(void)initNavView{

    self.navigationItem.title = @"拍照确认";
//    self.navigationController.navigationBar.barTintColor = color_3370FE;
    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Background"] forBarMetrics:UIBarMetricsCompact];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Background"] forBarMetrics:UIBarMetricsDefault];
    [self leftBarButtonWithImage:[UIImage imageNamed:@"hp_icon_back_a"] target:self selector:@selector(back)];
    
    [self rightBarButtonWithText:@"确定" textColor:[UIColor whiteColor] textFont:[UIFont systemWEPingFangRegularOfSize:15] target:self selector:@selector(confirmClick)];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = color_3370FE;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self confirmSuccess];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}
-(void)initBaseViews{
    
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.backgroundColor = color_lightDart_f3f3f3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSPhotoCanCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSPhotoCanCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSPhotoOilGunCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSPhotoOilGunCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSPhotoStationCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSPhotoStationCell.class)];
    [self reloadHeaderView];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.photoViewModel requestPhotoConfirmComplete:^(BOOL isFinished) {
        if (isFinished) {
            
            [weakSelf reloadHeaderView];
            [weakSelf.tableView reloadData];
        }
        [weakSelf endRefreshingWithCount:-1];
    }];
}

-(void)reloadHeaderView{
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 150+MasNavHeight);
    [view addSubview:self.view_header];
    self.tableView.tableHeaderView = view;
    
    self.view_header.label_name.text = [self.photoViewModel ps_getHeaderName];
    self.view_header.label_phoneNum.text = [self.photoViewModel ps_getHeaderPhoneNum];
    self.view_header.label_region.text = [self.photoViewModel ps_getHeaderRegion];
    self.view_header.label_title.text = [self.photoViewModel ps_getHeaderLabeTitle];
    self.view_header.label_orderNo.text = [self.photoViewModel ps_getHeaderLabeContent];
    self.view_header.label_addressDetail.text = [self.photoViewModel ps_getHeaderCompleteAddress];
    
    NSString *consignee = [self.photoViewModel ps_getHeaderName];
    CGFloat nameWith = 70;
    if (![BaseVerifyUtils isNullOrSpaceStr:consignee]) {
        nameWith = [consignee widthWithFont:[UIFont systemWEPingFangRegularOfSize:14]]+10;
    }
    self.view_header.layoutWidth_name.constant = nameWith;
    WEAK_SELF;
    self.view_header.didClickAction = ^(PhotoClickType clickType) {
    
        if (clickType == PhotoClickTypeBack) {
            [weakSelf back];
        }else if (clickType == PhotoClickTypeConfirm){
            [weakSelf confirmClick];
        }else if(clickType == PhotoClickTypeLabelTilte){
            if (IsUSerStationType) {
            //选择车牌号
                PSStationCarSelectVC *carNum = [[PSStationCarSelectVC alloc] initWithDataArray:weakSelf.photoViewModel.getCarInfoArr complte:^(NSString *car_info_id) {
                    
                    
                    [weakSelf.photoViewModel ps_setSelectCarWithcarInfoId:car_info_id];
                    [weakSelf reloadHeaderView];
                }];
                [weakSelf.navigationController pushViewController:carNum animated:YES];
            }else{
                [weakSelf selectOrderClick];
            }
        }
        else if(clickType == PhotoClickTypeSelect){
            if (IsUSerStationType) {
            }else{
                [weakSelf selectOrderClick];
            }
        }
    };
}


#pragma mark- click

-(void)back{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)confirmClick{
    
    if (IsUSerStationType) {
        [self.photoViewModel reqeustSavePhotoComplete:^(BOOL isFinished) {
            [self confirmSuccess];
               if (isFinished) {
                   //发送成功
                   [MBProgressHUD toastMessageAtMiddle:@"保存成功"];
                   [self.navigationController dismissViewControllerAnimated:YES completion:nil];
               }
           }];
    }else{
        
        [self.photoViewModel reqeustSavePhotoComplete:^(BOOL isFinished) {
            [self confirmSuccess];
            if (isFinished) {
                //发送成功
//                [MBProgressHUD toastMessageAtMiddle:@"保存成功"];
                if ([self.photoViewModel.photoModel.product_type isEqualToString:@"ibc"] ||[self.photoViewModel.photoModel.product_type isEqualToString:@"bucket"]) {
                    [MMAlertView showWithTitle:@"保存成功，是否立即回收空油桶" detail:@"" cancelBtn:@"不收回" sureBtn:@"收回" sureOrCanceHandler:^(BOOL sureButton) {
                        if (sureButton) {
                            PSGetCanVC *getCanVC =[[PSGetCanVC alloc] initWithPhone:self.photoViewModel.photoModel.phone_num BucketType:self.photoViewModel.photoModel.commodity_name Count:self.photoViewModel.photoModel.order_buy_num oidGunCOunt:self.photoViewModel.photoModel.nozzle_num];
                            [self.navigationController pushViewController:getCanVC animated:YES];
                        }else{
                            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                        }
                    }];
                }else{
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }
                
            }
        }];
       
        
    }
}

-(void)confirmSuccess{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"driveConfirmSuccess" object:nil];
}

-(void)selectOrderClick{
    
    WEAK_SELF;
    PSDeliveryListVC *listVC = [[PSDeliveryListVC alloc] initWithDeliveryListTypeL:DeliveryListTypeSelect];
    NSMutableArray *data =[NSMutableArray array];
    for (PSPhotoConfirmModel *model in self.photoViewModel.dataSource) {
        if (!model.bucket_info_list.firstObject.isOilGunCell) {
            NSMutableDictionary *dict = model.modelToJsonDictionary;
            [data addObject:dict];
        }
    }
    [listVC setSelectResultArr:data];
    listVC.didSelecBlock = ^(NSString * _Nonnull deliverOrderNo,NSInteger index) {
        [weakSelf.photoViewModel didSelectWithIndex:index];
        [weakSelf reloadHeaderView];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark- UITableViewDelegate DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (IsUSerStationType) {
        return 1;
    }else{
        return self.photoViewModel.photoModel.bucket_info_list.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = color_lightDart_f3f3f3;
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = color_lightDart_f3f3f3;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IsUSerStationType){
        return 245;
    }else{
        BOOL isOilGunCell = [self.photoViewModel isOilGunCellAtIndex:indexPath.section];
        if (isOilGunCell) {
            return 50;
        }
        return 350;//298;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = indexPath.section;
    
    
    if (IsUSerStationType){
        PSPhotoStationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSPhotoStationCell.class) forIndexPath:indexPath];
        
        [cell configWithPhotoViewModel:self.photoViewModel OrderIndex:index];
        return cell;
    }else{
        BOOL isOilGunCell = [self.photoViewModel isOilGunCellAtIndex:index];
        if (isOilGunCell) {
            PSPhotoOilGunCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSPhotoOilGunCell.class) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            WEAK_SELF;
            cell.tf_oilGunCount.text = self.photoViewModel.photoModel.nozzle_num;
            cell.oidCountDidChanged = ^(NSString * _Nonnull value) {
                if (weakSelf.photoViewModel.photoModel.bucket_info_list.count>0) {
                    [weakSelf.photoViewModel ps_setOilGunValue:value];
                }
            };
            return cell;
        }
        else{
            PSPhotoCanCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSPhotoCanCell.class) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.backgroundColor = color_F3F3F3;
            [cell configWithPhotoViewModel:self.photoViewModel OrderIndex:indexPath.section];
            return cell;
        }
    }
    
    
}



#pragma mark- lazy
-(PSPhotoViewModel *)photoViewModel{
    if (!_photoViewModel) {
        _photoViewModel = [PSPhotoViewModel new];
    }
    return _photoViewModel;
}
-(PSPhotoHeaderView *)view_header{
    if (!_view_header) {
        _view_header = [PSPhotoHeaderView initNibView];
        _view_header.frame = CGRectMake(0, 0, kScreenWidth, 150+MasNavHeight);
    }
    return _view_header;
}


-(BOOL)needPullHeader{
    return NO;
}
-(BOOL)needPullFooter{
    return NO   ;
}
@end
