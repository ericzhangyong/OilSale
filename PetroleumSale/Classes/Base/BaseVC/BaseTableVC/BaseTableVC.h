//
//  FSBaseTableViewController.h
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

-(UITableViewStyle)re_tableViewStryle;
@end

NS_ASSUME_NONNULL_END
