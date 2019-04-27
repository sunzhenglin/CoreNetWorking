//
//  TXUserInfo.m
//  NulleEduParent
//
//  Created by xtz_pioneer on 2018/7/13.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import "TXUserInfo.h"

NSString *const nameKey=@"userInfo.name";
NSString *const headKey=@"userInfo.head";
NSString *const genderKey=@"userInfo.gender";
NSString *const phoneKey=@"userInfo.phone";

@implementation TXUserInfo
{
    NSString *_name;//姓名
    NSString *_head;//头像
    NSInteger _gender;//性别（0，女，1，男）
    NSString *_phone;//电话
}

/*姓名*/
- (void)setName:(NSString*)name{
    _name=name;
    [[NSUserDefaults standardUserDefaults] setObject:_name forKey:nameKey];
}
- (NSString*)name{
    if (!_name) {
        _name=[[NSUserDefaults standardUserDefaults] valueForKey:nameKey];
    }
    return _name;
}

/*头像*/
- (void)setHead:(NSString*)head{
    _head=head;
    [[NSUserDefaults standardUserDefaults] setObject:_head forKey:headKey];
}
- (NSString*)head{
    if (!_head) {
        _head=[[NSUserDefaults standardUserDefaults] valueForKey:headKey];
    }
    return _head;
}

/*性别（0，女，1，男）*/
- (void)setGender:(NSInteger)gender{
    _gender=gender;
    [[NSUserDefaults standardUserDefaults] setInteger:gender forKey:genderKey];
}
- (NSInteger)gender{
    if (!_gender) {
        _gender=[[[NSUserDefaults standardUserDefaults] valueForKey:genderKey] integerValue];
    }
    return _gender;
}

/*电话*/
- (void)setPhone:(NSString*)phone{
    _phone=phone;
    [[NSUserDefaults standardUserDefaults] setObject:_phone forKey:phoneKey];
}
- (NSString*)phone{
    if (!_phone) {
        _phone=[[NSUserDefaults standardUserDefaults] valueForKey:phoneKey];
    }
    return _phone;
}

/*设置数据*/
- (void)setDataWithParameters:(NSDictionary*)parameters{
    if([[parameters allKeys] containsObject:@"name"]){
        NSString * name=parameters[@"name"];
        self.name=name;
    }
    if([[parameters allKeys] containsObject:@"head"]){
        NSString * head=parameters[@"head"];
        self.head=head;
    }
    if([[parameters allKeys] containsObject:@"gender"]){
        NSInteger gender=[parameters[@"gender"] integerValue];
        self.gender=gender;
    }
    if([[parameters allKeys] containsObject:@"phone"]){
        NSString * phone=parameters[@"phone"];
        self.phone=phone;
    }
}

/*移除全部数据*/
- (void)removeAllData{
    self.name=nil;
    self.head=nil;
    self.gender=0;
    self.phone=nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:nameKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:headKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:genderKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:phoneKey];
}
@end
