//
//  TXNetModel.h
//  SchoolWatchParent
//
//  Created by xtz_pioneer on 2018/7/12.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import "TXModel.h"

@interface TXNetModel : TXModel
/** code值:0成功 非0时取值为错误代码 */
@property (nonatomic,assign)NSInteger code;
/** data为服务器返回给用户的有效数据,data为空时,该属性不出现 */
@property (nonatomic,strong)id data;
/** msg值为返回消息,非0时数据有效.告知请求者错误消息,此消息严禁用于用户交互 */
@property (nonatomic,copy)NSString *msg;
@end
