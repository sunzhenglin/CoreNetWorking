//
//  TXNetErrorDelegate.m
//  SchoolWatchParent
//
//  Created by komlin on 2018/9/4.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import "TXNetErrorDelegate.h"
#import "TXNetWorking.h"

@implementation TXNetErrorDelegate

- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkRequestErrorNotification:) name:TXNetWorkRequestErrorNotification object:nil];
    }
    return self;
}

- (void)setErrorCode:(NSInteger)errorCode{
    _errorCode=errorCode;
}

- (void)setErrorCodeString:(NSString *)errorCodeString{
    _errorCodeString=errorCodeString;
}

- (void)netWorkRequestErrorNotification:(id)sender{
    if ([self.delegate respondsToSelector:@selector(netErrorDelegate:errorCode:errorCodeString:)]) {
        NSNotification *notification=sender;
        self.errorCode=[notification.userInfo[errorCodeKey] integerValue];
        self.errorCodeString=[TXNetWorking netWorkingManager].errorCodeDictionary[[NSString stringWithFormat:@"%ld",(long)self.errorCode]];
        [self.delegate netErrorDelegate:self errorCode:self.errorCode errorCodeString:self.errorCodeString];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TXNetWorkRequestErrorNotification object:nil];
}

/** 获取错误代码的值 */
+ (NSString*)errorCodeKeyForValue:(NSInteger)key{
    return [TXNetWorking netWorkingManager].errorCodeDictionary[[NSString stringWithFormat:@"%ld",(long)key]];
}

/** 获取错误代码的键 */
+ (NSInteger)errorCodeValueForKey:(NSString*)value{
    __block NSInteger errorCode;
    [[TXNetWorking netWorkingManager].errorCodeDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:value]) {
            errorCode=[key integerValue];
        }
    }];
    return errorCode;
}


@end
