//
//  AFAlbumTableViewCell.m
//  PhotosApp
//
//  Created by Александр on 29.03.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFAlbumTableViewCell.h"

@implementation AFAlbumTableViewCell

- (void)setThumbnailImage:(UIImage *)thumbnailImage {
    _thumbnailImage = thumbnailImage;
    self.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
    self.thumbnailImageView.image = thumbnailImage;
}

@end
