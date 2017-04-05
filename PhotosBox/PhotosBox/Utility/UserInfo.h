//
//  UserInfo.h
//  PhotosBox
//
//  Created by Broc on 2017/4/5.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject



// 保存密码
+ (void)savePassword:(NSString *)password;

// 是否设置了密码
+ (BOOL)isSavePassword;

// 校验密码
+ (int)checkPassword:(NSString *)str;

// 保存找回密码问题
+ (void)saveHintQuestion:(NSString *)question;

// 保存找回密码问题答案
+ (void)saveAnswer:(NSString *)answer;

// 校验找回密码问题答案
+ (int)checkAnswer:(NSString *)str;

// 保存伪密码
+ (void)saveHypocrisyPassword:(NSString *)hypocrisyPassword;

// 保存伪答案
+ (void)saveHypocrisyAnswer:(NSString *)hypocrisyAnswer;

@end
