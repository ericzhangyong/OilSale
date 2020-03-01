//
//  WEPullDelegate.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/5/23.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <Foundation/Foundation.h>
#define requestPageStart  1
#define requestPageCount  20
@protocol BasePullDelegate <NSObject>


@optional
/**
 *  是否需要下拉
 */
-(BOOL)needPullHeader;
/**
 *  是否需要上啦
 */
-(BOOL)needPullFooter;
/**
 *  是否需要 空提示
 */
-(BOOL)needEmptyTip;

-(UIImage*)imageForEmptyNoList;
-(UIImage*)imageForNoNetEmptyNoList;
-(NSString*)stringForEmptyNoList;
-(NSString*)stringForNoNetEmptyNoList;




/**
 是否显示自定义的空数据View
 */
-(BOOL)isShouldShowFFCustomEmptyView;

-(UIView*)viewForEmptyNoList;

@end
