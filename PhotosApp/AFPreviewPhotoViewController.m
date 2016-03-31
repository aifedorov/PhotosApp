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
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    
    CGSize targetSize = CGSizeMake(CGRectGetWidth(mainScreen.bounds), CGRectGetHeight(mainScreen.bounds));
    
    [[PHImageManager defaultManager] requestImageForAsset:self.asset
                                               targetSize:targetSize
                                               contentMode:PHImageContentModeAspectFit
                                                  options:nil
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                self.photoImage = result;
                                            }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setPhotoImage:(UIImage *)photoImage {
    _photoImage = photoImage;
    self.photoPreviewImageView.image = photoImage;
}

@end


