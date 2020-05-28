//
//  PSPropertyPopHandleView.m
//  PetroleumSale
//
//  Created by 张勇 on 2020/4/9.
//  Copyright © 2020 eric. All rights reserved.
//

#import "PSPropertyPopHandleView.h"
#import "PSDropMenuView.h"
#import "PSDropBucketListVCViewController.h"
#import "UIView+BaseFrame.h"


@interface PSPropertyPopHandleView()
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew_name;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_varity;
@property (weak, nonatomic) IBOutlet UIView *view_background;
@property (weak, nonatomic) IBOutlet UIView *view_conatin;

@property (weak, nonatomic) IBOutlet UIControl *control_name;
@property (weak, nonatomic) IBOutlet UIControl *control_varity;

@property (nonatomic,strong) PSPropertyViewModel *propertyViewModel;
/// <#des#>
@property (nonatomic,copy) NSString *storage_id;
@property (nonatomic,copy) NSString *back_type;

@end

@implementation PSPropertyPopHandleView

+(instancetype)createHandleView{
    
    PSPropertyPopHandleView *instance = [[NSBundle mainBundle] loadNibNamed:@"PSPropertyPopHandleView" owner:self options:nil].lastObject;
    return instance;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.imageVIew_name.image = [UIImage imageNamed:@"news_icon_down"];
    self.imageView_varity.image = [UIImage imageNamed:@"news_icon_down"];

    self.view_background.alpha = 0.4;
    self.view_conatin.layer.masksToBounds = YES;
    self.view_conatin.layer.cornerRadius = 4;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
    [self.view_background addGestureRecognizer:ges];
    self.label_name.text = @"请选择仓库";
    self.label_varity.text = @"请选择类别";
}

- (IBAction)actionConfirmClick:(UIButton *)sender {

    if ([self.label_name.text isEqualToString:@"请选择仓库"]) {
        [MBProgressHUD toastMessageAtMiddle:@"请选择仓库"];
        return;
    }
    if ([self.label_varity.text isEqualToString:@"请选择类别"]) {
        [MBProgressHUD toastMessageAtMiddle:@"请选择类别"];
        return;
    }
    
    
    if (self.confirmClick) {
        self.confirmClick(self.storage_id, self.tf_input.text, self.back_type);
    }
    [self hiddenView];
}

- (IBAction)actionNameSelected:(UIControl *)sender {

    if (sender.selected) {
        sender.selected = NO;
        self.imageVIew_name.image = [UIImage imageNamed:@"news_icon_down"];

    }else{
        self.imageVIew_name.image = [UIImage imageNamed:@"news_icon_up"];
        sender.selected = YES;
        [self showNameDropMenu];
    }
    
}
- (IBAction)actionVaritySelected:(UIControl *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
          self.imageView_varity.image = [UIImage imageNamed:@"news_icon_up"];
      }else{
          self.imageView_varity.image = [UIImage imageNamed:@"news_icon_down"];
          sender.selected = YES;
          [self showDropMenu];
      }
}

-(void)showHandleViewWithPropertyViewModel:(PSPropertyViewModel *)propertyViewModel{
    
    self.propertyViewModel = propertyViewModel;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.view_conatin.alpha = 0;
    self.frame = window.frame;
    [window addSubview:self];
    self.view_background.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.view_conatin.alpha = 1;
        self.view_background.alpha = 0.4;
    }];
    
}
-(void)hiddenView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view_background.alpha = 0;
        self.view_conatin.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)showDropMenu{
    
    NSArray *storeNamArr = self.propertyViewModel.getNameArr;
    if (storeNamArr.count==0) {
        [MBProgressHUD toastMessageAtMiddle:@"没有可选仓库列表"];
        return;
    }
    
    PSDropMenuView *menu = [[PSDropMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    PSDropBucketListVCViewController *listVC = [[PSDropBucketListVCViewController alloc] init];
    listVC.view.width = 100;
    listVC.view.height = 91;
    menu.contentVC = listVC;
    [listVC setData:self.propertyViewModel.getVarityArr];;
    [menu showDropUpViewFromParentView:self.imageView_varity SuperView:self];
    menu.hiddenBlock = ^(BOOL isHidden) {
        if (isHidden) {
            self.control_varity.selected = NO;
            self.imageView_varity.image = [UIImage imageNamed:@"news_icon_up"];
        }
    };
    listVC.didSelectedIndex = ^(NSInteger index) {
        
        self.control_varity.selected = NO;
        self.imageView_varity.image = [UIImage imageNamed:@"news_icon_up"];

        [self actionNameSelected:self.control_varity];
        NSString *str = self.propertyViewModel.getVarityArr[index];
        self.label_varity.text = str;
        [menu hideDropUpView];
    };
}

-(void)showNameDropMenu{
    
    NSArray *storeNamArr = self.propertyViewModel.getNameArr;
    if (storeNamArr.count==0) {
        [MBProgressHUD toastMessageAtMiddle:@"没有可选仓库列表"];
        return;
    }
    
    PSDropMenuView *menu = [[PSDropMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    PSDropBucketListVCViewController *listVC = [[PSDropBucketListVCViewController alloc] init];
    listVC.view.width = 100;
    
    CGFloat heigth = 30*self.propertyViewModel.getNameArr.count;
    if (heigth >300) {
        heigth= 300;
    }else if (heigth<50){
        heigth = 50;
    }
    listVC.view.height = heigth;
    menu.contentVC = listVC;
    
    [listVC setData:storeNamArr];;
    [menu showDropUpViewFromParentView:self.imageVIew_name SuperView:self];
    menu.hiddenBlock = ^(BOOL isHidden) {
        if (isHidden) {
            self.control_name.selected = NO;
            self.imageVIew_name.image = [UIImage imageNamed:@"news_icon_down"];
        }
    };
    listVC.didSelectedIndex = ^(NSInteger index) {
        self.control_name.selected = NO;
        self.imageVIew_name.image = [UIImage imageNamed:@"news_icon_down"];

        
        [self actionNameSelected:self.control_name];
        self.back_type = [self.propertyViewModel getVarityArrTypeAtIndex:index];
        self.storage_id = [self.propertyViewModel ps_getStorage_idAtIndex:index];
        NSString *str = self.propertyViewModel.getNameArr[index];
        self.label_name.text = str;
        [menu hideDropUpView];
    };
}

@end
