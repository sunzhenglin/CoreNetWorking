//
//  TXNWPushMessage.h
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 网络请求错误通知 */
FOUNDATION_EXPORT NSString *const TXNetWorkRequestErrorNotification;
/** 网络请求错误代码类型Key */
FOUNDATION_EXPORT NSString *const errorCodeKey;

/** 网络监测通知 */
FOUNDATION_EXPORT NSString *const TXNetworkMonitoringNotification;
/** 网络状态Key */
FOUNDATION_EXPORT NSString *const networkStatusKey;

@interface TXNWPushMessage : NSObject
/** 推送错误代码 */
+ (void)pushNetWorkRequestErrorWithErrorCode:(NSInteger)errorCode;
/** 推送网络状态 */
+ (void)pushNetworkStatusWithNetworkStatus:(NSInteger)networkStatus;
@end

NS_ASSUME_NONNULL_END
