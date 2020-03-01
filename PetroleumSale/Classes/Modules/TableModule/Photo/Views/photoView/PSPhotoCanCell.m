//
//  PSPhotoCanCell.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/17.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSPhotoCanCell.h"
#import "PSCollectionPicCell.h"
#import "UIImageView+BaseWebCache.h"
#import "PSCollectionPhotoImageCell.h"
#import "PSGetUploadPath.h"
#import <AFNetworking/AFNetworking.h>
#import "BasePopSheetView.h"
#import "UIView+BaseCategory.h"
#import "MMAlertView+BaseAlertManger.h"
#import <Photos/Photos.h>
#import "PSUploadImageRequest.h"
#import "UIImage+BaseImageCategory.h"
#import "PSSavePhotoRequest.h"



@interface PSPhotoCanCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView_pic;

@property (weak, nonatomic) IBOutlet UITextField *tf_density;
@property (weak, nonatomic) IBOutlet UITextField *tf_roughWeight;
@property (weak, nonatomic) IBOutlet UITextField *tf_netWeight;
@property (weak, nonatomic) IBOutlet UITextField *tf_volume;

@property (nonatomic,strong) PSPhotoViewModel *photoViewModel;
@property (nonatomic,assign) NSInteger index;


@property (nonatomic,strong)UIImage *uploadHeadImage;
@property (nonatomic,assign)NSInteger uploadTempIndex;


@end

@implementation PSPhotoCanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.collectionView_pic.delegate = self;
    self.collectionView_pic.dataSource =self;
    [self.collectionView_pic registerNib:[UINib nibWithNibName:NSStringFromClass(PSCollectionPhotoImageCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(PSCollectionPhotoImageCell.class)];
    [self.tf_volume addTarget:self action:@selector(volumeChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.tf_roughWeight addTarget:self action:@selector(roughtWeightChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.tf_density addTarget:self action:@selector(densityChanged:) forControlEvents:UIControlEventEditingChanged];

}


-(void)configWithPhotoViewModel:(PSPhotoViewModel *)photoViewModel OrderIndex:(NSInteger)orderIndex{
    self.photoViewModel = photoViewModel;
    self.index = orderIndex;
    
    self.label_title.text = [self.photoViewModel ps_getBucketTitleAtIndex:self.index];
    self.tf_density.text = [self.photoViewModel ps_getBucketDensityAtIndex:self.index];
    self.tf_volume.text = [self.photoViewModel ps_getVolumeAtIndex:self.index];
    self.tf_netWeight.text = [self.photoViewModel ps_getRoughWeightAtIndex:self.index];
    self.tf_roughWeight.text = [self.photoViewModel ps_getGrossWeightAtIndex:self.index];
    
    [self.collectionView_pic reloadData];
}

-(void)volumeChanged:(UITextField *)textField{
    
    //变化优先级 重量 体积 密度
    if (self.tf_density.text.length>0) {
        double netWeight = self.tf_netWeight.text.doubleValue;
        double roughWeight = self.tf_roughWeight.text.doubleValue;
        double density = self.tf_density.text.doubleValue;
        double volume = textField.text.doubleValue;
        roughWeight = volume * density-netWeight;
        if (roughWeight<0) {
            roughWeight = 0;
        }
        NSString *roughWeightStr = [NSString stringWithFormat:@"%.2f",roughWeight];
        self.tf_roughWeight.text = roughWeightStr;
        [self.photoViewModel ps_setGrossWeightWithText:roughWeightStr AtIndex:self.index];
    }else if (self.tf_roughWeight.text.length>0){
        double netWeight = self.tf_netWeight.text.doubleValue;
        double roughWeight = self.tf_roughWeight.text.doubleValue;
        double density = self.tf_density.text.doubleValue;
        double volume = textField.text.doubleValue;
        density = (netWeight +roughWeight)/volume;
        if (density<0) {
            density = 0;
        }
        NSString *densityStr = [NSString stringWithFormat:@"%.2f",density];
        self.tf_density.text = densityStr;
        [self.photoViewModel ps_setDensityWithText:densityStr AtIndex:self.index];
    }
    
    [self.photoViewModel ps_setVolumeWithText:textField.text AtIndex:self.index];
}
-(void)densityChanged:(UITextField *)textField{
    
    //变化优先级 重量 体积 密度
    if (self.tf_volume.text.length>0) {
        double netWeight = self.tf_netWeight.text.doubleValue;
        double roughWeight = self.tf_roughWeight.text.doubleValue;
        double density = self.tf_density.text.doubleValue;
        double volume = textField.text.doubleValue;
        roughWeight = volume * density+netWeight;
        if (roughWeight<0) {
            roughWeight = 0;
        }
        NSString *roughWeightStr = [NSString stringWithFormat:@"%.2f",roughWeight];
        self.tf_roughWeight.text = roughWeightStr;
        [self.photoViewModel ps_setGrossWeightWithText:roughWeightStr AtIndex:self.index];
    }else if (self.tf_roughWeight.text.length>0){
        double netWeight = self.tf_netWeight.text.doubleValue;
        double roughWeight = self.tf_roughWeight.text.doubleValue;
        double density = self.tf_density.text.doubleValue;
        double volume = textField.text.doubleValue;
        volume = (netWeight +roughWeight)/density;
        if (volume<0) {
            volume = 0;
        }
        NSString *volumeStr = [NSString stringWithFormat:@"%.2f",volume];
        self.tf_volume.text = volumeStr;
        [self.photoViewModel ps_setVolumeWithText:volumeStr AtIndex:self.index];
    }
    [self.photoViewModel ps_setDensityWithText:textField.text AtIndex:self.index];
}

-(void)roughtWeightChanged:(UITextField *)textField{
    
    //变化优先级 重量 体积 密度
    if (self.tf_density.text.length>0) {
        double netWeight = self.tf_netWeight.text.doubleValue;
        double roughWeight = self.tf_roughWeight.text.doubleValue;
        double density = self.tf_density.text.doubleValue;
        double volume = textField.text.doubleValue;
        volume = (netWeight +roughWeight)/density;
        if (volume<0) {
            volume = 0;
        }
        NSString *volumeStr = [NSString stringWithFormat:@"%.2f",volume];
        self.tf_volume.text = volumeStr;
        [self.photoViewModel ps_setVolumeWithText:volumeStr AtIndex:self.index];
    }else if (self.tf_volume.text.length>0){
        double netWeight = self.tf_netWeight.text.doubleValue;
        double roughWeight = self.tf_roughWeight.text.doubleValue;
        double density = self.tf_density.text.doubleValue;
        double volume = textField.text.doubleValue;
        density = (netWeight +roughWeight)/volume;
        if (density<0) {
            density = 0;
        }
        NSString *densityStr = [NSString stringWithFormat:@"%.2f",density];
        self.tf_density.text = densityStr;
        [self.photoViewModel ps_setDensityWithText:densityStr AtIndex:self.index];
    }
    [self.photoViewModel ps_setGrossWeightWithText:textField.text AtIndex:self.index];

}



#pragma mark- UITableViewDelegate DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;//[self.photoViewModel ps_getBucketCountAtIndex:self.index];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(95, 125);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PSCollectionPhotoImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(PSCollectionPhotoImageCell.class) forIndexPath:indexPath];
    
    NSString *title = @"油品确认";
    if (indexPath.row == 0) {
        title = @"油品确认";
    }else if (indexPath.row == 1){
        title = @"油品测量中";
    }else if (indexPath.row == 2){
        title = @"油量测量读数";
    }
    cell.label_title.text = title;
    NSString *imageUrl = [self.photoViewModel ps_getBucketImgeUrlAtIndex:self.index row:indexPath.row];
    if ([self.photoViewModel ps_getBucketIsShowAddIconAtIndex:self.index row:indexPath.row] || ![imageUrl containsString:@"http"]) {
        UIImage *image = [self.photoViewModel ps_getImageAtIndex:self.index row:indexPath.row];
        if (image) {
            cell.imageView_content.image =image;
        }else{
            cell.imageView_content.image = [UIImage imageNamed:@"pic_adress"];
        }
    }else{
        UIImage *image = [self.photoViewModel ps_getImageAtIndex:self.index row:indexPath.row];
        if (image) {
            cell.imageView_content.image =image;
        }else{
            [cell.imageView_content setImageWithUrl:imageUrl placeholder:defaultHolder160_160];
        }
    }
    WEAK_SELF;
    cell.btn_Delete.hidden = YES;//![self.photoViewModel ps_getBucketIsShowDeleteBtnAtIndex:self.index row:indexPath.row];
    cell.collectionDidClick = ^(NSInteger clickType) {
        if (clickType == 1) {//添加
            weakSelf.uploadTempIndex = indexPath.row;
            [self updateBtnClick];
        }else if (clickType == 2){//delete
            
        }
    };
    return cell;
}

- (void)updateBtnClick {

    NSArray *titles = @[@"拍照", @"从手机相册中选择"];

    UIView *view = [UIApplication sharedApplication].keyWindow;
    BasePopSheetView *sheet = [BasePopSheetView showPopSheet:view buttonTitles:titles];
    [sheet showPopSheetWithAction:^(NSString *title, NSInteger idx) {
        
        if (idx == 0) {
            [self onCameraBtn];
        }else if (idx == 1){
            [self onPhotoLibraryBtn];
        }
    }];
}

-(void)requestAuth{
    [self requestCamera];
    [self requestPhoto];
}

-(void)requestCamera{
    BOOL authStatusCamer = [self ff_CameraPermission];
    if (!authStatusCamer) {
        [MMAlertView showWithTitle:@"请在iPhone的“设置-隐私-相机”选项中，允许虫虫之家访问你的相机。" detail:@"" sureBtn:@"好"];
        return ;
    }
}
-(void)requestPhoto{
    if (![self albumPermission]) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == 3) {
                    
                }else if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted){
                    [MMAlertView showWithTitle:@"请在iPhone的“设置”选项中，允许虫虫之家访问你的相册。" detail:@"" sureBtn:@"好"];
                }else{
                }
            }];
    }
}

- (void)onCameraBtn {
    if (![self ff_CameraPermission]) {
        [self requestCamera];
        return;
    }

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self.viewController presentViewController:picker animated:YES completion:nil];
}

- (void)onPhotoLibraryBtn {
    
    if (![self albumPermission]) {
        [self requestPhoto];
        return;
    }
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self.viewController presentViewController:picker animated:YES completion:nil];
}


#pragma mark - 相机
- (BOOL)ff_CameraPermission; {
    if (TARGET_IPHONE_SIMULATOR) {
        return YES;
    }
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

- (BOOL)albumPermission {

    
    PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
    
    if(author == PHAuthorizationStatusRestricted || author ==PHAuthorizationStatusDenied){
        //无权限
        return NO;
    }else{
        return YES;
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if (selectImage) {
        //用于显示的图片
//        CGSize coverSize = CGSizeMake(100, 100);
//        UIImage *selectedImage = [selectImage imageByResizeToSize:coverSize
//                                  contentMode:UIViewContentModeScaleAspectFill];

        //上传服务器的图片
        CGSize uploadSize = CGSizeMake(100, 100);
        self.uploadHeadImage = [selectImage imageByResizeToSize:uploadSize
                                                       contentMode:UIViewContentModeScaleAspectFill];
    }
    
    picker.delegate = nil;
    [self getUploadToken];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    picker.delegate = nil;
}


#pragma mark - 头像上传
- (void)getUploadToken {
    
    
    NSString *url = [self.photoViewModel ps_getBucketUploadImgeUrlAtIndex:self.index row:self.uploadTempIndex];
    PSUploadImageRequest *uploadRequest =[PSUploadImageRequest new  ];
    uploadRequest.url = url;
    [uploadRequest uploadWithPUTImage:self.uploadHeadImage fileName:@"123" Completed:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            //
            [MBProgressHUD toastMessageAtMiddle:@"上传成功"];
            [self.photoViewModel ps_setImageWithImage:self.uploadHeadImage AtIndex:self.index row:self.uploadTempIndex];
            [self.collectionView_pic reloadData];
        }
    }];
}


@end
