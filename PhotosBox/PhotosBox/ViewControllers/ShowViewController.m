//
//  ShowViewController.m
//  PhotosBox
//
//  Created by Broc on 2017/4/10.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "ShowViewController.h"
#import "ShowCollectionViewCell.h"
#import "ZWCollectionViewFlowLayout.h"
#import "ChooseImageViewController.h"
#import "ZLPhotoActionSheet.h"
#import "ZLDefine.h"
#import "ZLCollectionCell.h"
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "ZLSelectPhotoModel.h"
#import "ZLShowBigImage.h"
@interface ShowViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ZWwaterFlowDelegate>
@property(nonatomic,retain)UICollectionView * collectView;
@property(nonatomic,strong)NSMutableArray * shops;


@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化数据
//    NSArray * shopsArray = [shopModel objectArrayWithFilename:@"1.plist"];
//    [self.shops addObjectsFromArray:shopsArray];
    self.view.backgroundColor = [UIColor whiteColor];
    //注册cell
    ZWCollectionViewFlowLayout * layOut = [[ZWCollectionViewFlowLayout alloc] init];
    layOut.degelate =self;
    UICollectionView * collectView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layOut];
    collectView.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREENH_HEIGHT - 64);
    collectView.delegate =self;
    collectView.dataSource =self;
    [self.view addSubview:collectView];
    collectView.backgroundColor = [UIColor whiteColor];
    [collectView registerNib:[UINib nibWithNibName:@"ShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShowCollectionViewCell"];
    self.collectView = collectView;
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addImageBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _shops = [[NSMutableArray alloc]init];
    NSString *fullPath = [NSString stringWithFormat:@"%@/Documents/full",NSHomeDirectory()];
    for (NSString *fileName in [FileMethod fileListWithPath:fullPath]) {
        ShowModel *showModel = [[ShowModel alloc]init];
        showModel.fileName = fileName;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/full/%@",NSHomeDirectory(),fileName]]];
        showModel.width = image.size.width;
        showModel.height = image.size.height;
        [_shops addObject:showModel];
    }
    [self.collectView reloadData];
}
- (void)addImageBtnClick {
//    [self presentViewController:[ChooseImageViewController new] animated:YES completion:^{
//        
//    }];
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 9;
    weakify(self);
    [actionSheet showPhotoLibraryWithSender:self lastSelectPhotoModels:nil completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        strongify(weakSelf);
        [self whiteFileWithArr:selectPhotos selectPhotos:selectPhotoModels];
       // [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
        NSLog(@"%@", selectPhotos);
    }];
}
- (void)whiteFileWithArr:(NSArray *)fileList selectPhotos:(NSArray *)selectPhotos{
    NSLog(@"start");
    for (int i = 0;i < fileList.count;i++) {
        UIImage *imgae = [fileList objectAtIndex:i];
        ZLSelectPhotoModel *model = [selectPhotos objectAtIndex:i];
        NSString *name = [model.asset valueForKey:@"filename"];
        [FileMethod writeFileWithfileName:name fullData:UIImageJPEGRepresentation(imgae, 1) lowData:nil];
    }
    NSString *fullPath = [NSString stringWithFormat:@"%@/Documents/full",NSHomeDirectory()];
    NSLog(@"end-----   %@",[FileMethod fileListWithPath:fullPath]);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shops.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowModel *model = self.shops[indexPath.row];
    ShowCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowCollectionViewCell" forIndexPath:indexPath];
    cell.showImage.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/full/%@",NSHomeDirectory(),model.fileName]]];
    //cell.shop = self.shops[indexPath.item];
    return cell;
}
//代理方法
-(CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    if (self.shops.count == 0) {
        return 1;
    }
    ShowModel * shop = self.shops[indexPach.item];
    return shop.height/shop.width*width;
//    return 100;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowCollectionViewCell *cell = (ShowCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [ZLShowBigImage showBigImage:cell.showImage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
