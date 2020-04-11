//
//  PSPropertyPopHandleView.h
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "BaseView.h"
#import "PSPropertyViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSPropertyPopHandleView : BaseView

@property (weak, nonatomic) IBOutlet UILabel *label_name;

@property (weak, nonatomic) IBOutlet UILabel *label_varity;

@property (weak, nonatomic) IBOutlet UITextField *tf_input;

/// <#des#>
@property (nonatomic,copy) void(^confirmClick)(NSString *storage_id,NSString *back_num,NSString *back_type);

+(instancetype)createHandleView;

-(void)showHandleViewWithPropertyViewModel:(PSPropertyViewModel *)propertyViewModel;

-(void)hiddenView;
@end

NS_ASSUME_NONNULL_END
