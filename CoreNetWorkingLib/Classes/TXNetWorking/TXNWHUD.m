//
//  TXNWHUD.m
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/27.
//

#import "TXNWHUD.h"

@implementation TXNWHUD

/** HUD默认设置 */
+ (void)HUDDefaultSetting{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
}

/**
 *  显示HUD
 *  @param showHUDType HUD显示类型
 *  @param info 信息
 */
+ (void)showHUDWithShowHUDType:(NWShowHUDType)showHUDType info:(NSString*)info{
    [self HUDDefaultSetting];
    if (showHUDType==NWShowHUDTypeInfo){
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:info];
        });
    }else if (showHUDType==NWShowHUDTypeCaveatInfo){
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showInfoWithStatus:info];
        });
    }else if (showHUDType==NWShowHUDTypeSuccessInfo){
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:info];
        });
    }else if (showHUDType==NWShowHUDTypeFailureInfo){
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:info];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
        });
    }
}

/**
 *  显示进度HUD
 *  @param progress 进度(0到1)
 *  @param info 信息
 */
+ (void)showHUDWithProgress:(CGFloat)progress info:(NSString*)info{
    [self HUDDefaultSetting];
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showProgress:progress status:info];
    });
}

/** 消除HUD */
+ (void)dismissHUD{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.512 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
