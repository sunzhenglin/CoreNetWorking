//
//  TXUserDataDelegate.h
//  NulleEduParent
//
//  Created by xtz_pioneer on 2018/7/13.
//  Copyright © 2018年 Komlin. All rights reserved.
//

/**
 *  功能:用户信息改变代理
 *  项目:太平小学/家长端/教师端
 *  单位:杭州空灵智能科技有限公司
 */

#import <Foundation/Foundation.h>
#import "TXUserInfo.h"
#import "TXLogInInfo.h"
#import "TXRongIMUserInfo.h"

@class TXUserDataDelegate;
@protocol TXUserDataChangeDelegate <NSObject>
@optional
/*登录信息发生改变*/
- (void)userDataDelegate:(TXUserDataDelegate*)userDataDelegate logInInfoDidChange:(TXLogInInfo*)logInInfo info:(NSDictionary*)info;
/*用户信息发生改变*/
- (void)userDataDelegate:(TXUserDataDelegate*)userDataDelegate userInfoDidChange:(TXUserInfo*)userInfo info:(NSDictionary*)info;
/*融云用户信息发生改变*/
- (void)userDataDelegate:(TXUserDataDelegate*)userDataDelegate rongIMUserInfoDidChange:(TXRongIMUserInfo*)rongIMUserInfo info:(NSDictionary*)info;
@end
@interface TXUserDataDelegate : NSObject
/*代理属性*/
@property (nonatomic,weak)id <TXUserDataChangeDelegate> delegate;
@end
