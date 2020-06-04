//
//  PSKeeperWareHourseVC.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/25.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSKeeperWareHourseVC.h"
#import "PSKeeperWareHourseCell.h"
#import "PSWareHourseListRequest.h"
#import "PSKeeperWareHourseAddModel.h"
#import "PSWarehourseEditVC.h"

@interface PSKeeperWareHourseVC()

@property (nonatomic,strong) NSArray *sto_region_list;
@end
@implementation PSKeeperWareHourseVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self loadWebDataSource];

}
-(void)initNavView{
    
    self.navigationItem.title = @"仓库地址";
    
// [self rightBarButtonWithText:@"编辑仓库" textColor:color_666666 textFont:[UIFont systemWEPingFangRegularOfSize:15] target:self selector:@selector(editClick)];
}



-(void)initBaseViews{
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebDataSource) name:@"wareHourseChange" object:nil];
    self.tableView.backgroundColor = color_lightDart_f3f3f3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSKeeperWareHourseCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSKeeperWareHourseCell.class)];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    PSWareHourseListRequest *listRequest = [PSWareHourseListRequest new];
    
    [listRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            NSArray *storage_list = [PSKeeperWareHourseAddModel convertModelWithJsonArr:response.result[@"storage_list"]];
            
            self.sto_region_list = response.result[@"sto_region_list"];
            if (self.pullPageIndex == 1) {
                [self.dataSource setArray:storage_list];
            }else{
                [self.dataSource addObjectsFromArray:storage_list];
            }
            [self.tableView reloadData];
            [self endRefreshingWithCount:storage_list.count];
        }else{
            [self endRefreshingWithCount:-1];
        }
    }];
}

#pragma mark- click
-(void)editClick{
    
    PSWarehourseEditVC *edit = [[PSWarehourseEditVC alloc] initWithSto_id:@""];
    edit.regionList = self.sto_region_list;
    [self.navigationController pushViewController:edit animated:YES];
}

#pragma mark- UItableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[UIView new];
    view.backgroundColor = color_lightDart_f3f3f3;
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSKeeperWareHourseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSKeeperWareHourseCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PSKeeperWareHourseAddModel *model = self.dataSource[indexPath.row];
    cell.label_title.text = model.sto_name;
    cell.label_content.text = [NSString stringWithFormat:@"地址：%@%@",model.sto_region,model.sto_addr];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PSKeeperWareHourseAddModel *model = self.dataSource[indexPath.row];
    PSWarehourseEditVC *edit = [[PSWarehourseEditVC alloc] initWithSto_id:model.sot_id];
    edit.regionList = self.sto_region_list;
    edit.model = model;
    [self.navigationController pushViewController:edit animated:YES];
}



@end
