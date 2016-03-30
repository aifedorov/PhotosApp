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

@property (strong,nonatomic) NSArray *fetchResults;

@end

@implementation AFAlbumsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
    self.fetchResults = @[allPhotos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fetchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const cellIdentifier = @"albumCell";
    
    AFAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.nameLable.text = @"My album";
    cell.countPhotos.text = [NSString stringWithFormat:@"%ld", [[self.fetchResults objectAtIndex:indexPath.row] count]];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[AFPhotosCollectionViewController class]]) {
        
        AFPhotosCollectionViewController *photosCollectionViewController = segue.destinationViewController;
        AFAlbumTableViewCell *cell = sender;
        
        photosCollectionViewController.title = cell.nameLable.text;
        photosCollectionViewController.assetsFetchResults = [self.fetchResults objectAtIndex:0];
    }
}

@end
