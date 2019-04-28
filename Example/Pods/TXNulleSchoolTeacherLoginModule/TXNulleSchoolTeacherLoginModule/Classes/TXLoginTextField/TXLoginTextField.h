//
//  TXLoginField.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/22.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 登录TextField */
@interface TXLoginTextField : UIView
/** 注释信息 */
@property (nonatomic,copy)NSString *tx_placeholder;
/** 光标颜色 */
@property (nonatomic,strong)UIColor *cursorColor;
/** 注释普通状态下颜色 */
@property (nonatomic,strong)UIColor *placeholderNormalStateColor;
/** 注释选中状态下颜色 */
@property (nonatomic,strong)UIColor *placeholderSelectStateColor;
/** 文本颜色 */
@property (nonatomic,strong)UIColor *textColor;
/** 文本Tint颜色 */
@property (nonatomic,strong)UIColor *textTintColor;
/** 是否密文显示 */
@property (nonatomic,assign)BOOL secureTextEntry;
/** 显示类型 */
@property (nonatomic,assign)UITextFieldViewMode clearButtonMode;
/** 键盘类型 */
@property (nonatomic,assign)UIKeyboardType keyboardType;
/** 文本字体 */
@property (nonatomic,strong)UIFont *textFont;
/** 注释普通状态下字体 */
@property (nonatomic,strong)UIFont *placeholderNormalStateFont;
/** 注释选中状态下字体 */
@property (nonatomic,strong)UIFont *placeholderSelectStateFont;
/** 文本 */
@property (nonatomic,copy)NSString *text;
/** 线的颜色 */
@property (nonatomic,strong)UIColor *lineColor;
/** 线的Layer颜色 */
@property (nonatomic,strong)UIColor *lineLayerColor;
@end
NS_ASSUME_NONNULL_END
