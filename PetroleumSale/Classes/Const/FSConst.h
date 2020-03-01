//
//  FSConst.h
//  FireStore
//
//  Created by eric on 2019/8/28.
//  Copyright © 2019 eric. All rights reserved.
//

#ifndef FSConst_h
#define FSConst_h

//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//判断 iOS 9 或更高的系统版本
#define IOS_VERSION_9_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=9.0)? (YES):(NO))

// iOS >= 10.0
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=10.0)? (YES):(NO))

// iOS >= 11.0
#define IOS_VERSION_11_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=11.0)? (YES):(NO))

#define WECookie                        @"WECookie"
#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height<812)?NO:YES)
#define NoStatusBarSafeTop (IS_IPHONEX ? 44 : 0)
#define MasNavHeight (IS_IPHONEX ? 88 : 64)
#define SafeTop (([[UIScreen mainScreen] bounds].size.height<812) ? 20 : 44)
#define SafeBottom (([[UIScreen mainScreen] bounds].size.height<812) ? 0 : 34)
#define SafeBeautyBottom (([[UIScreen mainScreen] bounds].size.height<812) ? 0 : 12)
#define StatusBarHeight (([[UIScreen mainScreen] bounds].size.height<812) ? 20 : 44)
#define IPHONEX (([[UIScreen mainScreen] bounds].size.height<812)?NO:YES)
#define SizeWidth(W) (W *CGRectGetWidth([[UIScreen mainScreen] bounds])/320)
#define SizeHeight(H) (H *(kScreenHeight)/568)
#define TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) //底部tabbar高度
//弱引用，强引用
#define WEAK_SELF __weak typeof(self) weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf) self = weakSelf


// 占位图
#define defaultHeaderHolder  [UIImage imageNamed:@"mine_head_boy"]
#define defaultHolder160_160  [UIImage imageNamed:@"commodity_occupy_img"]
#define defaultHolder750_400  [UIImage imageNamed:@"banner_gray_img"]

#define AppID @"6"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define NavigationBarTitleViewMargin \
(IOS_VERSION_11_OR_LATER? ([UIScreen mainScreen].bounds.size.width > 375 ? 20 : 16) : \
([UIScreen mainScreen].bounds.size.width > 375 ? 12 : 8))



#endif /* FSConst_h */
