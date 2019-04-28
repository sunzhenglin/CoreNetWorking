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

/** 网络错误Domain */
FOUNDATION_EXPORT NSString *const TXNetWorkErrorDomain;


@interface TXNWPushMessage : NSObject

/**
 *  推送错误代码
 *
 *  @param errorCode 错误代码
 *
 *  @return NSError 错误
 */
+ (NSError*)pushNetWorkRequestErrorWithErrorCode:(NSInteger)errorCode;

/**
 *  推送错误代码
 *
 *  @param errorCode 错误代码
 *  @param value 错误码的值
 *
 *  @return NSError 错误
 */
+ (NSError*)pushNetWorkRequestErrorWithErrorCode:(NSInteger)errorCode value:(NSString*)value;

/**
 *  推送网络状态
 *
 *  @param networkStatus 错误代码 （-1 至 2 有效）
 *
 *  @return NSInteger 网络状态
 */
+ (NSInteger)pushNetworkStatusWithNetworkStatus:(NSInteger)networkStatus;

@end

NS_ASSUME_NONNULL_END
