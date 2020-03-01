//
//  PSStationReserveConfirmVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/23.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSReserveStationConfirmVC.h"
#import "PSReserveStationViewModel.h"
#import "PSReserveStationCell.h"
#import "PSReseveConfirmFooterView.h"
#import "BaseWebViewController.h"
#import "UIImageView+BaseWebCache.h"

@interface PSReserveStationConfirmVC ()

@property (nonatomic,strong) PSReseveConfirmFooterView *view_footer;
@property (nonatomic,strong) PSReserveStationViewModel *reserveViewModel;
@end

@implementation PSReserveStationConfirmVC

-(instancetype)initWithCarNumArr:(NSArray *)carNumArr
                    stationModel:(PSStationModel *)stationModel{
    if (self = [super init]) {
        
        self.reserveViewModel.carNumArr = carNumArr;
        self.reserveViewModel.stationModel = stationModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}

-(void)initNavView{
    
    self.navigationItem.title = @"确认订单";
}
-(void)initBaseViews{
    
    self.tableView.backgroundColor = color_F3F3F3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSReserveStationCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSReserveStationCell.class)];
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 91);
    [view addSubview:self.view_footer];
    self.view_footer.frame = view.bounds;
    self.tableView.tableFooterView = view;
    
    WEAK_SELF;
    self.view_footer.footBtnDidClick = ^(NSInteger clickType) {
        if (clickType == 1) {//购买协议
            BaseWebViewController *webVC =[[BaseWebViewController alloc] init];
            webVC.webUrl = @"www.baidu.com";
            [weakSelf.navigationController pushViewController:webVC animated:YES];
        }else if (clickType == 2){//立即预订
            
            if (!weakSelf.view_footer.btn_selelcted.selected) {
                [MBProgressHUD toastMessageAtMiddle:@"请先同意协议！"];
                return ;
            }
            [weakSelf.reserveViewModel requestStationReseveConfirmComplete:^(BOOL isFinished) {
                if (isFinished) {
                
                    [MBProgressHUD toastMessageAtMiddle:@"预订成功"];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    };
}

-(void)loadWebDataSource{
    
    [super loadWebDataSource];
    
//    WEAK_SELF;
//    [self.reserveViewModel requestStationReseveConfirmComplete:^(BOOL isFinished) {
//        if (isFinished) {
//            [weakSelf.tableView reloadData];
//        }
//        [self endRefreshingWithCount:-1];
//    }];
    
}

#pragma mark- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.reserveViewModel.carNumArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view =[UIView new];
    view.backgroundColor = color_F3F3F3;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSReserveStationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSReserveStationCell.class)];
    
    
    cell.label_carNum.text = [self.reserveViewModel ps_getCarNumAtIndex:indexPath.row];
    cell.label_address.text = [self.reserveViewModel ps_getAddress];
    [cell.imageView_header setImageWithUrl:[self.reserveViewModel ps_getStationPic] placeholder:defaultHolder160_160];
    return cell;
}



#pragma mark- lazy

-(PSReserveStationViewModel *)reserveViewModel{
    if (!_reserveViewModel) {
        _reserveViewModel = [PSReserveStationViewModel new];
    }
    return _reserveViewModel;
}
-(PSReseveConfirmFooterView *)view_footer
{
    if (!_view_footer) {
        _view_footer = [PSReseveConfirmFooterView initNibView];
    }
    return _view_footer;
}





-(BOOL)needPullHeader{
    return NO;
}

-(BOOL)needPullFooter{
    return NO;
}

@end
