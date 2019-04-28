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

/** 网络错误Domain */
NSString *const TXNetWorkErrorDomain=@"TXNetWorkError";

/**
 *  推送错误代码
 *
 *  @param errorCode 错误代码
 *
 *  @return NSError 错误
 */
+ (NSError*)pushNetWorkRequestErrorWithErrorCode:(NSInteger)errorCode{
    // 信息
    NSMutableDictionary *userInfo;
    if (errorCode != [TXNetWorking netWorkingManager].code) {
        NSDictionary *parameters=@{errorCodeKey:[NSNumber numberWithInteger:errorCode]};
        [[NSNotificationCenter defaultCenter] postNotificationName:TXNetWorkRequestErrorNotification object:nil userInfo:parameters];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:TXNetWorkRequestErrorNotification object:nil];
    }
    // 错误代码的值
    NSString * errorCodeValue=[TXNetErrorDelegate errorCodeKeyForValue:errorCode];
    if (errorCodeValue) {
        // 创建错误信息
        userInfo=[NSMutableDictionary dictionary];
        [userInfo setValue:errorCodeValue forKey:[TXNetWorking netWorkingManager].errorMessageNameKey];
    }
    return [NSError errorWithDomain:TXNetWorkErrorDomain code:errorCode userInfo:userInfo];
}

/**
 *  推送错误代码
 *
 *  @param errorCode 错误代码
 *  @param value 错误码的值
 *
 *  @return NSError 错误
 */
+ (NSError*)pushNetWorkRequestErrorWithErrorCode:(NSInteger)errorCode value:(NSString*)value{
    // 信息
    NSMutableDictionary *userInfo;
    if (value) {
        // 添加错误代码
        if ([TXNetWorking existErrorCodeValue:value] && [TXNetWorking existErrorCodeKey:errorCode]) {
        }else{
            [TXNetWorking addErrorCodeValue:value forKey:errorCode];
        }
        // 创建错误信息
        userInfo=[NSMutableDictionary dictionary];
        [userInfo setValue:value forKey:[TXNetWorking netWorkingManager].errorMessageNameKey];
    }
    [TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:errorCode];
    return [NSError errorWithDomain:TXNetWorkErrorDomain code:errorCode userInfo:userInfo];
}

/**
 *  推送网络状态
 *
 *  @param networkStatus 错误代码 （-1 至 2 有效）
 *
 *  @return NSInteger 网络状态
 */
+ (NSInteger)pushNetworkStatusWithNetworkStatus:(NSInteger)networkStatus{
    if (networkStatus>=-1 && networkStatus<=2) {
        NSDictionary *parameters=@{networkStatusKey:[NSNumber numberWithInteger:networkStatus]};
        [[NSNotificationCenter defaultCenter] postNotificationName:TXNetworkMonitoringNotification object:nil userInfo:parameters];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:TXNetworkMonitoringNotification object:nil];
    }
    return networkStatus;
}

@end
