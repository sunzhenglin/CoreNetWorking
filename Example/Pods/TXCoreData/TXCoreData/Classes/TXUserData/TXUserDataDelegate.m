//
//  TXUserDataDelegate.m
//  NulleEduParent
//
//  Created by xtz_pioneer on 2018/7/13.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import "TXUserDataDelegate.h"
#import "TXUserDataManager.h"

@interface TXUserDataDelegate ()
@property (nonatomic,strong)TXUserDataManager * userDataManager;
@end

@implementation TXUserDataDelegate

- (instancetype)init{
    if (self = [super init]) {
        self.userDataManager=[TXUserDataManager userDataManager];
        [self addAllLoginInfoPropertyMonitoring];
        [self addAllUserInfoPropertyMonitoring];
        [self addAllRongIMUserInfoPropertyMonitoring];
    }
    return self;
}

/*添加登录信息属性监听*/
- (void)addLogInInfoPropertyMonitoringKeyPath:(NSString*)keyPath{
    [self.userDataManager.logInInfo addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
/*添加用户属性信息监听*/
- (void)addUserInfoPropertyMonitoringKeyPath:(NSString*)keyPath{
    [self.userDataManager.userInfo addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
/*添加融云用户属性信息监听*/
- (void)addRongIMUserInfoPropertyMonitoringKeyPath:(NSString*)keyPath{
    [self.userDataManager.rongIMUserInfo addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

/*移除登录信息属性监听*/
- (void)removeLogInInfoPropertyMonitoringKeyPath:(NSString*)keyPath{
    [self.userDataManager.logInInfo removeObserver:self forKeyPath:keyPath];
}
/*移除用户信息属性监听*/
- (void)removeUserInfoPropertyMonitoringKeyPath:(NSString*)keyPath{
    [self.userDataManager.userInfo removeObserver:self forKeyPath:keyPath];
}
/*移除融云用户信息属性监听*/
- (void)removeRongIMUserInfoPropertyMonitoringKeyPath:(NSString*)keyPath{
    [self.userDataManager.rongIMUserInfo removeObserver:self forKeyPath:keyPath];
}

/*添加所有登录信息属性监听*/
- (void)addAllLoginInfoPropertyMonitoring{
    [self addLogInInfoPropertyMonitoringKeyPath:@"token"];
    [self addLogInInfoPropertyMonitoringKeyPath:@"imToken"];
    [self addLogInInfoPropertyMonitoringKeyPath:@"permissions"];
    [self addLogInInfoPropertyMonitoringKeyPath:@"bind"];
    [self addLogInInfoPropertyMonitoringKeyPath:@"schoolId"];
    [self addLogInInfoPropertyMonitoringKeyPath:@"developType"];
}
/*添加所有用户信息属性监听*/
- (void)addAllUserInfoPropertyMonitoring{
    [self addUserInfoPropertyMonitoringKeyPath:@"name"];
    [self addUserInfoPropertyMonitoringKeyPath:@"head"];
    [self addUserInfoPropertyMonitoringKeyPath:@"gender"];
    [self addUserInfoPropertyMonitoringKeyPath:@"phone"];
}
/*添加所有融云用户信息属性监听*/
- (void)addAllRongIMUserInfoPropertyMonitoring{
    [self addRongIMUserInfoPropertyMonitoringKeyPath:@"userId"];
}

/*移除所有登录信息属性监听*/
- (void)removeAllLoginInfoPropertyMonitoring{
    [self removeLogInInfoPropertyMonitoringKeyPath:@"token"];
    [self removeLogInInfoPropertyMonitoringKeyPath:@"imToken"];
    [self removeLogInInfoPropertyMonitoringKeyPath:@"permissions"];
    [self removeLogInInfoPropertyMonitoringKeyPath:@"bind"];
    [self removeLogInInfoPropertyMonitoringKeyPath:@"schoolId"];
    [self removeLogInInfoPropertyMonitoringKeyPath:@"developType"];
}
/*移除所有用户信息属性监听*/
- (void)removeAllUserInfoPropertyMonitoring{
    [self removeUserInfoPropertyMonitoringKeyPath:@"name"];
    [self removeUserInfoPropertyMonitoringKeyPath:@"head"];
    [self removeUserInfoPropertyMonitoringKeyPath:@"gender"];
    [self removeUserInfoPropertyMonitoringKeyPath:@"phone"];
}
/*移除所有融云用户信息属性监听*/
- (void)removeAllRongIMUserInfoPropertyMonitoring{
    [self removeRongIMUserInfoPropertyMonitoringKeyPath:@"userId"];
}

/*监听*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSDictionary * dict=@{
                          @"keyPath":keyPath,
                          @"ofObject":object,
                          @"change":change,
                          };
    if ([object isEqual:self.userDataManager.logInInfo]) {
        if ([self.delegate respondsToSelector:@selector(userDataDelegate:logInInfoDidChange:info:)]) {
            [self.delegate userDataDelegate:self logInInfoDidChange:(TXLogInInfo*)object info:dict];
        }
    }else if ([object isEqual:self.userDataManager.userInfo]){
        if ([self.delegate respondsToSelector:@selector(userDataDelegate:userInfoDidChange:info:)]) {
            [self.delegate userDataDelegate:self userInfoDidChange:(TXUserInfo*)object info:dict];
        }
    }else if ([object isEqual:self.userDataManager.rongIMUserInfo]){
        if ([self.delegate respondsToSelector:@selector(userDataDelegate:rongIMUserInfoDidChange:info:)]) {
            [self.delegate userDataDelegate:self rongIMUserInfoDidChange:(TXRongIMUserInfo*)object info:dict];
        }
    }
}

- (void)dealloc{
    [self removeAllLoginInfoPropertyMonitoring];
    [self removeAllUserInfoPropertyMonitoring];
    [self removeAllRongIMUserInfoPropertyMonitoring];
}

@end
