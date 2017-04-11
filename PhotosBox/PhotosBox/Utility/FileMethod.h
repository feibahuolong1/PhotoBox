//
//  FileMethod.h
//  PhotosBox
//
//  Created by Broc on 2017/4/10.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileMethod : NSObject
// 创建文件夹
+ (void)createDicWithName:(NSString *)name;

// 获取文件夹下文件名称列表
+ (NSMutableArray *)fileListWithPath:(NSString *)path;

// 写文件
+ (void)writeFileWithfileName:(NSString *)fileName fullData:(NSData *)fullData lowData:(NSData *)lowData;

// 读取文件
+ (NSData *)readFileWithDic:(NSString *)dicName fileName:(NSString *)fileName;
@end
