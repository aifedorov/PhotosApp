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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
    self.userAlbums = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
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
    
    static NSString * const cellIdentifier = @"albumCell";
    
    AFAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    PHCollection *collection = self.userAlbums[indexPath.row];
    
    PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
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
