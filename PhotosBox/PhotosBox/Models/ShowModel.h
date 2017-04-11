//
//  ShowModel.h
//  PhotosBox
//
//  Created by Broc on 2017/4/10.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowModel : NSObject
@property(nonatomic,assign)float width;
@property(nonatomic,assign)float height;
@property(nonatomic,copy)NSString *fullImagePath;
@property(nonatomic,copy)NSString *lowImagePath;
@property(nonatomic,copy)NSString *fileName;
@end
