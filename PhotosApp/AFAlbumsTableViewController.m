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
static NSString * const cellIdentifierDefault = @"defaultCell";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        [self checkAuthorizationStatus:status];
    }];
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

- (PHFetchResult *) fetchPhotosAtIndexPath:(PHFetchResult *)fetchResult indexPath:(NSIndexPath *)indexPath {
    
    PHAssetCollection *assetCollection = (PHAssetCollection *)fetchResult[indexPath.row];
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
   
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
    
    return assetsFetchResult;
}


- (void) checkAuthorizationStatus:(PHAuthorizationStatus) status {
    
    switch (status) {
        case PHAuthorizationStatusAuthorized: {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                self.userAlbums = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
            });
            break;
        }
            
        case PHAuthorizationStatusDenied:
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"You are denied access to the Photo library" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"ОК"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {}];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:^{}];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - <UITableViewDateSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.userAlbums count] != 0 ? [self.userAlbums count] : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.userAlbums count] == 0) {
        UITableViewCell *defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierDefault];
        defaultCell.textLabel.textAlignment = NSTextAlignmentCenter;
        defaultCell.textLabel.text = @"List albums is empty";
        
        return defaultCell;
    }
    
    AFAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[AFAlbumTableViewCell alloc] init];
    }
    
    cell.nameLable.text = @"";
    cell.countPhotos.text = @"0";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        PHFetchResult *assetsFetchResult = [self fetchPhotosAtIndexPath:self.userAlbums indexPath:indexPath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            AFAlbumTableViewCell *updateCell = (AFAlbumTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            PHAsset *asset = [assetsFetchResult lastObject];
            CGFloat scale = [UIScreen mainScreen].scale;
            CGSize assetThumbnailSize = CGSizeMake(CGRectGetWidth(updateCell.thumbnailImageView.bounds) * scale, CGRectGetHeight(cell.thumbnailImageView.bounds) * scale);
            
            [[PHImageManager defaultManager] requestImageForAsset:asset
                                                       targetSize:assetThumbnailSize
                                                      contentMode:PHImageContentModeDefault
                                                          options:nil
                                                    resultHandler:^(UIImage *result, NSDictionary *info) {
                                                        updateCell.thumbnailImage = result;
                                                    }];
            
            PHAssetCollection *assetCollection = (PHAssetCollection *)self.userAlbums[indexPath.row];
            
            updateCell.nameLable.text = assetCollection.localizedTitle;
            updateCell.countPhotos.text = [NSString stringWithFormat:@"%ld", (unsigned long)[assetsFetchResult count]];
        });
    });
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[AFPhotosCollectionViewController class]]) {
        
        AFPhotosCollectionViewController *photosCollectionViewController = segue.destinationViewController;
        AFAlbumTableViewCell *cell = sender;
    
        photosCollectionViewController.title = cell.nameLable.text;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            photosCollectionViewController.photosAssetsFetchResults = [self fetchPhotosAtIndexPath:self.userAlbums indexPath:indexPath];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [photosCollectionViewController.collectionView reloadData];
            });
            
        });
    }
}

@end
