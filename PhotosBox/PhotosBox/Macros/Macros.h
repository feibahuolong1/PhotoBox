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

// 获取屏幕宽度与高度
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

// 弱引用/强引用
#define PBWeakSelf(type)  __weak typeof(type) weak##type = type;
#define PBStrongSelf(type)  __strong typeof(type) type = weak##type;


// 设置 view 圆角和边框
#define PBViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// 加载提示框
#define PBToast(str)              CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
[kWindow  makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
kWindow.userInteractionEnabled = NO; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
kWindow.userInteractionEnabled = YES;\
});\


// 加载
#define PB_ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define PB_HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define kWindow [UIApplication sharedApplication].keyWindow

#define kBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
[kWindow addSubview:aView]; \
} \
} \

#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:kWindow animated:YES];kShowNetworkActivityIndicator()

#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:kWindow animated:YES]

#define kRemoveBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \

#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()


#define FileType   @"jpg"

#define PB_FULL_DIC @"full"

#define PB_LOW_DIC @"low"

#endif /* Macros_h */
