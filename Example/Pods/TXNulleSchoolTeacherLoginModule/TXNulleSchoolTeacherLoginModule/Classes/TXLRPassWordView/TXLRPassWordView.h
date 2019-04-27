//
//  TXLRPassWordView.h
//  SchoolWatchParent
//
//  Created by xtz_pioneer on 2018/7/10.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*显示状态*/
typedef NS_ENUM(NSInteger,TXPassShowType){
    TXPassShowTypeBlackDotsHaveNoGaps       =0,//黑点,框,没间隔
    TXPassShowTypeDisplayNumbersBoxesNoGaps =1,//显示数字,框,没间隔
    TXPassShowTypeBlackDotsBoxesWithGaps    =2,//黑点,框,有间隔
    TXPassShowTypeDisplayNumbersBoxesWithIntervals=3,//显示数字,框,有间隔
    TXPassShowTypeDisplayNumberUnderline    =4,//显示数字,下划线,一般用做验证码
};

/*输入完成回调*/
typedef void(^TXCompletionHandler) (NSString * str);

@interface TXLRPassWordView : UIView
/*输入框*/
@property(nonatomic,strong)UITextField *textField;
/*主题色*/
@property(nonatomic,strong)UIColor *tintColor;
/*字体颜色*/
@property(nonatomic,strong)UIColor *textColor;
/*显示类型*/
@property(nonatomic,assign)TXPassShowType showType;
/*格子数*/
@property(nonatomic,assign)NSInteger number;
/*完成回调*/
@property(nonatomic,copy)TXCompletionHandler completionHandler;
/*显示*/
-(void)show;
/*清除*/
-(void)clean;
@end
