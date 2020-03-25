//
//  PSHomeHeaderView.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/11/26.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSHomeHeaderView.h"
#import "SDCycleScrollView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "PSWebViewController.h"
#import "UIView+BaseCategory.h"
#import "SDCollectionViewCell.h"

@interface PSHomeHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView  *scoroll_banner;
//今日油价
@property (nonatomic,strong) UIView *view_todayPrice;
@property (nonatomic,strong) UILabel *label_todayPriceTitle;
@property (nonatomic,strong) UILabel *label_todayPrice;
//公告
@property (nonatomic,strong) UIView *view_notice;
@property (nonatomic,strong) UIImageView *imageView_NoticeTrumpet;//喇叭
@property (nonatomic,strong) UIButton *btn_NoticeMore;
@property (nonatomic,strong) UILabel *label_notice;
//上一次购买
@property (nonatomic,strong) UIView *view_lastBuy;
@property (nonatomic,strong) UILabel *label_lastBuy;


@end
@implementation PSHomeHeaderView

-(void)initBaseSubViews{
    
    self.backgroundColor = color_lightDart_white;
    [self addSubview:self.scoroll_banner];
//    [self addSubview:self.imageView_background];
    [self addSubview:self.view_todayPrice];
    [self addSubview:self.view_notice];
    [self addSubview:self.view_lastBuy];

    
    [self.view_todayPrice addSubview:self.label_todayPriceTitle];
    [self.view_todayPrice addSubview:self.label_todayPrice];
    
    [self.view_notice addSubview:self.imageView_NoticeTrumpet];
    [self.view_notice addSubview:self.label_notice];
    [self.view_notice addSubview:self.btn_NoticeMore];
    
    [self.view_lastBuy addSubview:self.label_lastBuy];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    CGFloat bannerHeight = kScreenWidth*200.0/375 ;
    if (self.homeViewModel) {
        bannerHeight = self.homeViewModel.ps_getBannerHeight;
    }
    [self.scoroll_banner mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(bannerHeight);
    }];
    
    [self.view_todayPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.scoroll_banner.mas_bottom);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(60);
    }];
    
    [self.label_todayPriceTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_todayPrice).offset(40);
        make.centerY.equalTo(self.view_todayPrice);
        make.width.mas_equalTo(70);
    }];
    [self.label_todayPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view_todayPrice).offset(-40);
        make.centerY.equalTo(self.view_todayPrice);
        make.left.greaterThanOrEqualTo(self.label_todayPriceTitle.mas_right).offset(20);
        make.height.mas_equalTo(37);
    }];
    
    [self.view_notice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.view_todayPrice.mas_bottom);
    }];
    [self.imageView_NoticeTrumpet mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_notice).offset(15);
        make.centerY.equalTo(self.view_notice);
        make.width.height.mas_equalTo(16);
    }];
    [self.btn_NoticeMore mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view_notice).offset(-15);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(11);
        make.centerY.equalTo(self.imageView_NoticeTrumpet);
    }];
    [self.label_notice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView_NoticeTrumpet.mas_right).offset(5);
        make.right.greaterThanOrEqualTo(self.btn_NoticeMore.mas_left).offset(15);
        make.centerY.equalTo(self.imageView_NoticeTrumpet);
    }];
    
    [self.view_lastBuy mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_notice.mas_bottom);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(54);
    }];
    [self.label_lastBuy mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
}
-(void)setHomeViewModel:(PSHomeViewModel *)homeViewModel{
    _homeViewModel = homeViewModel;
    
    NSArray *bannerUrlArr = [homeViewModel.homeModel.tool_bar_list valueForKey:@"bar_pic_url"];
    if (bannerUrlArr.count>0) {
        self.scoroll_banner.imageURLStringsGroup = bannerUrlArr;
    }else{
        UIImage *holderImage =  [UIImage imageNamed:@"banner"];
        self.scoroll_banner.imageURLStringsGroup = @[holderImage];
    }
    
    self.label_todayPriceTitle.text = @"今日油价";
    self.label_notice.text = homeViewModel.homeModel.notice_title;
    self.label_lastBuy.text = homeViewModel.homeModel.buy_notice;
//    self.label_notice.text =
    NSString *price = homeViewModel.homeModel.oil_price_today.oil_price;
    NSString *content = [NSString stringWithFormat:@"¥%@",price];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName:[UIFont systemWEPingFangMediumFontOfSize:16],NSForegroundColorAttributeName:color_EE5455}];
    NSArray *dotArr = [price componentsSeparatedByString:@"."];
    if (dotArr.count>0) {
        NSRange dotRange = [content rangeOfString:dotArr[0]];
        [attr addAttributes:@{NSFontAttributeName:[UIFont systemWEPingFangMediumFontOfSize:25]} range:dotRange];
    }
   
    self.label_todayPrice.attributedText = attr;
    
    
}

#pragma mark- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if (self.homeViewModel.homeModel.tool_bar_list.count>0) {
        
        NSString *url = self.homeViewModel.homeModel.tool_bar_list[index].redirect_uri;
        PSWebViewController *web = [[PSWebViewController alloc] init];
        web.webUrl = url;
        [self.navViewController pushViewController:web animated:YES];
    }
}

-(void)setupCustomCell:(SDCollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
}



#pragma mark-lazy

-(UIView *)view_todayPrice{
    if (!_view_todayPrice) {
        _view_todayPrice = [UIView new];
        _view_todayPrice.layer.cornerRadius = 5;
        _view_todayPrice.backgroundColor =  color_lightDart_white_black;
        _view_todayPrice.layer.masksToBounds = YES;
    }
    return _view_todayPrice;
}
-(UILabel *)label_todayPriceTitle{
    if (!_label_todayPriceTitle) {
        _label_todayPriceTitle = [UILabel new];
        _label_todayPriceTitle.font =[UIFont systemWEPingFangRegularOfSize:15];
        _label_todayPriceTitle.textColor = color_lightDart_333333;
    }
    return _label_todayPriceTitle;
}
-(UILabel *)label_todayPrice{
    if (!_label_todayPrice) {
        _label_todayPrice = [UILabel new];
        _label_todayPrice.textAlignment = NSTextAlignmentRight;
    }
    return _label_todayPrice;
}

-(UIView *)view_notice{
    if (!_view_notice) {
        _view_notice = [UIView new];
        _view_notice.backgroundColor = color_lightDart_white_black;
    }
    return _view_notice;
}
-(UIImageView *)imageView_NoticeTrumpet{
    if (!_imageView_NoticeTrumpet) {
        _imageView_NoticeTrumpet  = [UIImageView new];
        _imageView_NoticeTrumpet.image = [UIImage imageNamed:@"hp_icon_news"];
    }
    return _imageView_NoticeTrumpet;
}
-(UILabel *)label_notice{
    if (!_label_notice) {
        _label_notice =[UILabel new];
        _label_notice.font =[UIFont systemWEPingFangRegularOfSize:12];
        _label_notice.textColor = color_lightDart_333333;
    }
    return _label_notice;
}
-(UIButton *)btn_NoticeMore{
    if (!_btn_NoticeMore) {
        _btn_NoticeMore =[UIButton buttonWithType:UIButtonTypeSystem];
        [_btn_NoticeMore setImage:[UIImage imageNamed:@"hp_icon_more"] forState:UIControlStateNormal];
    }
    return _btn_NoticeMore;
}

-(UIView *)view_lastBuy{
    if (!_view_lastBuy) {
        _view_lastBuy   =[UIView new];
        _view_lastBuy.backgroundColor = color_FFF8EB;
        _view_lastBuy.layer.masksToBounds = YES;
        _view_lastBuy.layer.cornerRadius = 4;
    }
    return _view_lastBuy;
}
-(UILabel *)label_lastBuy{
    if (!_label_lastBuy) {
        _label_lastBuy = [UILabel new];
        _label_lastBuy.textColor = color_FE6C00;
        _label_lastBuy.textAlignment = NSTextAlignmentLeft;
        _label_lastBuy.numberOfLines = 0;
        _label_lastBuy.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_lastBuy;
}
-(SDCycleScrollView *)scoroll_banner{
    if (!_scoroll_banner) {
        _scoroll_banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*200.0/375) delegate:self placeholderImage:defaultHolder750_400];
        _scoroll_banner.pageControlDotSize = CGSizeMake(5, 5);
        _scoroll_banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _scoroll_banner.pageControlBottomOffset = 33;
    }
    return _scoroll_banner;
}


@end
