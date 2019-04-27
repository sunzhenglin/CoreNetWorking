//
//  TXNWHUD.m
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/27.
//

#import "TXNWHUD.h"

@implementation TXNWHUD

/**
 *  显示HUD
 *  @param showHUDType HUD显示类型
 *  @param info 信息
 */
+ (void)showHUDWithShowHUDType:(NWShowHUDType)showHUDType info:(NSString*)info{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    if (showHUDType==NWShowHUDTypeDefault) {
        [SVProgressHUD show];
    }else if (showHUDType==NWShowHUDTypeInfo){
        [SVProgressHUD showWithStatus:info];
    }else if (showHUDType==NWShowHUDTypeCaveatInfo){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.128 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showInfoWithStatus:info];
        });
    }else if (showHUDType==NWShowHUDTypeSuccessInfo){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.128 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:info];
        });
    }else if (showHUDType==NWShowHUDTypeFailureInfo){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.128 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:info];
        });
    }else{
        [SVProgressHUD show];
    }
}

/** 消除HUD */
+ (void)dismissHUD{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.128 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
