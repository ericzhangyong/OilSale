//
//  PSStationCarSelectVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2020/2/12.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSStationCarSelectVC.h"
#import "PSStationCarSelectCell.h"
#import "PSStationModel.h"
#import "PSStationSearchView.h"

@interface PSStationCarSelectVC ()

@property (nonatomic,strong) PSStationSearchView *view_search;

@property (nonatomic,strong) NSIndexPath *preIndexPath;
@property (nonatomic,copy) void(^complete)(NSString *car_info_id);

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation PSStationCarSelectVC

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

-(instancetype)initWithDataArray:(NSArray *)data complte:(nonnull void (^)(NSString *car_info_id))complete{
    if (self = [super init]) {
       
        
        [self.dataArr setArray:data];
        [self.dataSource setArray:data];
        self.complete = complete;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebDataSource];
}
-(void)initNavView{
    
    self.navigationItem.title = @"选择车牌号";
}

-(void)initBaseViews{
    
    WEAK_SELF;
    self.view_search.textfieldDidChange = ^(NSString * _Nonnull text) {
        [weakSelf filterListWithText:text];
    };
    [self.view addSubview:self.view_search];
    [self.view_search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_search.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    [self.tableView registerNib:[UINib  nibWithNibName:NSStringFromClass(PSStationCarSelectCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSStationCarSelectCell.class)];
}

-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    [self endRefreshingWithCount:-1];
}

-(void)filterListWithText:(NSString *)text{
    
    
    if ([text isEqualToString:@""] || text == nil) {
        [self.dataSource setArray:self.dataArr];
    }else{
        NSMutableArray *dataTemp = [NSMutableArray array];
        for (PSStationCarModel *model in self.dataArr) {
            if ([model.car_number containsString:text]) {
                [dataTemp addObject:model];
            }
        }
        [self.dataSource setArray:dataTemp];
    }
    
    [self.tableView reloadData];
    [self endRefreshingWithCount:-1];
}


#pragma mark- UITableViewDelgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSStationCarSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSStationCarSelectCell.class) forIndexPath:indexPath];
    PSStationCarModel *model = self.dataSource[indexPath.row];
    
    cell.label_title.text = model.car_number;
//    cell.btn_select.selected = model.isSelected;
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PSStationCarModel *model = self.dataSource[indexPath.row];
    self.complete(model.car_info_id);
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark- layz

-(PSStationSearchView *)view_search{
    if (!_view_search) {
        _view_search =[PSStationSearchView initViewWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    }
    return _view_search;
}

@end
