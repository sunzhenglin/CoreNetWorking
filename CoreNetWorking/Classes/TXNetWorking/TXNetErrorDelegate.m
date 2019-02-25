//
//  TXNetErrorDelegate.m
//  SchoolWatchParent
//
//  Created by komlin on 2018/9/4.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import "TXNetErrorDelegate.h"

@implementation TXNetErrorDelegate

- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkRequestErrorNotification:) name:TXNetWorkRequestErrorNotification object:nil];
    }
    return self;
}

- (void)netWorkRequestErrorNotification:(id)sender{
    if ([self.delegate respondsToSelector:@selector(netErrorDelegate:errorCodeType:)]) {
        NSNotification *notification=sender;
        NSInteger errorCodeType=[notification.userInfo[errorCodeTypeKey] integerValue];
        [self.delegate netErrorDelegate:self errorCodeType:errorCodeType];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TXNetWorkRequestErrorNotification object:nil];
}

@end
