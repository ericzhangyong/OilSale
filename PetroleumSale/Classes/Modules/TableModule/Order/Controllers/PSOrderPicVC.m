//
//  PSOrderPicVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/7.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSOrderPicVC.h"
#import "PSOrderViewModel.h"
#import "PSOrderPicCell.h"
#import <objc/NSObjCRuntime.h>

@interface PSOrderPicVC ()
@property (nonatomic,strong) PSOrderViewModel *orderViewModel;
@property (nonatomic,assign) NSInteger orderIndex;

@end
@implementation PSOrderPicVC

-(instancetype)initWithOrderViewModel:(PSOrderViewModel *)orderViewModel orderIndex:(NSInteger)orderIndex{
    if (self = [super init]) {
        self.orderViewModel = [orderViewModel copy];
        self.orderIndex = orderIndex;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
}
-(void)initNavView{
    self.navigationItem.title = @"到货照片";
}

-(void)initBaseViews{
    
    self.tableView.backgroundColor = color_lightDart_f3f3f3;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSOrderPicCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSOrderPicCell.class)];
}



#pragma mark- UITableViewDelegate DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.orderViewModel ps_getPicsArrAtIndex:self.orderIndex].count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 298-125+(kScreenWidth-30*3)/3.0+30+30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view  = [UIView new];
    view.backgroundColor = color_lightDart_333333;
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSOrderPicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSOrderPicCell.class) forIndexPath:indexPath];
    
    [cell configWithOrderViewModel:self.orderViewModel OrderIndex:self.orderIndex row:indexPath.section];
    return cell;
}


#pragma mark-lazy
-(PSOrderViewModel *)orderViewModel{
    if (!_orderViewModel) {
        _orderViewModel = [PSOrderViewModel new];
    }
    return _orderViewModel;
}


-(BOOL)needPullHeader{
    return NO;
}

-(BOOL)needPullFooter{
    return NO;
}

@end
