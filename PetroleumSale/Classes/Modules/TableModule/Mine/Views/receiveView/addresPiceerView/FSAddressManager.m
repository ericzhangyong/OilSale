//
//  WEAddressManager.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/26.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "FSAddressManager.h"
#import "FSAddressRequest.h"

@implementation FSAddressManager

+(instancetype)shareManager{
    
    static FSAddressManager *pickerManager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pickerManager = [FSAddressManager new];
    });
    return pickerManager;
}

-(void)getAddressInfo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *resultDict =jsonData[@"result"];
    [self parseDataWithDict:resultDict];
}

-(void)we_requestAddress{
    
//    FSAddressRequest *addressRquest = [FSAddressRequest new];
//    WEAK_SELF;
//    [addressRquest getRequestCompleted:^(WEBaseResponse * _Nonnull response) {
//        if (response.isFinished) {
//            NSDictionary *jsonData = response.result;
//            [weakSelf parseDataWithDict:jsonData];
//        }
//    }];
}

-(void)parseDataWithDict:(NSDictionary *)resultDict{
    
    self.provinceArray = resultDict[@"children"];
    self.cityArray = [self getCityArrayAtIndex:0];
    self.areaArray = [self getAreaArrayAtIndex:0];
}

-(NSInteger)getProviceCount{
    return self.provinceArray.count;
}
-(NSInteger)getCityCount{
    return self.cityArray.count;
}
-(NSInteger)getAreaCount{
    return self.areaArray.count;
}


-(NSArray *)getCityArrayAtIndex:(NSInteger)index
{
    if (index >= self.provinceArray.count) {
        return nil;
    }
    self.cityArray = [self.provinceArray[index] objectForKey:@"children"];
    return self.cityArray;
}
-(NSArray *)getAreaArrayAtIndex:(NSInteger)index
{
    if (index >= self.cityArray.count) {
        return nil;
    }
    self.areaArray = [self.cityArray[index] objectForKey:@"children"];
    return self.areaArray;
}

-(NSString *)getProvinceNameAtIndex:(NSInteger)index{
    if (index>=self.provinceArray.count) {
        return @"";
    }
    return [self.provinceArray[index] objectForKey:@"districtName"];
}
-(NSString *)getCityNameAtIndex:(NSInteger)index{
    if (index>=self.cityArray.count) {
        return @"";
    }
    return [self.cityArray[index] objectForKey:@"districtName"];
}
-(NSString *)getAreaNameAtIndex:(NSInteger)index{
    if (index>=self.areaArray.count) {
        return @"";
    }
    return [self.areaArray[index] objectForKey:@"districtName"];
}
-(NSString *)getProvinceCodeAtIndex:(NSInteger)index{
    if (index>=self.provinceArray.count) {
        return @"";
    }
    return [self.provinceArray[index] objectForKey:@"districtId"];
}
-(NSString *)getCityCodeAtIndex:(NSInteger)index{
    if (index>=self.areaArray.count) {
        return @"";
    }
    return [self.cityArray[index] objectForKey:@"districtId"];
}
-(NSString *)getAreaCodeAtIndex:(NSInteger)index{
    if (index>=self.areaArray.count) {
        return @"";
    }
    return [self.areaArray[index] objectForKey:@"districtId"];
}

-(NSString *)getcityCodeWithCityName:(NSString *)cityName{
    
    for (int i =0; i<self.provinceArray.count; i++) {
        
        NSArray *cityList =  [self getCityArrayAtIndex:i];
        for (int j = 0; j<cityList.count; j++) {
            NSDictionary *cityDict = cityList[j];
            if ([[cityDict objectForKey:@"districtName"] isEqualToString:cityName]) {
                return [cityDict objectForKey:@"districtId"];
            }
        }
    }
    return @"";
}
-(NSString *)getProvienceCodeWithProvienceName:(NSString *)provienceName{
    
    for (int i =0; i<self.provinceArray.count; i++) {
        NSDictionary *proviencDict = self.provinceArray[i];
        
        if ([provienceName isEqualToString:proviencDict[@"districtName"]]) {
            return proviencDict[@"districtId"];
        }
    }
    return @"";
}


@end
