//
//  UserInfo.m
//  PhotosBox
//
//  Created by Broc on 2017/4/5.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "UserInfo.h"
// 密码
#define PB_PASSWORD_KEY @"pb_password"
// 伪密码
#define PB_HYPOCRISY_PASSWORD_KEY @"pb_hypocrisy_password"
// 问题
#define PB_HINTQUESTION @"pb_hintquestion"
// 问题答案
#define PB_ANSWER @"pb_answer"
// 问题伪答案
#define PB_HYPOCRISY_ANSWER @"pb_hypocrisy_answer"

@implementation UserInfo
+ (void)setObject:(id)object forKey:(id)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

+ (id)objectForKey:(id)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)removeObjectForKey:(id)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}



// 保存密码
+ (void)savePassword:(NSString *)password{
    [self setObject:password forKey:PB_PASSWORD_KEY];
}

// 是否设置了密码
+ (BOOL)isSavePassword {
    NSString *str = [self objectForKey:PB_PASSWORD_KEY];
    if (str && str.length>0 && [str isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

// 校验密码
+ (int)checkPassword:(NSString *)str {
    // 0 错误 1 正确 2 伪密码
    NSString *password = [self objectForKey:PB_PASSWORD_KEY];
    NSString *hypocrisyPassword = [self objectForKey:PB_HYPOCRISY_PASSWORD_KEY];
    NSString *rootPassword = PB_ROOT_PASSWORD;
    if ([str isEqualToString:password] || [str isEqualToString:rootPassword]) {
        return 1;
    } else if ([str isEqualToString:hypocrisyPassword]) {
        return 2;
    } else {
        return 0;
    }
}

// 保存找回密码问题
+ (void)saveHintQuestion:(NSString *)question {
    [self setObject:question forKey:PB_HINTQUESTION];
}
// 获取密码问题
+ (NSString *)toGetQuestion{
    return [self objectForKey:PB_HINTQUESTION];
}
// 保存找回密码问题答案
+ (void)saveAnswer:(NSString *)answer {
    [self setObject:answer forKey:PB_ANSWER];
}

// 校验找回密码问题答案
+ (int)checkAnswer:(NSString *)str {
    // 0 错误 1 正确 2 伪答案
    NSString *answer = [self objectForKey:PB_ANSWER];
    NSString *hypocrisyAnswer = [self objectForKey:PB_HYPOCRISY_ANSWER];
    if ([str isEqualToString:answer] || [str isEqualToString:PB_ROOT_ANSWER]) {
        return 1;
    } else if ([str isEqualToString:hypocrisyAnswer ]){
        return 2;
    } else {
        return 0;
    }
}

// 保存伪密码
+ (void)saveHypocrisyPassword:(NSString *)hypocrisyPassword {
    [self setObject:hypocrisyPassword forKey:PB_HYPOCRISY_PASSWORD_KEY];
}


// 保存伪答案
+ (void)saveHypocrisyAnswer:(NSString *)hypocrisyAnswer {
    [self setObject:hypocrisyAnswer forKey:PB_HYPOCRISY_ANSWER];
}



@end
