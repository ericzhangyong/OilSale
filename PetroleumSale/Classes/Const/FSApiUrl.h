//
//  FSApiUrl.h
//  FireStore
//
//  Created by waterpant on 2019/9/2.
//  Copyright © 2019 eric. All rights reserved.
//

#ifndef FSApiUrl_h
#define FSApiUrl_h


#if DEBUG
//#define kUrlRoot @"http://sandbox.sxfq.com/huolika-vest-web"
#define kUrlRoot @"http://106.14.97.213/huolika-vest-web"
//#define kUrlRoot @"http://192.168.152.30:8082/huolika-vest-web"
#define kUrlLink @"https://www.huolicard.com/huolika"
#define kUrlHuoliKa @"http://sandbox.sxfq.com/huolika-api-web"
#define kUrlHuoliKa_Url @"http://sandbox.sxfq.com/huolika"

#else
#define kUrlRoot @"http://sandbox.sxfq.com/huolika-vest-web"
#define kUrlLink @"https://www.huolicard.com/huolika"
#define kUrlHuoliKa @"https://www.huolicard.com/huolika-api-web"
#define kUrlHuoliKa_Url @"https://www.huolicard.com/huolika"
#endif

#define iosdetail_Versionnum @"#/iosdetail"
#define linkpayStartup_Versionnum                                        @"mall/linkpay/startup"//启动支付


#define mallGbpPage_Versionnum @"mall/gbp/page"
#define mallProductSearch_Versionnum                                 @"mall/gbp/productSearch"//   商品搜索
#define mallVestBannerInfo_Versionnum @"mall/vest/bannerInfo"
#define getShoppingCartSearchInfo_Versionnum                      @"mall/bill/getShoppingCartSearchInfo"//  获取购物车商品数量及搜索框默认热词
#define groupBuyOrderDetail_Versionnum                      @"mall/order/groupBuyOrderDetail"//获取指定拼团商品下拼团详情
#define groupBuyOrderDetail_Versionnum @"mall/order/groupBuyOrderDetail"
#define groupBuyOrders_Versionnum @"mall/order/groupBuyOrders"
#define groupBuyOrder_Versionnum @"mall/order/groupBuyOrder"
#define joinGroupBuyOrder_Versionnum @"mall/order/joinGroupBuyOrder"
#define createBill_Versionnum                                       @"mall/bill/appCheckLogin/createBill"//  创建商品订单
#define getBrandListByCategory_Versionnum                           @"mall/brand/getBrandListByCategory"//根据分类ID取得品牌一览
#define findSearchHotWords_Versionnum @"mall/product/findSearchHotWords"
#define deleteSearchHistory_Versionnum                            @"mall/product/deleteSearchHistory"// 删除搜索记录
#define findSearchHistory_Versionnum                              @"mall/product/findSearchHistory"// 取得商品搜索记录
#define getProductDetail_Versionnum                                 @"mall/product/detail" //商品详细信息

#endif /* FSApiUrl_h */
