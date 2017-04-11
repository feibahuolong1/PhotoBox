//
//  FileMethod.m
//  PhotosBox
//
//  Created by Broc on 2017/4/10.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "FileMethod.h"

@implementation FileMethod
// 创建文件夹
+ (void)createDicWithName:(NSString *)name {
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
    //    NSLog(@"%@",path);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir)) {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建文件夹失败！");
        }
        NSLog(@"创建文件夹成功，文件路径%@",path);
    }else {
        NSLog(@"文件夹已存在 \n %@",path);
    }
}

// 获取文件夹下文件名称列表
+ (NSArray *)fileListWithPath:(NSString *)path{
    NSArray *fileArray = [[NSArray alloc]init];
    NSFileManager* manager = [NSFileManager defaultManager];
    fileArray = [manager contentsOfDirectoryAtPath:path error:nil];
    return fileArray;
}
// 写文件
+ (void)writeFileWithfileName:(NSString *)fileName fullData:(NSData *)fullData lowData:(NSData *)lowData {
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString *fullPath = [NSString stringWithFormat:@"%@/Documents/%@/%@",NSHomeDirectory(),PB_FULL_DIC,fileName];
    [manager createFileAtPath:fullPath contents:fullData attributes:nil];
    
    NSString *lowPath = [NSString stringWithFormat:@"%@/Documents/%@/%@",NSHomeDirectory(),PB_LOW_DIC,fileName];
    [manager createFileAtPath:lowPath contents:lowData attributes:nil];
}

// 读取文件
+ (NSData *)readFileWithDic:(NSString *)dicName fileName:(NSString *)fileName{
     NSString *fullPath = [NSString stringWithFormat:@"%@/Documents/%@/%@.%@",NSHomeDirectory(),dicName,fileName,FileType];
    NSData *data = [NSData dataWithContentsOfFile:fullPath];
    return data;
}

// 删除文件
+ (void)deleteFileWithFileName:(NSString *)fileName {
     NSFileManager* manager = [NSFileManager defaultManager];
    NSString *fullPath = [NSString stringWithFormat:@"%@/Documents/full/%@.%@",NSHomeDirectory(),fileName,FileType];
    NSString *lowPath = [NSString stringWithFormat:@"%@/Documents/low/%@.%@",NSHomeDirectory(),fileName,FileType];
    [manager removeItemAtPath:fullPath error:nil];
    [manager removeItemAtPath:lowPath error:nil];
}


// 截取图片最大的正方形
+ (NSData *)cutCenterSquareImage:(NSData *)imageData{
    UIImage *oldImage = [UIImage imageWithData:imageData];
         CGSize imageSize = oldImage.size;
        // 中间最大正方形尺寸
         CGRect centerRect;
         CGFloat centerRectWH;
         //根据图片的大小计算出图片中间矩形区域的位置与大小
         if (imageSize.width > imageSize.height) {
                 centerRectWH = imageSize.height;
                 float leftMargin = (imageSize.width - imageSize.height) * 0.5;
                 centerRect = CGRectMake(leftMargin,0,centerRectWH,centerRectWH);
             }else{
                     centerRectWH = imageSize.width;
                     float topMargin = (imageSize.height - imageSize.width)*0.5;
                     centerRect = CGRectMake(0,topMargin,centerRectWH,centerRectWH);
                 }
    
         CGImageRef imageRef = oldImage.CGImage;
         //在最大正方形尺寸范围内截取
         CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, centerRect);
         UIImage *tmp = [[UIImage alloc] initWithCGImage:imageRefRect];
         CGImageRelease(imageRefRect);// tmp是截取之后的image
    
    
         return UIImageJPEGRepresentation(tmp, 1);
     }
@end
