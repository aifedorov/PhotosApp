//
//  AFAlbumsTableViewController.m
//  PhotosApp
//
//  Created by Александр on 29.03.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFAlbumsTableViewController.h"
#import "AFAlbumTableViewCell.h"
#import "AFPhotosCollectionViewController.h"

@import Photos;

@interface AFAlbumsTableViewController ()

@property (strong,nonatomic) PHFetchResult *userAlbums;

@end

@implementation AFAlbumsTableViewController

static NSString * const cellIdentifier = @"albumCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userAlbums = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (PHFetchResult *) fetchPhotosAtIndexPath:(PHFetchResult *)fetchResult indexPath:(NSIndexPath *)indexPath {
    
    PHAssetCollection *assetCollection = (PHAssetCollection *)fetchResult[indexPath.row];
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
   
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
    
    return assetsFetchResult;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.userAlbums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AFAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    PHFetchResult *assetsFetchResult = [self fetchPhotosAtIndexPath:self.userAlbums indexPath:indexPath];
    
    PHAsset *asset = [assetsFetchResult lastObject];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize assetThumbnailSize = CGSizeMake(CGRectGetWidth(cell.thumbnailImageView.bounds) * scale, CGRectGetHeight(cell.thumbnailImageView.bounds) * scale);
    
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                 targetSize:assetThumbnailSize
                                contentMode:PHImageContentModeDefault
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  cell.thumbnailImage = result;
                              }];
    
    PHAssetCollection *assetCollection = (PHAssetCollection *)self.userAlbums[indexPath.row];
    
    cell.nameLable.text = assetCollection.localizedTitle;
    cell.countPhotos.text = [NSString stringWithFormat:@"%ld", [assetsFetchResult count]];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[AFPhotosCollectionViewController class]]) {
        
        AFPhotosCollectionViewController *photosCollectionViewController = segue.destinationViewController;
        AFAlbumTableViewCell *cell = sender;
    
        photosCollectionViewController.title = cell.nameLable.text;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        photosCollectionViewController.photosAssetsFetchResults = [self fetchPhotosAtIndexPath:self.userAlbums indexPath:indexPath];
    }
}

@end
