//
//  TXNetworkStatusDelegate.h
//  SchoolWatchParent
//
//  Created by komlin on 2018/12/13.
//  Copyright © 2018 Komlin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 网络状态 */
typedef NS_ENUM(NSInteger,NWNetworkStatus){
    /** 未识别的网络*/
    NWNetworkStatusUnknown          =-1,
    /** 不可达的网络(未连接) */
    NWNetworkStatusReachable        =0,
    /** 2G,3G,4G...的网络 */
    NWNetworkStatusReachableViaWWAN =1,
    /** Wi-Fi的网络 */
    NWNetworkStatusReachableViaWiFi =2,
};

/** 网络状态代理 */
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
