//
//  PSDropBucketListVCViewController.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSDropBucketListVCViewController.h"

@interface PSDropBucketListCell : UITableViewCell
@property (nonatomic,strong) UILabel *label_title;
@end
@implementation PSDropBucketListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.label_title];
        [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}


-(UILabel *)label_title{
    if (!_label_title) {
        _label_title = [UILabel new];
        _label_title.font = [UIFont systemWEPingFangRegularOfSize:12];
        _label_title.textColor = color_666666;
        _label_title.textAlignment = NSTextAlignmentCenter;
    }
    return _label_title;
}

@end

@interface PSDropBucketListVCViewController ()

@end

@implementation PSDropBucketListVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[PSDropBucketListCell class] forCellReuseIdentifier:NSStringFromClass(PSDropBucketListCell.class)];
    if (@available(ios 13.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}


-(void)setData:(NSArray *)data{
    [self.dataSource setArray:data];
    [self.tableView reloadData];
}

#pragma mark-UItab
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSDropBucketListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSDropBucketListCell.class) forIndexPath:indexPath];
    cell.label_title.text = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.didSelectedIndex) {
        self.didSelectedIndex(indexPath.row);
    }
}

-(BOOL)needPullFooter{
    return NO;
}
-(BOOL)needPullHeader{
    return NO;
}


@end
