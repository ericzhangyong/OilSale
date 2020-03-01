//
//  WEWeakScriptDelegate.m
//  WaterElephantLiveStreaming
//
//  Created by eric on 2019/7/5.
//  Copyright © 2019 waterelephant. All rights reserved.
//

#import "BaseWeakScriptDelegate.h"

@implementation BaseWeakScriptDelegate
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}
@end
