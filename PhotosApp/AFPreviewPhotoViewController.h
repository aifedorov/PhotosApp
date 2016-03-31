//
//  AFPreviewPhotoViewController.h
//  PhotosApp
//
//  Created by Александр on 31.03.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Photos;

@interface AFPreviewPhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoPreviewImageView;
@property (nonatomic, strong) PHAsset *asset;

@end
