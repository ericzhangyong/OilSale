//
//  PSSalesmanOrderListVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSSalesmanOrderListVC.h"
#import "PSSalesmanOrderCell.h"

@interface PSSalesmanOrderListVC ()

@property (nonatomic,strong) PSSalesmanOrderViewModel *orderViewModel;
@end

@implementation PSSalesmanOrderListVC


-(instancetype)initWithListType:(PSSalesmanOrderListType)listType{
    if (self = [super init]) {
        
        self.orderViewModel.listType = listType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}

-(void)initBaseViews{
    
    self.tableView.backgroundColor = color_F3F3F3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSSalesmanOrderCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSSalesmanOrderCell.class)];
}


-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.orderViewModel requestOrderListWithPage:self.pullPageIndex Complete:^(BOOL isFinished, NSArray * _Nonnull dataArr) {
        if (isFinished) {
            
            [weakSelf.tableView reloadData];
            [weakSelf endRefreshingWithCount:dataArr.count];
        }else{
            [weakSelf endRefreshingWithCount:-1];
        }
    }];
}



#pragma mark- UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderViewModel.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.orderViewModel ps_getCellHeighttIndex:indexPath.section];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[UIView new];
    view.backgroundColor = color_F3F3F3;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSSalesmanOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSSalesmanOrderCell.class) forIndexPath:indexPath];
    
    NSInteger index = indexPath.section;
    cell.label_name.text = [self.orderViewModel ps_getClientNameAtIndex:index];
    cell.label_status.text = [self.orderViewModel ps_getOrderStatusAtIndex:index];
    cell.label_status.hidden = ![self.orderViewModel ps_getIsShowOrderStatusAtIndex:index];
    cell.label_time.text = [self.orderViewModel ps_getOrderTimeAtIndex:index];
    cell.label_cancelReason.text = [self.orderViewModel ps_getOrderCancelReasonAtIndex:index];
    cell.label_cancelReason.hidden = ![self.orderViewModel ps_getIsShowOrderCancelReasonAtIndex:index];
    cell.view_buyContract.hidden = ![self.orderViewModel ps_getIsShowOrderContractAtIndex:index];
    cell.label_saleMoney.text = [self.orderViewModel ps_getOrderSaleAwardAtIndex:index];
    cell.label_saleMoney.hidden = [self.orderViewModel ps_getIsShowOrderSaleAwardAtIndex:index];
    
    
    return cell;
}


#pragma mark- layz
-(PSSalesmanOrderViewModel *)orderViewModel{
    
    if (!_orderViewModel) {
        _orderViewModel = [PSSalesmanOrderViewModel new];
    }
    return _orderViewModel;
}

@end
