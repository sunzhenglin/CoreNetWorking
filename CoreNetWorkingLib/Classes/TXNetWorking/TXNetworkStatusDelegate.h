//
//  TXNetworkStatusDelegate.h
//  SchoolWatchParent
//
//  Created by komlin on 2018/12/13.
//  Copyright © 2018 Komlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXNetWorking.h"
#import "NWNetworkStatus.h"
NS_ASSUME_NONNULL_BEGIN

/** 网络监测通知 */
FOUNDATION_EXPORT NSString *const TXNetworkMonitoringNotification;
/** 网络状态Key */
FOUNDATION_EXPORT NSString *const networkStatusKey;



@class TXNetworkStatusDelegate;
@protocol TXNetworkStatusDelegate <NSObject>
@optional
/** 网络状态 */
- (void)networkStatusDelegate:(TXNetworkStatusDelegate*)networkStatusDelegate networkStatus:(NWNetworkStatus)networkStatus;
@end
@interface TXNetworkStatusDelegate : NSObject
/** 代理属性 */
@property (nonatomic,weak)id <TXNetworkStatusDelegate> delegate;
/** 网络状态(注意:只用在开启网络检测时可用) */
@property (nonatomic,assign,readonly)NWNetworkStatus networkStatus;
@end

NS_ASSUME_NONNULL_END
