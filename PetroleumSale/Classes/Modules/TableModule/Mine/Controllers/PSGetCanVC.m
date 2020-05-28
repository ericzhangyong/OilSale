//
//  PSGetCanVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/14.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSGetCanVC.h"
#import "PSHistoryNameCell.h"
#import "UICollectionView+ZYCalculateCollectionHeight.h"
#import "NSString+RECategory.h"
#import "PSGetCanRequest.h"
#import "NSString+RECategory.h"

@interface PSGetCanVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UITextField *tf_phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *tf_tieCan;
@property (weak, nonatomic) IBOutlet UITextField *tf_dunCan;
@property (weak, nonatomic) IBOutlet UITextField *tf_oilGun;


@property (weak, nonatomic) IBOutlet UICollectionView *collection_historyName;
@property (weak, nonatomic) IBOutlet UIButton *btn_save;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight_collectionHistory;

@property (nonatomic,strong) NSMutableArray *historyNameArr;



@property (nonatomic,copy) void (^blcok)(void);

/// <#des#>
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *bucketType;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *oilGun;


@end

@implementation PSGetCanVC

-(instancetype)initWithPhone:(NSString *)phone BucketType:(NSString *)bucketType Count:(NSString *)count oidGunCOunt:(nonnull NSString *)oilGun{
    if (self = [super init]) {
        self.phone = phone;
        self.bucketType = bucketType;
        self.count = count;
        self.oilGun = oilGun;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
}

-(void)initBaseDatas{
    
    self.historyNameArr = @[].mutableCopy;
    NSArray *historyName =  [[NSUserDefaults standardUserDefaults ] objectForKey:@"historyNameArr"];
    if (historyName!=nil) {
        [self.historyNameArr setArray:historyName];
    }
    
    CGFloat height = [UICollectionView  getContentViewHeightWithDataSource:self.historyNameArr textFont:[UIFont systemWEPingFangRegularOfSize:14] collectionViewWidth:kScreenWidth-30 rowHeight:24 minLine:10 minItem:10];
    if (height<30) {
        height = 30;
    }
    self.layoutHeight_collectionHistory.constant = height;
}

-(void)initNavView{
    
    self.navigationItem.title = @"我要收桶";
}

-(void)initBaseViews{
    
    self.collection_historyName.backgroundColor = [UIColor whiteColor];
    self.collection_historyName.delegate = self;
    self.collection_historyName.dataSource = self;
    [self.collection_historyName registerNib:[UINib nibWithNibName:NSStringFromClass(PSHistoryNameCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(PSHistoryNameCell.class)];
    
    [self.collection_historyName reloadData];
    
    if ([self.bucketType isEqualToString:@"铁桶装"]) {
        self.tf_tieCan.text = self.count;
    }else if([self.bucketType isEqualToString:@"加油枪"]){
        self.tf_oilGun.text = self.count;
    }
    else{
        self.tf_dunCan.text = self.count;
    }
    self.tf_phoneNum.text = self.phone;
    self.tf_oilGun.text = self.oilGun;
}


#pragma mark- UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.historyNameArr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = self.historyNameArr[indexPath.row];
    CGFloat width = [title widthWithFont:[UIFont systemWEPingFangRegularOfSize:14]];
    return CGSizeMake(width+28, 24);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PSHistoryNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(PSHistoryNameCell.class) forIndexPath:indexPath];
    cell.label_name.text = self.historyNameArr[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
//    self.tf_nickName.text = self.historyNameArr[indexPath.row];
}

- (IBAction)actionSave:(UIButton *)sender {
    
    
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_phoneNum.text.getNoWhiteLineAndSpaceString] ) {
        [MBProgressHUD toastMessageAtMiddle:@"请输入客户联系方式"];
        return;
    }
    if ([BaseVerifyUtils isNullOrSpaceStr:self.tf_tieCan.text.getNoWhiteLineAndSpaceString] &&
        [BaseVerifyUtils isNullOrSpaceStr:self.tf_dunCan.text.getNoWhiteLineAndSpaceString]&&
        [BaseVerifyUtils isNullOrSpaceStr:self.tf_oilGun.text.getNoWhiteLineAndSpaceString]) {
        
        [MBProgressHUD toastMessageAtMiddle:@"请输入收桶数量"];
        return;
    }
    
    PSGetCanRequest *canRequest = [PSGetCanRequest new];
    canRequest.phone_num= self.tf_phoneNum.text.getNoWhiteLineAndSpaceString;
    canRequest.bucket_num = self.tf_tieCan.text.getNoWhiteLineAndSpaceString.integerValue;
    canRequest.ibc_num = self.tf_dunCan.text.getNoWhiteLineAndSpaceString.integerValue;
    canRequest.nozzle_num = self.tf_oilGun.text.getNoWhiteLineAndSpaceString.integerValue;
    [canRequest postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            [MBProgressHUD toastMessageAtMiddle:@"发送成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
//    [self.historyNameArr addObject:self.tf_nickName.text];
//    [[NSUserDefaults standardUserDefaults] setObject:self.historyNameArr forKey:@"historyNameArr"];
//    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dealloc{
    
    NSLog(@"dealloc");
}
@end
