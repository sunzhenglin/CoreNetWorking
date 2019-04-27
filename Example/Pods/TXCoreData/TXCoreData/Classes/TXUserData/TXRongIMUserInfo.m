//
//  TXRongIMUserInfo.m
//  NulleEduParent
//
//  Created by komlin on 2018/10/25.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import "TXRongIMUserInfo.h"

NSString *const userIdKey=@"rongIMUserInfo.userId";

@implementation TXRongIMUserInfo
{
    NSString *_userId;//用户ID
}

/*userId*/
- (void)setUserId:(NSString*)userId{
    _userId=userId;
    [[NSUserDefaults standardUserDefaults] setObject:_userId forKey:userIdKey];
}
- (NSString*)userId{
    if (!_userId) {
        _userId=[[NSUserDefaults standardUserDefaults] valueForKey:userIdKey];
    }
    return _userId;
}

/*设置数据*/
- (void)setDataWithParameters:(NSDictionary*)parameters{
    if([[parameters allKeys] containsObject:@"userId"]){
        NSString * userId=parameters[@"userId"];
        self.userId=userId;
    }
}

/*移除全部数据*/
- (void)removeAllData{
    self.userId=nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userIdKey];
}

@end
