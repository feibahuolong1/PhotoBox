//
//  Macros.h
//  PhotosBox
//
//  Created by Broc on 2017/4/5.
//  Copyright © 2017年 Broc. All rights reserved.
//

#ifndef Macros_h
#define Macros_h



//************************     单例化一个类     ************************
// @interface
#define singleton_interface(className) \
+ (className *)sharedInstace##className;\

// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}\
+ (className *)sharedInstace##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

// 管理员密码

#define PB_ROOT_PASSWORD @"Broc1993!"

// 管理员答案

#define PB_ROOT_ANSWER @"Broc1993!"

// 弹窗
#define alert(msg) [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];






#endif /* Macros_h */
