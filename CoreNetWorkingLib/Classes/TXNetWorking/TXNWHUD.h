//
//  TXNWHUD.h
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/27.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

/** HUD显示类型 */
typedef NS_ENUM(NSInteger,NWShowHUDType){
    NWShowHUDTypeDefault     =0,//默认
    NWShowHUDTypeInfo        =1,//信息
    NWShowHUDTypeCaveatInfo  =2,//警告
    NWShowHUDTypeSuccessInfo =3,//成功
    NWShowHUDTypeFailureInfo =4,//失败
};

@interface TXNWHUD : NSObject
/**
 *  显示HUD
 *  @param showHUDType HUD显示类型
 *  @param info 信息
 */
+ (void)showHUDWithShowHUDType:(NWShowHUDType)showHUDType info:(NSString* _Nullable)info;

/**
 *  显示进度HUD
 *  @param progress 进度(0到1)
 *  @param info 信息
 */
+ (void)showHUDWithProgress:(CGFloat)progress info:(NSString* _Nullable)info;

/** 消除HUD */
+ (void)dismissHUD;
@end

NS_ASSUME_NONNULL_END
