//
//  PSSalemanHomeVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/3/17.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSSalemanHomeVC.h"
#import "BaseBlueNavView.h"
#import "PSSalesmanHomeViewModel.h"
#import "PSSalesmanHomeCell.h"
#import "REMainTabManager.h"

@interface PSSalemanHomeVC ()

@property (nonatomic,strong) BaseBlueNavView *view_nav;

@property (nonatomic,strong) PSSalesmanHomeViewModel *salesmanViewModel;

@end

@implementation PSSalemanHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}

-(void)initNavView{
    
//    self.view.backgroundColor = color_F3F3F3;
    [self.view addSubview:self.view_nav];
    [self.view_nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(MasNavHeight + 46);
    }];
    [self.view insertSubview:self.view_nav atIndex:0];
    self.view_nav.title = @"石化销售平台";

}
-(void)initBaseViews{
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_nav.mas_bottom).offset(-46);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSSalesmanHomeCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSSalesmanHomeCell.class)];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    WEAK_SELF;
    [self.salesmanViewModel requestClientListComplete:^(BOOL isFinished) {
        if (isFinished) {
            
            
            [weakSelf.tableView reloadData];
        }
        [self endRefreshingWithCount:-1];
    }];
}



#pragma mark-UITableViewDelegate DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.salesmanViewModel.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.salesmanViewModel getClienIsRunOffAtIndex:indexPath.row]) {
        return 160;
    }
    return 185;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSSalesmanHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSSalesmanHomeCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.label_name.text = [self.salesmanViewModel getClienRegistTimeAtIndex:indexPath.row];
    cell.label_registTime.text = [self.salesmanViewModel getClienRegistTimeAtIndex:indexPath.row];
    cell.label_lastTime.text = [self.salesmanViewModel getClienLastVisitimeAtIndex:indexPath.row];
    cell.btn_visit.enabled = ![self.salesmanViewModel getClienIsVisitAtIndex:indexPath.row];
    cell.label_lastTime.hidden = [self.salesmanViewModel getClienIsRunOffAtIndex:indexPath.row];
    cell.label_status.text = [self.salesmanViewModel getClienRunOffStateAtIndex:indexPath.row];
    [cell.btn_visit setTitle:[self.salesmanViewModel getClienBtnVisitTitleAtIndex:indexPath.row] forState:UIControlStateNormal];
    cell.btn_visit.alpha = [self.salesmanViewModel getClienIsVisitAtIndex:indexPath.row]?0.5:1;
    WEAK_SELF;
    cell.clickBlock = ^(BOOL isVisit) {
        
        if (isVisit) {
            [weakSelf.salesmanViewModel requestClientVisitAtIndex:indexPath.row Complete:^(BOOL isFinished) {
                       
                        if (isFinished) {
                            
                            [weakSelf loadWebDataSource];
            //                [weakSelf.tableView reloadData];
                        }
                    }];
        }else{
            //查看订单
            REMainTabManager *manager = [REMainTabManager sharedManager];
            manager.tabBarController.selectedIndex = 1;
        }
        
    };
    
    return cell;
}




#pragma mark- lazy

-(BaseBlueNavView *)view_nav{
    if (!_view_nav) {
        _view_nav = [BaseBlueNavView initViewWithFrame:CGRectMake(0, 0, kScreenWidth, MasNavHeight+46)];
    }
    return _view_nav;
}

-(PSSalesmanHomeViewModel *)salesmanViewModel{
    if (!_salesmanViewModel) {
        _salesmanViewModel = [PSSalesmanHomeViewModel new];
    }
    return _salesmanViewModel;
}


@end
