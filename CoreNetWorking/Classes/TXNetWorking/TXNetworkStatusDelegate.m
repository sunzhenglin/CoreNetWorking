//
//  TXNetworkStatusDelegate.m
//  SchoolWatchParent
//
//  Created by komlin on 2018/12/13.
//  Copyright © 2018 Komlin. All rights reserved.
//

#import "TXNetworkStatusDelegate.h"

NSString * const TXNetworkMonitoringNotification =@"networkMonitoringNotification";
NSString * const networkStatusKey =@"networkStatus";

@implementation TXNetworkStatusDelegate

- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkMonitoringNotification:) name:TXNetworkMonitoringNotification object:nil];
    }
    return self;
}

- (void)networkMonitoringNotification:(id)sender{
    if ([self.delegate respondsToSelector:@selector(networkStatusDelegate:networkStatus:)]) {
        NSNotification *notification=sender;
        NSInteger networkStatus=[notification.userInfo[networkStatusKey] integerValue];
        self.networkStatus=networkStatus;
        [self.delegate networkStatusDelegate:self networkStatus:networkStatus];
    }
}

/** 网络状态 */
- (void)setNetworkStatus:(NWNetworkStatus)networkStatus{
    _networkStatus=networkStatus;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TXNetworkMonitoringNotification object:nil];
}

@end
