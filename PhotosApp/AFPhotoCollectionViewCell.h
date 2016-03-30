//
//  AFPhotoCollectionViewCell.h
//  PhotosApp
//
//  Created by Александр on 30.03.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, copy) NSString *representedAssetIdentifier;

@end
