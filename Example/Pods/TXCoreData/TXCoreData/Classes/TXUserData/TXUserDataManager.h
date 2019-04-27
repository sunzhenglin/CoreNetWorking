//
//  TXUserDataManager.h
//  NulleEduParent
//
//  Created by xtz_pioneer on 2018/7/13.
//  Copyright © 2018年 Komlin. All rights reserved.
//

/**
 *  功能:用户信息管理器
 *  项目:太平小学/家长端/教师端
 *  单位:杭州空灵智能科技有限公司
 */

#import <Foundation/Foundation.h>
#import "TXLogInInfo.h"
#import "TXUserInfo.h"
#import "TXRongIMUserInfo.h"

/** 移除用户数据类型 */
typedef NS_ENUM(NSInteger,TXRemoveUserDataType){
    /** 用户信息 */
    TXRemoveUserDataTypeUserInfo       =0,
    /** 登录信息 */
    TXRemoveUserDataTypeLogInInfo      =1,
    /** 融云用户信息 */
    TXRemoveUserDataTypeRongIMUserInfo =2,
};

/** 设置用户数据类型 */
typedef NS_ENUM(NSInteger,TXSetUserDataType){
    /** 用户信息 */
    TXSetUserDataTypeUserInfo       =0,
    /** 登录信息 */
    TXSetUserDataTypeLogInInfo      =1,
    /** 融云用户信息 */
    TXSetUserDataTypeRongIMUserInfo =2,
};

/** 用户数据管理器 */
@interface TXUserDataManager : NSObject
/** 用户数据管理器 */
+ (TXUserDataManager*)userDataManager;
/** 登录信息 */
@property(nonatomic,strong)TXLogInInfo *logInInfo;
/** 用户信息 */
@property(nonatomic,strong)TXUserInfo *userInfo;
/** 融云用户信息 */
@property(nonatomic,strong)TXRongIMUserInfo *rongIMUserInfo;

/**
 *  设置开发类型
 *  @param developType 开发类型 (非必填)
 */
- (void)setDevelopType:(TXDevelopType)developType;

/**
 *  设置用户数据
 *  @param setUserDataType 设置用户数据类型 (必填)
 *  @param parameters 参数 (必填)
 */
- (void)setUserDataWithSetUserDataType:(TXSetUserDataType)setUserDataType parameters:(NSDictionary*)parameters;

/**
 *  移除用户数据
 *  @param removeUserDataType 移除用户数据类型 (必填)
 */
- (void)removeUserData:(TXRemoveUserDataType)removeUserDataType;

/** 移除用户所有数据 */
- (void)removeUserAllData;


@end
