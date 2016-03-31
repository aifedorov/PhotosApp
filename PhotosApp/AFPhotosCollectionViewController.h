//
//  AFPhotosCollectionViewController.h
//  PhotosApp
//
//  Created by Александр on 30.03.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Photos;

@interface AFPhotosCollectionViewController : UICollectionViewController

@property (strong, nonatomic) PHFetchResult *photosAssetsFetchResults;

@end
