#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TXCoreData.h"
#import "TXLogInInfo.h"
#import "TXRongIMUserInfo.h"
#import "TXUserDataDelegate.h"
#import "TXUserDataManager.h"
#import "TXUserInfo.h"

FOUNDATION_EXPORT double TXCoreDataVersionNumber;
FOUNDATION_EXPORT const unsigned char TXCoreDataVersionString[];

