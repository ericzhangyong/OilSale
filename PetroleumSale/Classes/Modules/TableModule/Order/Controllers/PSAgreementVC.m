//
//  PSAgreementVC.m
//  PetroleumSale
//
//  Created by zhangyong on 2019/12/4.
//  Copyright © 2019 eric. All rights reserved.
//

#import "PSAgreementVC.h"
#import "BaseRequestHeader.h"

@interface PSAgreementVC ()

@end

@implementation PSAgreementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

}



-(void)loadWebDataSource {
    
    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request addValue:[BaseRequestHeader.shareRequestHeader getLoginToken] forHTTPHeaderField:REUserTokenKey];
    [self.wkwebView loadRequest:request];
}
@end
