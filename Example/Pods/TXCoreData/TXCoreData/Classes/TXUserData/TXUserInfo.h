//
//  TXUserInfo.h
//  NulleEduParent
//
//  Created by xtz_pioneer on 2018/7/13.
//  Copyright © 2018年 Komlin. All rights reserved.
//

/**
 *  功能:用户信息
 *  项目:太平小学/家长端/教师端
 *  单位:杭州空灵智能科技有限公司
 */

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const nameKey;
FOUNDATION_EXPORT NSString *const headKey;
FOUNDATION_EXPORT NSString *const genderKey;
FOUNDATION_EXPORT NSString *const phoneKey;

@interface TXUserInfo : NSObject

/*姓名*/
- (void)setName:(NSString*)name;
- (NSString*)name;

/*头像*/
- (void)setHead:(NSString*)head;
- (NSString*)head;

/*性别（0，女，1，男）*/
- (void)setGender:(NSInteger)gender;
- (NSInteger)gender;

/*电话*/
- (void)setPhone:(NSString*)phone;
- (NSString*)phone;

/*设置数据*/
- (void)setDataWithParameters:(NSDictionary*)parameters;

/*移除全部数据*/
- (void)removeAllData;

@end
