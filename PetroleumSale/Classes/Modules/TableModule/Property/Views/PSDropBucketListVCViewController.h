//
//  PSDropBucketListVCViewController.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BasePullTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSDropBucketListVCViewController : BasePullTableVC


-(void)setData:(NSArray *)data;


/// <#des#>
@property (nonatomic,copy) void(^didSelectedIndex)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
