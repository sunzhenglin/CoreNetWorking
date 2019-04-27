//
//  TXNetErrorDelegate.h
//  SchoolWatchParent
//
//  Created by komlin on 2018/9/4.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 错误代码代理 */
@class TXNetErrorDelegate;
@protocol TXNetWorkRequestErrorDelegate <NSObject>
@optional
/** 错误类型 */
- (void)netErrorDelegate:(TXNetErrorDelegate*)netErrorDelegate errorCode:(NSInteger)errorCode errorCodeString:(NSString*)errorCodeString;
@end
@interface TXNetErrorDelegate : NSObject
/** 代理属性 */
@property (nonatomic,weak)id <TXNetWorkRequestErrorDelegate> delegate;
/** 错误代码 */
@property (nonatomic,assign,readonly)NSInteger errorCode;
/** 错误代码翻译 */
@property (nonatomic,copy,readonly)NSString *errorCodeString;
/** 获取错误代码的值 */
+ (NSString*)errorCodeKeyForValue:(NSInteger)key;
/** 获取错误代码的键 */
+ (NSInteger)errorCodeValueForKey:(NSString*)value;
@end
