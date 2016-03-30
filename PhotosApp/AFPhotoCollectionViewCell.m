//
//  AFPhotoCollectionViewCell.m
//  PhotosApp
//
//  Created by Александр on 30.03.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFPhotoCollectionViewCell.h"

@interface AFPhotoCollectionViewCell ()
    
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AFPhotoCollectionViewCell

- (void)setThumbnailImage:(UIImage *)thumbnailImage {
    _thumbnailImage = thumbnailImage;
    self.imageView.image = thumbnailImage;
}

@end
