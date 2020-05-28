//
//  FPHeadImageViewController.m
//  Funmily
//
//  Created by zhangyong on 16/11/8.
//  Copyright © 2016年 HuuHoo. All rights reserved.
//

#import "PSHeadImageViewController.h"
#import "UIImageView+BaseWebCache.h"
#import "UIImage+BaseImageCategory.h"
#import "BasePopSheetView.h"
//#import "MMAlertView.h"
#import "PSGetUploadPath.h"
#import "PSUploadImageRequest.h"
#import "MMAlertView+BaseAlertManger.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
#import <AFNetworking.h>
#import "PSSaveUploadImageUrl.h"
#import "BaseRequestHeader.h"
#import<AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "PSGetCheckImageRequest.h"
#import "UserInfoProfile.h"
#import "PSImageModel.h"
#import "PSHeadImageCell.h"

static CGFloat const SubmitCoverWidth               =       53;
static CGFloat const SubmitCoverUploadWidth         =       300;
#define PTSubmitVCScreelScale         [UIScreen mainScreen].scale
@interface PSHeadImageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *updateHeadImageBtn;
@property (weak, nonatomic) IBOutlet UIView *aboveLineView;
@property (weak, nonatomic) IBOutlet UIView *downLineView;
@property (nonatomic,copy)NSString *headImgPath;
@property (nonatomic,strong)UIImage *editHeadImage;
@property (nonatomic,strong)UIImage *uploadHeadImage;

@property (nonatomic,assign)BOOL isHiddenUploadBtn;

@property (nonatomic,assign) NSInteger currentIndex;


/// 是否可以编辑
@property (nonatomic,assign) BOOL if_can_edit;

@end

@implementation PSHeadImageViewController

-(instancetype)initWithHeadImagePath:(NSString *)headImgPath HeadImagePickComplete:(HeadImagePickComplete)headImagePickComplete {

    if (self = [super init]) {
        self.headImgPath = headImgPath;
        self.headImagePickComplete = headImagePickComplete;
    }
    return self;
}

-(instancetype)initWithHeadImagePath:(NSString *)headImgPath
                   isHiddenUploadBtn:(BOOL)isHiddenUploadBtn {

    if (self = [super init]) {
        self.headImgPath = headImgPath;
        self.isHiddenUploadBtn = isHiddenUploadBtn;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self getImageUrl];
    
    
    [self initTableView];
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
}


- (void)setUpUI {
    
    self.currentIndex = 0;
    self.navigationItem.title = @"审核图片";
//    self.navigationItem.rightBarButtonItem = [self barButtonWithText:@"添加" textColor:color_333333 textFont:[UIFont systemWEPingFangRegularOfSize:16] target:self selector:@selector(updateBtnClick:)];
    //btn
//    self.updateHeadImageBtn.layer.masksToBounds = YES;
//    self.updateHeadImageBtn.layer.cornerRadius = 5.0f;
//    self.updateHeadImageBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.updateHeadImageBtn.layer.borderWidth = 1.0;
//    [self.updateHeadImageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//    [self.updateHeadImageBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
//    [self.updateHeadImageBtn addTarget:self action:@selector(updateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    //headImageView
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageGestuer:)];
//    self.headImageView.userInteractionEnabled = YES;
//    [self.headImageView addGestureRecognizer:gesture];
//    self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.headImageView.clipsToBounds = NO   ;
//
//    self.aboveLineView.hidden= YES;
//    self.downLineView.hidden = YES;
//    self.view.backgroundColor = color_lightDart_f3f3f3;
//    if ([self.headImgPath hasPrefix:@"http"]) {
//        [self.headImageView setImageWithUrl:self.headImgPath placeholder:defaultHolder160_160];
//    }else{
//        NSData *imageData = [NSData dataWithContentsOfFile:self.headImgPath];
//        UIImage *image = [UIImage imageWithData:imageData];
//        if (image) {
//            self.headImageView.image = image;
//        }else{
//            self.headImageView.image = defaultHolder160_160;
//        }
//    }
//
//    if (self.isHiddenUploadBtn == YES) {
//        self.updateHeadImageBtn.hidden = YES;
//    }else{
//        self.updateHeadImageBtn.hidden = YES;
//    }
//
//
//    [self requestAuth];
    
}

-(void)initTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(PSHeadImageCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PSHeadImageCell.class)];
}


-(void)loadWebDataSource{
    [super loadWebDataSource];
    
    [self getImageUrl];
}

-(UITableViewStyle)re_tableViewStryle{
    return UITableViewStyleGrouped;
}



-(void)getImageUrl{
    
    PSGetCheckImageRequest *getImage = [PSGetCheckImageRequest new];
    [getImage postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            
            NSArray *data = response.result[@"verify_pic_urls"];
//            NSDictionary *dict = data.lastObject;
            NSArray *imageArr = [PSImageModel  convertModelWithJsonArr:data];
//            if (imageArr.count<=1) {
                [self.dataSource setArray:imageArr];
            [self endRefreshingWithCount:-1];
            [self.tableView reloadData];
            
            if (self.dataSource.count>=2) {
                self.navigationItem.rightBarButtonItem = nil;
            }
//            }else{
//                [self.dataSource addObjectsFromArray:[imageArr subarrayWithRange:NSMakeRange(imageArr.count-2, 2)]];
//            }
            
            
//            self.headImgPath = dict[@"file_url"];
//            [self.headImageView setImageWithUrl:self.headImgPath placeholder:defaultHolder160_160];
//
//            NSNumber *if_can_edit = response.result[@"if_can_edit"];
//            self.if_can_edit = if_can_edit.boolValue;
//            self.navigationItem.rightBarButtonItem.enabled = self.if_can_edit;
        }
    }];
}

#pragma mark- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;//self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section<self.dataSource.count) {
        PSImageModel *model  = self.dataSource[indexPath.section];
        if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
            return kScreenWidth*model.imageSize.height*1.0/model.imageSize.width;
        }
    }
    return 295;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = color_F3F3F3;
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PSHeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PSHeadImageCell.class) forIndexPath:indexPath];
    
    if (indexPath.section<self.dataSource.count) {
        cell.imageView_icon.hidden = YES;
        cell.btn_update.hidden = NO;
        PSImageModel *model  = self.dataSource[indexPath.section];
        [cell.imageView_header setImageWithUrl:model.file_url placeholder:defaultHolder750_400 completeBlock:^(UIImage * _Nonnull image, BOOL isFinish) {
            if (CGSizeEqualToSize(model.imageSize, CGSizeZero) && image !=nil) {
                model.imageSize = image.size;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }else{
        cell.imageView_icon.hidden = NO;
        cell.btn_update.hidden = YES;
        cell.imageView_icon.image = [UIImage imageNamed:@"hp_icon_add"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    self.currentIndex  = indexPath.section;
    [self updateBtnClick:nil];
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


- (UIBarButtonItem *)barButtonWithText:(nullable NSString *)text textColor:(nonnull UIColor *)textColor textFont:(nonnull UIFont *)textFont target:(nullable id)target selector:(nullable SEL)selector {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:target action:selector];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName,textColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName,textColor, NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    return barButtonItem;
}

- (void)imageGestuer:(UITapGestureRecognizer *)gesture {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateBtnClick:(UIButton *)button {

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
//    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)onPhotoLibraryBtn {
    
    if (![self albumPermission]) {
        [self requestPhoto];
        return;
    }
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
//    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 头像上传
- (void)getUploadToken {
    
    
    PSGetUploadPath *getUploadPath = [PSGetUploadPath new];
    getUploadPath.req_url_num = 2;
    [getUploadPath postRequestCompleted:^(BaseResponse * _Nonnull response) {
        if (response.isFinished) {
            NSArray *data =response.result;
            
            if (data.count>0) {
                
                if(self.currentIndex<data.count){
                    NSDictionary *dict = data[self.currentIndex];
                   
                    NSNumber *upload_id = dict[@"upload_id"];
                    NSString *upload_url = dict[@"upload_url"];
                    PSUploadImageRequest *uploadRequest =[PSUploadImageRequest new  ];
                    uploadRequest.url = upload_url;
                    [uploadRequest uploadWithPUTImage:self.uploadHeadImage fileName:@"123" Completed:^(BaseResponse * _Nonnull response) {
                        if (response.isFinished) {
                            PSSaveUploadImageUrl *save = [PSSaveUploadImageUrl new];
                            if (upload_id) {
                                save.upload_id = upload_id.integerValue;
                            }
                            
                            [save postRequestCompleted:^(BaseResponse * _Nonnull response) {
                                if (response.isFinished) {
                                    [self loadWebDataSource];
                                }
                            }];
                        }
                    }];
                }
            }
        }
    }];
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (selectImage) {
        //用于显示的图片
        CGSize coverSize = CGSizeMake(SubmitCoverWidth, SubmitCoverWidth);
        UIImage *selectedImage = [selectImage imageByResizeToSize:coverSize
                                  contentMode:UIViewContentModeScaleAspectFill];

        self.editHeadImage = selectedImage;
        //上传服务器的图片
        CGFloat height = 1.0*kScreenWidth*selectImage.size.height/selectImage.size.width;
        CGSize uploadSize = CGSizeMake(kScreenWidth, height);
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


@end
