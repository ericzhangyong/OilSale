//
//  PSSenderOrderListVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderOrderListVC.h"
#import "PSSendListHeaderView.h"
#import "PSSenderOrderCell.h"
#import "PSSenderOrderViewModel.h"
#import "UIImageView+BaseWebCache.h"
#import "MMAlertView+BaseAlertManger.h"

@interface PSSenderOrderListVC ()

@property (nonatomic,strong) PSSendListHeaderView *view_header;
@property (nonatomic,strong) PSSenderOrderViewModel *senderViewModel;
@end

@implementation PSSenderOrderListVC

-(instancetype)initWithType:(SenderListType)listType{
    if (self = [super init]) {
        self.senderViewModel.listType = listType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}

-(void)initBaseViews{
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.backgroundColor = color_lightDart_f3f3f3;
    self.tableView.tableHeaderView = self.view_header;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    footer.backgroundColor = color_lightDart_f3f3f3;
    self.tableView.tableFooterView = footer;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSSenderOrderCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSSenderOrderCell.class)];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.senderViewModel requestOrderListWithPage:self.pullPageIndex Complete:^(BOOL isFinished,NSArray *data) {
        if (isFinished) {
            
            [weakSelf.tableView reloadData];
            [self endRefreshingWithCount:data.count];
        }else{
            [self endRefreshingWithCount:-1];
        }
    }];
}

#pragma mark- UITableVIewDataSource UITableVIewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.senderViewModel.dataSource.count;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 290;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSSenderOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSSenderOrderCell.class) forIndexPath:indexPath];
    
    NSInteger index = indexPath.row;
    
    cell.imageView_background.hidden = index !=0;
    cell.label_deliverNo.text = [self.senderViewModel ps_getDeliverNoAtIndex:index];
    [cell.imageView_header setImageWithUrl:[self.senderViewModel ps_getImageUrlAtIndex:index] placeholder:defaultHolder160_160 ];
    cell.label_time.text = [self.senderViewModel ps_getDeliverOrderTimeAtIndex:index];
    cell.label_buckettype.text = [self.senderViewModel ps_getBucketTypeAtIndex:index];
    cell.label_buckettype.hidden = self.senderViewModel.listType ==SenderListTypeStation;
    cell.label_price.text  = [self.senderViewModel ps_getPriceAtIndex:index];
    cell.label_price.hidden = self.senderViewModel.listType ==SenderListTypeStation;
    cell.label_name.text= [self.senderViewModel ps_getNameAtIndex:index];
    cell.label_carNum.text  = [self.senderViewModel ps_getCarNumAtIndex:index];
    cell.label_carNum.hidden = self.senderViewModel.listType ==SenderListTypeHome;
//    cell.layoutWidth_name.constant = [self.senderViewModel ps_getNameWidthAtIndex:index];
//    cell.label_isDebt.attributedText = [self.senderViewModel ps_getIsDebtAtIndex:index];
    cell.label_isDebt.hidden = YES;
    
    cell.label_phoneNum.text = [self.senderViewModel ps_getPhoneAtIndex:index];
    cell.label_address.text = [self.senderViewModel ps_getAddressAtIndex:index];
    cell.label_wareHouseStauts.text = [self.senderViewModel ps_getFinalStatusAtIndex:index];
    cell.label_wareHouseStauts.textColor = [self.senderViewModel ps_getFinalStatusColorAtIndex:index];
    cell.label_finalStatus.text = [self.senderViewModel ps_getBossStatusAtIndex:index];
    cell.label_finalStatus.textColor = [self.senderViewModel ps_getFinalStatusColorAtIndex:index];
//    cell.label_bossStatus.text = [self.senderViewModel ps_getBossStatusAtIndex:index];
//    cell.label_bossStatus.textColor = [self.senderViewModel ps_getBossStatusColorAtIndex:index];
    cell.layoutFirstWidth.constant = kScreenWidth*(self.senderViewModel.listType == SenderListTypeHome?0.5:0.33);
    cell.layoutLastWidth.constant = kScreenWidth*(self.senderViewModel.listType == SenderListTypeHome?0:0.33);
    
    WEAK_SELF;
    cell.confirmClick = ^{
        
        [weakSelf.senderViewModel reqeustSendOrderWithOrderIdAtIndex:index complete:^(BOOL isFinished) {
            
            if (isFinished) {
                [MMAlertView showWithTitle:@"派单成功" detail:@"加油点收到此加油订单" cancelBtn:nil sureBtn:@"知道了" sureOrCanceHandler:^(BOOL sureButton) {
                    [weakSelf.senderViewModel ps_removeDataIndex:index];
                    [weakSelf.tableView reloadData];
                }];
            }
        }];
    };
    
    return cell;
}


#pragma mark- lazy

-(PSSendListHeaderView *)view_header{
    if (!_view_header) {
        _view_header  = [PSSendListHeaderView initViewWithFrame:CGRectMake(0, 0, kScreenWidth, MasNavHeight)];
    }
    return _view_header;
}

-(PSSenderOrderViewModel *)senderViewModel{
    if (!_senderViewModel) {
        _senderViewModel = [PSSenderOrderViewModel new];
    }
    return _senderViewModel;
}
@end
