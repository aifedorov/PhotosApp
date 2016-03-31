//
//  AFPhotosCollectionViewController.m
//  PhotosApp
//
//  Created by Александр on 30.03.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFPhotosCollectionViewController.h"
#import "AFPhotoCollectionViewCell.h"
#import "AFPreviewPhotoViewController.h"

@interface AFPhotosCollectionViewController ()

@end

@implementation AFPhotosCollectionViewController

static NSString * const reuseIdentifier = @"CellView";
static CGSize AssetThumbnailSize;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cellSize = ((UICollectionViewFlowLayout *)self.collectionViewLayout).itemSize;
    AssetThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[AFPreviewPhotoViewController class]]) {
        
        AFPreviewPhotoViewController *previewPhotoViewController = segue.destinationViewController;
        AFPhotoCollectionViewCell *cell = sender;
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        PHAsset *asset = [self.assetsFetchResults objectAtIndex:indexPath.item];
        previewPhotoViewController.asset = asset;
        
    }
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.assetsFetchResults count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    
    AFPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.representedAssetIdentifier = asset.localIdentifier;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                 targetSize:AssetThumbnailSize
                                contentMode:PHImageContentModeDefault
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
                                      cell.thumbnailImage = result;
                                  }
                              }];
    
    return cell;
}

@end
