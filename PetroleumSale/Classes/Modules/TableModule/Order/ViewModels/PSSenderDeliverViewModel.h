//
//  PSSenderDeliverViewModel.h
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/23.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseViewModel.h"
#import "PSSenderDeliveryModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,PSSenderDeliverListType){
    PSSenderDeliverListTypeSended, //已派送
    PSSenderDeliverListTypeUnSended, //未派送
    PSSenderDeliverListTypePickOneSelf //自提单

};
@interface PSSenderDeliverViewModel : BaseViewModel


@property (nonatomic,assign) PSSenderDeliverListType listType;


#pragma mark -数据处理

-(NSString *)ps_getDeliverNoAtIndex:(NSInteger)index;
-(NSString *)ps_getDeliverWay_bill_idAtIndex:(NSInteger)index;
-(NSArray *)ps_getDeliverOrderIdArr;
-(NSString *)ps_getImageUrlAtIndex:(NSInteger)index;
-(NSString *)ps_getBucketTypeAtIndex:(NSInteger)index;
-(NSString *)ps_getPriceAtIndex:(NSInteger)index;
-(NSString *)ps_getNameAtIndex:(NSInteger)index;
-(NSString *)ps_getSiglePriceAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowSiglePriceAtIndex:(NSInteger)index;
-(CGFloat)ps_getNameWidthAtIndex:(NSInteger)index;
-(NSString *)ps_getPhoneAtIndex:(NSInteger)index;
-(NSString *)ps_getLabelPickOneSelfTitleAtIndex:(NSInteger)index;
-(NSString *)ps_getLabelPickOneSelfContentAtIndex:(NSInteger)index;
-(BOOL)ps_getIsEnablePickOneSelfTextFieldAtIndex:(NSInteger)index;

-(NSString *)ps_getAddressAtIndex:(NSInteger)index;
-(NSString *)ps_getDriverNameStatusAtIndex:(NSInteger)index;
-(NSString *)ps_getSenderStatusAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowSenderStatusAtIndex:(NSInteger)index;
-(BOOL)ps_getIsSelectedAtIndex:(NSInteger)index;
-(BOOL)ps_getIsShowBtnSelectedAtIndex:(NSInteger)index;
-(void)ps_setIsSelectedAtIndex:(NSInteger)index IsSelected:(BOOL)isSelected;
#pragma mark- 接口

-(void)requestDeliveryListWithPage:(NSInteger)page Complete:(completeDataArrBlock)complete;


-(void)requestSavePickOneSelfWithCode:(NSString *)code
                          way_bill_id:(NSString *)way_bill_id
                             complete:(completeBlock)complete;



@end

NS_ASSUME_NONNULL_END
