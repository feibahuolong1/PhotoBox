//
//  ChooseImageViewController.m
//  PhotosBox
//
//  Created by Broc on 2017/4/10.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "ChooseImageViewController.h"
#import "ZLPhotoActionSheet.h"
#import "ZLDefine.h"
#import "ZLCollectionCell.h"
@interface ChooseImageViewController ()
@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrDataSources;
@end

@implementation ChooseImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self initCollectionView];
}
- (void)initCollectionView
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((width-9)/4, (width-9)/4);
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 1.5;
    layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZLCollectionCell" bundle:kZLPhotoBrowserBundle] forCellWithReuseIdentifier:@"ZLCollectionCell"];
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 2;
    weakify(self);
    [actionSheet showPhotoLibraryWithSender:self lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        strongify(weakSelf);
        strongSelf.arrDataSources = selectPhotos;
        strongSelf.lastSelectMoldels = selectPhotoModels;
        [strongSelf.collectionView reloadData];
        NSLog(@"%@", selectPhotos);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrDataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLCollectionCell" forIndexPath:indexPath];
    cell.btnSelect.hidden = YES;
    cell.imageView.image = _arrDataSources[indexPath.row];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ZLCollectionCell *cell = (ZLCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    [ZLShowBigImage showBigImage:cell.imageView];
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
