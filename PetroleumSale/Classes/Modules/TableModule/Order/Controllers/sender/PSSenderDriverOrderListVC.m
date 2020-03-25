//
//  PSSenderDriverListVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/24.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSSenderDriverOrderListVC.h"
#import "PSSenderDriverListRequest.h"
#import "PSDriverViemModel.h"
#import "PSDriverOrderCell.h"
#import "UIImageView+BaseWebCache.h"
#import "PSDriverBottomView.h"

@interface PSSenderDriverOrderListVC ()

//@property (nonatomic,strong) PSDriverBottomView *view_bottom;
@end

@implementation PSSenderDriverOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadWebDataSource];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    [self.driverViewModel requestDriverListComplete:^(BOOL isFinished) {
        if (isFinished) {

            [self.tableView reloadData];
        }
        [self endRefreshingWithCount:-1];
    }];
    
}

-(void)initNavView{
    
    self.navigationItem.title = @"运单";
}

-(void)initBaseViews{
    
//    [self.view addSubview:self.view_bottom];
//    [self.view_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-SafeBottom);
//        make.height.mas_equalTo(56);
//    }];
//
//    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view_bottom.mas_top);
//        make.top.left.right.equalTo(self.view);
//    }];
    self.tableView.backgroundColor= color_lightDart_f3f3f3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSDriverOrderCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSDriverOrderCell.class  )];
       
}

//-(void)goToSendDidClick{
//    
//    [self.driverViewModel requestSendDeliveryComplete:^(BOOL isFinished) {
//        if (isFinished) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
//}

#pragma mark- UITableViewDelegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.driverViewModel ps_getSectionCountAtIndex:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 148;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSDriverOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSDriverOrderCell.class) forIndexPath:indexPath];
    NSInteger index = self.driverViewModel.currentDriverIndex;
    NSInteger row = indexPath.row;
    cell.label_orderNo.text = [self.driverViewModel ps_getOrderNoAtIndex:index row:row];
    cell.label_driverName.text= [self.driverViewModel ps_getDriverNameAtIndex:index];
    cell.label_estiTime.text = [self.driverViewModel ps_getSendTimeAtIndex:index row:row];
    [cell.imageView_header setImageWithUrl:[self.driverViewModel ps_getImageUrlAtIndex:index row:row] placeholder:defaultHeaderHolder];
    cell.label_lastTime.attributedText = [self.driverViewModel ps_getSendLastTimeAtIndex:index row:row];
    return cell;
}



#pragma mark- lazy
-(PSDriverViemModel *)driverViewModel{
    if (!_driverViewModel) {
        _driverViewModel= [PSDriverViemModel new];
    }
    return _driverViewModel;
}

//-(PSDriverBottomView *)view_bottom{
//    if (!_view_bottom) {
//        _view_bottom = [PSDriverBottomView initViewWithFrame:CGRectMake(0, kScreenHeight-SafeBottom-56, kScreenWidth, 56)];
//        WEAK_SELF;
//        _view_bottom.goToSendDidClick = ^{
//            [weakSelf goToSendDidClick];
//        };
//    }
//    return _view_bottom;
//}

@end
