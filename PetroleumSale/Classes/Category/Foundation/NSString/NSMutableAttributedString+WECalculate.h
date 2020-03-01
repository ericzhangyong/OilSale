//
//  NSMutableAttributedString+WECalculate.h
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/7/17.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (WECalculate)



/**
 获取高度

 @param width 宽度
 @return 高度
 */
-(CGFloat)we_getHeightWithWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
