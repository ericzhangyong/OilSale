//
//  PSPetrolStationVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPetrolStationVC.h"
#import "PSPetrolStationCell.h"

@interface PSPetrolStationVC ()

//@property (nonatomic,assign) NSInteger preSelectIndex;

@end

@implementation PSPetrolStationVC

-(instancetype)initWithStationArr:(NSArray *)arr{
    if (self = [super init]) {
        
        [self.dataSource setArray:arr];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadWebDataSource];
}

-(void)initNavView{
    
    self.navigationItem.title = @"选择加油点";
}

-(void)initBaseViews{
    
    self.tableView.backgroundColor = color_lightDart_f3f3f3;
    [self.tableView registerNib:[UINib  nibWithNibName:NSStringFromClass(PSPetrolStationCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSPetrolStationCell.class)];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    [self.tableView reloadData];
    [self endRefreshingWithCount:-1];
    
//    PSStationModel *model = [PSStationModel new];
//    model.farp_name = @"上海市闵行区七宝加油点";
//    [self.dataSource addObject:model];
//
//    PSStationModel *model1 = [PSStationModel new];
//    model1.farp_name = @"上海市闵行区航中路加油点";
//    [self.dataSource addObject:model1];
//
//    PSStationModel *model2 = [PSStationModel new];
//    model2.farp_name = @"上海市闵行区七宝加油点";
//    [self.dataSource addObject:model2];
//
//    PSStationModel *model3 = [PSStationModel new];
//    model3.farp_name = @"上海市闵行区七宝加油点";
//    [self.dataSource addObject:model3];
}

#pragma mark- UITableViewDelgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSPetrolStationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSPetrolStationCell.class) forIndexPath:indexPath];
    PSStationModel *model = self.dataSource[indexPath.row];
    
    cell.label_name.text = model.farp_name;
    cell.btn_select.selected = model.isSelected;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    PSStationModel *model = self.dataSource[indexPath.row];

    
    PSPetrolStationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.btn_select.selected = model.isSelected;
    
    self.selectStationBlock(model,indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
