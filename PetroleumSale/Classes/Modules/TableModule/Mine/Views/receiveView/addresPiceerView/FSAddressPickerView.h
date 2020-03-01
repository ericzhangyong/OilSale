//
//  WEAddressPickerView.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/26.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSAddressManager.h"

NS_ASSUME_NONNULL_BEGIN
@protocol AddressPickerDelegate <NSObject>
@optional
/** 代理方法返回省市区*/
- (void)addressPickerWithProvince:(NSString *)province
                               city:(NSString *)city
                               area:(NSString *)area
                       ProvinceCode:(NSString *)provinceCode
                           cityCode:(NSString *)cityCode
                           areaCode:(NSString *)areaCode;

@end
@interface FSAddressPickerView : UIView

@property (nonatomic,strong) FSAddressManager *manager;


/** 省 */
@property (nonatomic, strong) NSString *province;
/** 市 */
@property (nonatomic, strong) NSString *city;
/** 区 */
@property (nonatomic, strong) NSString *area;
/** 省code */
@property (nonatomic, strong) NSString *provinceCode;
/** 市code */
@property (nonatomic, strong) NSString *cityCode;
/** 区code */
@property (nonatomic, strong) NSString *areaCode;

@property (nonatomic, weak) id<AddressPickerDelegate> delegate;


- (void)updateAddressAtProvince:(NSString *)province city:(NSString *)city town:(NSString *)town;
/** 内容字体 */
@property (nonatomic, strong) UIFont *font;

-(void)showPickerViewAtSuperView:(UIView *)superView;
@end

NS_ASSUME_NONNULL_END
