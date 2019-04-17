//
//  TXNetErrorCode.m
//  SchoolWatchParent
//
//  Created by komlin on 2018/9/4.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import "TXNetErrorCode.h"

NSString * const TXNetWorkRequestErrorNotification =@"netWorkRequestErrorNotification";
NSString * const errorCodeTypeKey=@"errorCodeType";

@implementation TXNetErrorCode

/**
 *  是否包含错误代码
 *  @param errorCodeType 错误代码
 */
+ (BOOL)isContainErrorCodeType:(TXErrorCodeType)errorCodeType{
    TXErrorCodeType aErrorCodeType =(TXErrorCodeTypeIllegalRequest|
                                     TXErrorCodeTypeSMSVerificationCodeIsInvalid|
                                     TXErrorCodeTypeUsernameOrPasswordIsIncorrect|
                                     TXErrorCodeTypeParameterError|
                                     TXErrorCodeTypeContactHasReachedTheLimit|
                                     TXErrorCodeTypeEmergencyContactHasReachedTheLimit|
                                     TXErrorCodeTypeStudentInformationNotFound|
                                     TXErrorCodeTypeTeacherInformationNotFound|
                                     TXErrorCodeTypeUnboundMobileNumber|
                                     TXErrorCodeTypeNameVerificationFailed|
                                     TXErrorCodeTypeRepeatBindingStudentInformation|
                                     TXErrorCodeTypeParentUserNotFound|
                                     TXErrorCodeTypeAlarmAddedToTheUpperLimit|
                                     TXErrorCodeTypeCantDeleteYourself|
                                     TXErrorCodeTypeNoDeletePermission|
                                     TXErrorCodeTypeNoFenceSet|
                                     TXErrorCodeTypeNotInSchool|
                                     TXErrorCodeTypePunched|
                                     TXErrorCodeTypeSameTitle|
                                     TXErrorCodeTypeNotWearingAWatch|
                                     TXErrorCodeTypeNoDataHeartRate|
                                     TXErrorCodeTypeNoAccess|
                                     TXErrorCodeTypeWatchIsNotOnLine|
                                     TXErrorCodeTypeInsufficientRedemption|
                                     TXErrorCodeTypeFileNotFound|
                                     TXErrorCodeTypeNoInspectionItemsFound|
                                     TXErrorCodeTypeTimeSelectionError|
                                     TXErrorCodeTypeLeave|
                                     TXErrorCodeTypeRepeatAddingFriendNumbers|
                                     TXErrorCodeTypeFakeCourseIsNotProcessed|
                                     TXErrorCodeTypeOperationFailed|
                                     TXErrorCodeTypeUFaceRegistrationFailed|
                                     TXErrorCodeTypeUFaceImageUploadFailed|
                                     TXErrorCodeTypeUFaceUserIsNotRegistered|
                                     TXErrorCodeTypeUFaceUserIsAlreadyRegistered|
                                     TXErrorCodeTypePermissionDenied|
                                     TXErrorCodeTypeNoNeedToSignIn|
                                     TXErrorCodeTypeNotAPublicHolidayDontLetASubstitute|
                                     TXErrorCodeTypeTypeNameCannotBeEmpty|
                                     TXErrorCodeTypeTheNumberOfRecipientsCannotBeEmpty|
                                     TXErrorCodeTypeUserNotFound|
                                     TXErrorCodeTypeNoMaterialsFound|
                                     TXErrorCodeTypeInsufficientRemainingQuantity|
                                     TXErrorCodeTypeTypeIdCannotBeEmpty|
                                     TXErrorCodeTypeTypeNotFound|
                                     TXErrorCodeTypeItemNameCannotBeEmpty|               
                                     TXErrorCodeTypeProductionDateCannotBeEmpty|
                                     TXErrorCodeTypeShelfLifeCannotBeEmpty|
                                     TXErrorCodeTypeInboundTimeCannotBeEmpty|
                                     TXErrorCodeTypeBasicUnitCannotBeEmpty|
                                     TXErrorCodeTypeUnitLayerCannotBeEmpty|
                                     TXErrorCodeTypeTheNumberOfPrintsCannotBeEmpty|
                                     TXErrorCodeTypeSubmitterCannotBeEmpty|
                                     TXErrorCodeTypeTheWarehousingStaffCannotBeEmpty|
                                     TXErrorCodeTypeTheNumberOfUnitsIsIncorrect|
                                     TXErrorCodeTypeMaterialIdCannotBeEmpty|
                                     TXErrorCodeTypeDeleteTypeCannotBeEmpty|
                                     TXErrorCodeTypeMaterialHasBeenDeleted|
                                     TXErrorCodeTypeProductBarcodeCannotBeEmpty|
                                     TXErrorCodeTypeTheNumberOfInspectionsHasReachedTheUpperLimit|
                                     TXErrorCodeTypeShortIntervalFromLastInspection|
                                     TXErrorCodeTypeTheFakeArticleHasBeenSubmittedAndIsNotOperational|
                                     TXErrorCodeTypeJobNotFound|
                                     TXErrorCodeTypeStudentNotFound|
                                     TXErrorCodeTypeReplyAlreadyExists|
                                     TXErrorCodeTypeDeadlineCannotBeEarlierThanCurrentTime|
                                     TXErrorCodeTypeNoSubjectsFound|
                                     TXErrorCodeTypePleaseSelectASubject|
                                     TXErrorCodeTypePleaseSelectAClass|
                                     TXErrorCodeTypePleaseEnterAJobTitle|
                                     TXErrorCodeTypePleaseEnterADeadline|
                                     TXErrorCodeTypeNoMealPlan|
                                     TXErrorCodeTypeServerError|
                                     TXErrorCodeTypeDataSaveFailed|
                                     TXErrorCodeTypeDataDeletionFailed|
                                     TXErrorCodeTypeFrequentOperation|
                                     TXErrorCodeTypeRongyunPlatformUserRegistrationFailed|
                                     TXErrorCodeTypeRongyunPlatformFailedToUpdateUsers|
                                     TXErrorCodeTypeGuardianVerificationFailed|
                                     TXErrorCodeTypeActivationFailedMobileNumberHasBeenSelected|
                                     TXErrorCodeTypeActivationFailedWatchHasBeenActivated);
    if ((errorCodeType & aErrorCodeType)){
        return YES;
    }else{
        return NO;
    }
}

/** 错误消息 */
+ (NSString*)errorMessageWithErrorCodeType:(TXErrorCodeType)errorCodeType{
    if (errorCodeType==TXErrorCodeTypeIllegalRequest) {
        return @"非法请求";
    }else if (errorCodeType==TXErrorCodeTypeSMSVerificationCodeIsInvalid){
        return @"短信验证码无效";
    }else if (errorCodeType==TXErrorCodeTypeUsernameOrPasswordIsIncorrect){
        return @"用户名或密码不正确";
    }else if (errorCodeType==TXErrorCodeTypeParameterError){
        return @"参数错误（参数为空或格式不正确)";
    }else if (errorCodeType==TXErrorCodeTypeContactHasReachedTheLimit){
        return @"联系人已达上限(最大10人)";
    }else if (errorCodeType==TXErrorCodeTypeEmergencyContactHasReachedTheLimit){
        return @"紧急联系人已达上限(最大5人)";
    }else if (errorCodeType==TXErrorCodeTypeStudentInformationNotFound){
        return @"未找到学生信息";
    }else if (errorCodeType==TXErrorCodeTypeTeacherInformationNotFound){
        return @"未找到教师信息";
    }else if (errorCodeType==TXErrorCodeTypeUnboundMobileNumber){
        return @"未绑定手机号码";
    }else if (errorCodeType==TXErrorCodeTypeNameVerificationFailed){
        return @"姓名校验失败";
    }else if (errorCodeType==TXErrorCodeTypeRepeatBindingStudentInformation){
        return @"重复绑定学生信息";
    }else if (errorCodeType==TXErrorCodeTypeParentUserNotFound){
        return @"未找到家长用户";
    }else if (errorCodeType==TXErrorCodeTypeAlarmAddedToTheUpperLimit){
        return @"闹钟添加达到上限";
    }else if (errorCodeType==TXErrorCodeTypeCantDeleteYourself){
        return @"不能删除自己";
    }else if (errorCodeType==TXErrorCodeTypeNoDeletePermission){
        return @"没有删除权限";
    }else if (errorCodeType==TXErrorCodeTypeNoFenceSet){
        return @"没有设置栅栏";
    }else if (errorCodeType==TXErrorCodeTypeNotInSchool){
        return @"不在学校内";
    }else if (errorCodeType==TXErrorCodeTypePunched){
        return @"已打卡";
    }else if (errorCodeType==TXErrorCodeTypeSameTitle){
        return @"存在相同称呼";
    }else if (errorCodeType==TXErrorCodeTypeNotWearingAWatch){
        return @"未佩戴手表";
    }else if (errorCodeType==TXErrorCodeTypeNoDataHeartRate){
        return @"未获取数据";
    }else if (errorCodeType==TXErrorCodeTypeNoAccess){
        return @"没有访问权限";
    }else if (errorCodeType==TXErrorCodeTypeWatchIsNotOnLine){
        return @"手表不在线";
    }else if (errorCodeType==TXErrorCodeTypeInsufficientRedemption){
        return @"兑换数量不足";
    }else if (errorCodeType==TXErrorCodeTypeFileNotFound){
        return @"未找到文件";
    }else if (errorCodeType==TXErrorCodeTypeNoInspectionItemsFound){
        return @"未找到巡检项目";
    }else if (errorCodeType==TXErrorCodeTypeTimeSelectionError){
        return @"时间选择错误";
    }else if (errorCodeType==TXErrorCodeTypeLeave){
        return @"请假中";
    }else if (errorCodeType==TXErrorCodeTypeRepeatAddingFriendNumbers){
        return @"重复添加好友号码";
    }else if (errorCodeType==TXErrorCodeTypeFakeCourseIsNotProcessed){
        return @"假条代课未处理完成";
    }else if (errorCodeType==TXErrorCodeTypeOperationFailed){
        return @"操作失败";
    }else if (errorCodeType==TXErrorCodeTypeUFaceRegistrationFailed){
        return @"Face注册失败";
    }else if (errorCodeType==TXErrorCodeTypeUFaceImageUploadFailed){
        return @"Face图片上传失败";
    }else if (errorCodeType==TXErrorCodeTypeUFaceUserIsNotRegistered){
        return @"Face用户未注册";
    }else if (errorCodeType==TXErrorCodeTypePermissionDenied){
        return @"没有权限";
    }else if (errorCodeType==TXErrorCodeTypeNoNeedToSignIn){
        return @"不需要签到";
    }else if (errorCodeType==TXErrorCodeTypeNotAPublicHolidayDontLetASubstitute){
        return @"事假不能代课";
    }else if (errorCodeType==TXErrorCodeTypeUFaceUserIsAlreadyRegistered){
        return @"Face用户已注册";
    }else if (errorCodeType==TXErrorCodeTypeTypeNameCannotBeEmpty){
        return @"类型名称不能为空";
    }else if (errorCodeType==TXErrorCodeTypeTheNumberOfRecipientsCannotBeEmpty){
        return @"领用数量不能为空";
    }else if (errorCodeType==TXErrorCodeTypeUserNotFound){
        return @"未找到用户";
    }else if (errorCodeType==TXErrorCodeTypeNoMaterialsFound){
        return @"未找到物资";
    }else if (errorCodeType==TXErrorCodeTypeInsufficientRemainingQuantity){
        return @"剩余数量不足";
    }else if (errorCodeType==TXErrorCodeTypeTypeIdCannotBeEmpty){
        return @"类型id不能为空";
    }else if (errorCodeType==TXErrorCodeTypeTypeNotFound){
        return @"未找到类型";
    }else if (errorCodeType==TXErrorCodeTypeItemNameCannotBeEmpty){
        return @"物品名称不能为空";
    }else if (errorCodeType==TXErrorCodeTypeProductionDateCannotBeEmpty){
        return @"生产日期不能为空";
    }else if (errorCodeType==TXErrorCodeTypeShelfLifeCannotBeEmpty){
        return @"保质期不能为空";
    }else if (errorCodeType==TXErrorCodeTypeInboundTimeCannotBeEmpty){
        return @"入库时间不能为空";
    }else if (errorCodeType==TXErrorCodeTypeBasicUnitCannotBeEmpty){
        return @"基本单位不能为空";
    }else if (errorCodeType==TXErrorCodeTypeUnitLayerCannotBeEmpty){
        return @"单位层数不能为空";
    }else if (errorCodeType==TXErrorCodeTypeTheNumberOfPrintsCannotBeEmpty){
        return @"打印数量不能为空";
    }else if (errorCodeType==TXErrorCodeTypeSubmitterCannotBeEmpty){
        return @"提交人员不能为空";
    }else if (errorCodeType==TXErrorCodeTypeTheWarehousingStaffCannotBeEmpty){
        return @"入库人员不能为空";
    }else if (errorCodeType==TXErrorCodeTypeTheNumberOfUnitsIsIncorrect){
        return @"单位层数有误";
    }else if (errorCodeType==TXErrorCodeTypeMaterialIdCannotBeEmpty){
        return @"物资id不能为空";
    }else if (errorCodeType==TXErrorCodeTypeDeleteTypeCannotBeEmpty){
        return @"删除类型不能为空";
    }else if (errorCodeType==TXErrorCodeTypeMaterialHasBeenDeleted){
        return @"物资已删除";
    }else if (errorCodeType==TXErrorCodeTypeProductBarcodeCannotBeEmpty){
        return @"商品条形码不能为空";
    }else if (errorCodeType==TXErrorCodeTypeTheNumberOfInspectionsHasReachedTheUpperLimit){
        return @"巡检次数已达上限";
    }else if (errorCodeType==TXErrorCodeTypeShortIntervalFromLastInspection){
        return @"与上次巡检时间间隔过短";
    }else if (errorCodeType==TXErrorCodeTypeTheFakeArticleHasBeenSubmittedAndIsNotOperational){
        return @"假条已经提交，不可操作";
    }else if (errorCodeType==TXErrorCodeTypeJobNotFound){
        return @"未找到作业";
    }else if (errorCodeType==TXErrorCodeTypeStudentNotFound){
        return @"未找到学生";
    }else if (errorCodeType==TXErrorCodeTypeReplyAlreadyExists){
        return @"回复已存在";
    }else if (errorCodeType==TXErrorCodeTypeDeadlineCannotBeEarlierThanCurrentTime){
        return @"截止时间不能早于当前时间";
    }else if (errorCodeType==TXErrorCodeTypeNoSubjectsFound){
        return @"未找到科目";
    }else if (errorCodeType==TXErrorCodeTypePleaseSelectASubject){
        return @"请选择科目";
    }else if (errorCodeType==TXErrorCodeTypePleaseSelectAClass){
        return @"请选择班级";
    }else if (errorCodeType==TXErrorCodeTypePleaseEnterAJobTitle){
        return @"请输入作业标题";
    }else if (errorCodeType==TXErrorCodeTypePleaseEnterADeadline){
        return @"请输入截止时间";
    }else if (errorCodeType==TXErrorCodeTypeNoMealPlan){
        return @"没有陪餐计划";
    }else if (errorCodeType==TXErrorCodeTypeServerError){
        return @"服务器发生错误";
    }else if (errorCodeType==TXErrorCodeTypeDataSaveFailed){
        return @"数据保存失败";
    }else if (errorCodeType==TXErrorCodeTypeDataDeletionFailed){
        return @"数据删除失败";
    }else if (errorCodeType==TXErrorCodeTypeFrequentOperation){
        return @"操作频繁";
    }else if (errorCodeType==TXErrorCodeTypeRongyunPlatformUserRegistrationFailed){
        return @"融云平台用户注册失败";
    }else if (errorCodeType==TXErrorCodeTypeRongyunPlatformFailedToUpdateUsers){
        return @"融云平台更新用户失败";
    }else if (errorCodeType==TXErrorCodeTypeGuardianVerificationFailed){
        return @"监护人校验失败";
    }else if (errorCodeType==TXErrorCodeTypeActivationFailedMobileNumberHasBeenSelected){
        return @"激活失败,手机号码已被选";
    }else if (errorCodeType==TXErrorCodeTypeActivationFailedWatchHasBeenActivated){
        return @"激活失败,手表已被激活";
    }else{
         return @"未知错误";
    }
}

/** 推送错误代码 */
+ (void)pushNetWorkRequestErrorWithErrorCodeType:(TXErrorCodeType)errorCodeType{
    NSDictionary *parameters=@{errorCodeTypeKey:[NSNumber numberWithInteger:errorCodeType]};
    [[NSNotificationCenter defaultCenter] postNotificationName:TXNetWorkRequestErrorNotification object:nil userInfo:parameters];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TXNetWorkRequestErrorNotification object:nil];
}

@end
