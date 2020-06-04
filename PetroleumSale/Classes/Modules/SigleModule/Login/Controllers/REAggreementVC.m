//
//  FSAggreementVC.m
//  FireStore
//
//  Created by eric on 2019/9/6.
//  Copyright © 2019 eric. All rights reserved.
//

#import "REAggreementVC.h"

@interface REAggreementVC ()

/// <#des#>
@property (nonatomic,copy) NSString *navTitle;
@end
@implementation REAggreementVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.isDefaultShowTitle = NO;
    self.navigationItem.title = self.navTitle;
}

-(instancetype)initWithTitile:(NSString *)title{
    if (self = [super init]) {
        self.navTitle = title;
    }
    return self;
}

-(void)loadWebDataSource {

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL fileURLWithPath:self.webUrl]];
    [self.wkwebView loadRequest:request];
}




@end
