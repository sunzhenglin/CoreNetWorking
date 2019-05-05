//
//  TXAppDelegate.h
//  CoreNetWorking
//
//  Created by acct<blob>=0xE7A9BAE781B5E699BAE883BD on 02/25/2019.
//  Copyright (c) 2019 acct<blob>=0xE7A9BAE781B5E699BAE883BD. All rights reserved.
//


@import UIKit;
#import <MGJRouter.h>
#import <TXNulleSchoolTeacherLoginModuleRouter.h>
#import "TXViewController.h"
#import "TXNetWorking.h"

@interface TXAppDelegate : UIResponder <UIApplicationDelegate,TXNetWorkRequestErrorDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TXNetErrorDelegate *netErrorDelegate;

@end
