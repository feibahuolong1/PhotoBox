//
//  User.h
//  PhotosBox
//
//  Created by Broc on 2017/4/5.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

singleton_interface(User)

@property (nonatomic,copy) NSString *userPassword;
@end
