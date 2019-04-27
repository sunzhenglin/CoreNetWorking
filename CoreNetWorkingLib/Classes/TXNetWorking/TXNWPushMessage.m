//
//  TXNWPushMessage.m
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/27.
//

#import "TXNWPushMessage.h"

@implementation TXNWPushMessage

/** 网络请求错误通知 */
NSString * const TXNetWorkRequestErrorNotification =@"netWorkRequestErrorNotification";
/** 网络请求错误代码Key */
NSString * const errorCodeKey=@"errorCode";

/** 网络监测通知 */
NSString * const TXNetworkMonitoringNotification =@"networkMonitoringNotification";
/** 网络状态Key */
NSString * const networkStatusKey =@"networkStatus";

/** 推送错误代码 */
+ (void)pushNetWorkRequestErrorWithErrorCode:(NSInteger)errorCode{
    NSDictionary *parameters=@{errorCodeKey:[NSNumber numberWithInteger:errorCode]};
    [[NSNotificationCenter defaultCenter] postNotificationName:TXNetWorkRequestErrorNotification object:nil userInfo:parameters];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TXNetWorkRequestErrorNotification object:nil];
}

/** 推送网络状态 */
+ (void)pushNetworkStatusWithNetworkStatus:(NSInteger)networkStatus{
    NSDictionary *parameters=@{networkStatusKey:[NSNumber numberWithInteger:networkStatus]};
    [[NSNotificationCenter defaultCenter] postNotificationName:TXNetworkMonitoringNotification object:nil userInfo:parameters];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TXNetworkMonitoringNotification object:nil];
}

@end
