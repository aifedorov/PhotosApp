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
@property (nonatomic, strong) PHImageManager *imageManager;

@end

@implementation AFAlbumsTableViewController

static NSString * const cellIdentifier = @"albumCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userAlbums = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    self.imageManager = [PHCachingImageManager defaultManager];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.userAlbums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AFAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    PHCollection *collection = self.userAlbums[indexPath.row];
    
    PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    PHAsset *asset = [assetsFetchResult lastObject];
    
    CGSize AssetGridThumbnailSize =  CGSizeMake(80.f, 80.f);
    
    [self.imageManager requestImageForAsset:asset
                                 targetSize:AssetGridThumbnailSize
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  cell.thumbnailImage = result;
                              }];
    

    cell.nameLable.text = assetCollection.localizedTitle;
    cell.countPhotos.text = [NSString stringWithFormat:@"%ld", [assetsFetchResult count]];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if ([segue.destinationViewController isKindOfClass:[AFPhotosCollectionViewController class]]) {
//        
//        AFPhotosCollectionViewController *photosCollectionViewController = segue.destinationViewController;
//        AFAlbumTableViewCell *cell = sender;
    
//        photosCollectionViewController.title = cell.nameLable.text;
//        photosCollectionViewController.assetsFetchResults = self.userAlbums;
//    }
}

@end
