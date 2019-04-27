//
//  TXUserDataManager.m
//  NulleEduParent
//
//  Created by xtz_pioneer on 2018/7/13.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import "TXUserDataManager.h"

@implementation TXUserDataManager

/** 用户数据管理器 */
+ (TXUserDataManager*)userDataManager{
    static TXUserDataManager * userDataManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDataManagerInstance = [[super allocWithZone:nil] init];
    });
    return userDataManagerInstance;
}

+ (id)allocWithZone:(NSZone *)zone{
    return [TXUserDataManager userDataManager];
}

- (id)copyWithZone:(NSZone *)zone{
    return [TXUserDataManager userDataManager];
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return [TXUserDataManager userDataManager];
}

- (instancetype)init{
    if (self = [super init]) {
        self.logInInfo=[[TXLogInInfo alloc]init];
        self.userInfo=[[TXUserInfo alloc]init];
        self.rongIMUserInfo=[[TXRongIMUserInfo alloc]init];
    }
    return self;
}

/**
 *  设置开发类型
 *  @param developType 开发类型 (非必填)
 */
- (void)setDevelopType:(TXDevelopType)developType{
    self.logInInfo.developType=developType;
}

/**
 *  设置用户数据
 *  @param setUserDataType 设置用户数据类型 (必填)
 *  @param parameters 参数 (必填)
 */
- (void)setUserDataWithSetUserDataType:(TXSetUserDataType)setUserDataType parameters:(NSDictionary*)parameters{
    if (setUserDataType==TXSetUserDataTypeUserInfo) {
        [self.userInfo setDataWithParameters:parameters];
    }else if (setUserDataType==TXSetUserDataTypeLogInInfo){
        [self.logInInfo setDataWithParameters:parameters];
    }else if (setUserDataType==TXSetUserDataTypeRongIMUserInfo){
        [self.rongIMUserInfo setDataWithParameters:parameters];
    }
}

/**
 *  移除用户数据
 *  @param removeUserDataType 移除用户数据类型 (必填)
 */
- (void)removeUserData:(TXRemoveUserDataType)removeUserDataType{
    if (removeUserDataType==TXRemoveUserDataTypeUserInfo) {
        [self.userInfo removeAllData];
    }else if (removeUserDataType==TXRemoveUserDataTypeLogInInfo){
        [self.logInInfo removeAllData];
    }else if (removeUserDataType==TXRemoveUserDataTypeRongIMUserInfo){
        [self.rongIMUserInfo removeAllData];
    }
}

/** 移除用户所有数据 */
- (void)removeUserAllData{
    [self removeUserData:TXRemoveUserDataTypeUserInfo];
    [self removeUserData:TXRemoveUserDataTypeLogInInfo];
    [self removeUserData:TXRemoveUserDataTypeRongIMUserInfo];
}

@end
