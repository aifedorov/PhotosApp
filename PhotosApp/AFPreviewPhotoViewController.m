//
//  AFPreviewPhotoViewController.m
//  PhotosApp
//
//  Created by Александр on 31.03.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFPreviewPhotoViewController.h"

@interface AFPreviewPhotoViewController ()

@end

@implementation AFPreviewPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize targetSize = CGSizeMake(CGRectGetWidth(self.photoPreviewImageView.bounds) * scale, CGRectGetHeight(self.photoPreviewImageView.bounds) * scale);
    
    [[PHImageManager defaultManager] requestImageForAsset:self.asset
                                               targetSize:targetSize
                                               contentMode:PHImageContentModeAspectFit
                                                  options:nil
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                self.photoPreviewImageView.image = result;
                                            }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


