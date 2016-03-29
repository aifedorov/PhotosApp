//
//  AFAlbumTableViewCell.h
//  PhotosApp
//
//  Created by Александр on 29.03.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFAlbumTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *countPhotos;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end
