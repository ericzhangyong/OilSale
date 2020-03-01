//
//  WEAddressManager.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/26.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSAddressManager : NSObject
@property (nonatomic,copy) NSArray *provinceArray;
@property (nonatomic,copy) NSArray *cityArray;
@property (nonatomic,copy) NSArray *areaArray;

+(instancetype)shareManager;


-(void)getAddressInfo;

-(NSInteger)getProviceCount;
-(NSInteger)getCityCount;
-(NSInteger)getAreaCount;


-(NSString *)getProvinceNameAtIndex:(NSInteger)index;
-(NSString *)getCityNameAtIndex:(NSInteger)index;
-(NSString *)getAreaNameAtIndex:(NSInteger)index;

-(NSString *)getProvinceCodeAtIndex:(NSInteger)index;
-(NSString *)getCityCodeAtIndex:(NSInteger)index;
-(NSString *)getAreaCodeAtIndex:(NSInteger)index;

-(NSArray *)getCityArrayAtIndex:(NSInteger)index;
-(NSArray *)getAreaArrayAtIndex:(NSInteger)index;


-(NSString *)getcityCodeWithCityName:(NSString *)cityName;
-(NSString *)getProvienceCodeWithProvienceName:(NSString *)provienceName;


-(void)we_requestAddress;

@end

NS_ASSUME_NONNULL_END
