//
//  TXNetErrorDelegate.h
//  SchoolWatchParent
//
//  Created by komlin on 2018/9/4.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXNetErrorCode.h"

@class TXNetErrorDelegate;
@protocol TXNetWorkRequestErrorDelegate <NSObject>
@optional
/** 错误类型 */
- (void)netErrorDelegate:(TXNetErrorDelegate*)netErrorDelegate errorCodeType:(TXErrorCodeType)errorCodeType;
@end
@interface TXNetErrorDelegate : NSObject
/** 代理属性 */
@property (nonatomic,weak)id <TXNetWorkRequestErrorDelegate> delegate;
@end
