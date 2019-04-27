//
//  TXLogInInfo.h
//  NulleEduParent
//
//  Created by xtz_pioneer on 2018/7/13.
//  Copyright © 2018年 Komlin. All rights reserved.
//

/**
 *  功能:用户登录信息
 *  项目:太平小学/家长端/教师端
 *  单位:杭州空灵智能科技有限公司
 */

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const tokenKey;
FOUNDATION_EXPORT NSString *const imTokenKey;
FOUNDATION_EXPORT NSString *const permissionsKey;
FOUNDATION_EXPORT NSString *const bindKey;
FOUNDATION_EXPORT NSString *const schoolIdKey;

/*登录状态*/
typedef NS_ENUM(NSInteger,TXLogInState){
    TXLogInStateNotLogin     =0,//没有登录
    TXLogInStateAlreadyLogin =1,//已经登录
};

/*开发类型*/
typedef NS_ENUM(NSInteger,TXDevelopType){
    TXDevelopTypeNormal     =0,//正常
    TXDevelopTypeParentSide =1,//家长端
    TXDevelopTypeTeacher    =2,//教师端
};

@interface TXLogInInfo : NSObject

/*开发类型(说明:登录时返回参数不同则登录状态判断则不同,开发类型是为了区分这一判断,该类型不会保存到本地)*/
- (void)setDevelopType:(TXDevelopType)developType;
- (TXDevelopType)developType;

/*Token*/
- (void)setToken:(NSString*)token;
- (NSString*)token;

/*imToken*/
- (void)setImToken:(NSString*)imToken;
- (NSString*)imToken;

/*权限*/
- (void)setPermissions:(NSArray*)permissions;
- (NSArray*)permissions;

/*绑定*/
- (void)setBind:(NSInteger)bind;
- (NSInteger)bind;

/*学校ID*/
- (void)setSchoolId:(NSInteger)schoolId;
- (NSInteger)schoolId;

/*logInState*/
- (TXLogInState)logInState;

/*设置数据*/
- (void)setDataWithParameters:(NSDictionary*)parameters;

/*移除全部数据*/
- (void)removeAllData;

@end
