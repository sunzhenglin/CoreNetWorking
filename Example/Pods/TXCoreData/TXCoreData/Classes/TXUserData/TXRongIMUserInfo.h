//
//  TXRongIMUserInfo.h
//  NulleEduParent
//
//  Created by komlin on 2018/10/25.
//  Copyright © 2018年 Komlin. All rights reserved.
//

/**
 *  功能:融云用户信息
 *  项目:太平小学/家长端/教师端
 *  单位:杭州空灵智能科技有限公司
 */

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const userIdKey;

@interface TXRongIMUserInfo : NSObject

/*userId*/
- (void)setUserId:(NSString*)userId;
- (NSString*)userId;

/*设置数据*/
- (void)setDataWithParameters:(NSDictionary*)parameters;

/*移除全部数据*/
- (void)removeAllData;

@end
