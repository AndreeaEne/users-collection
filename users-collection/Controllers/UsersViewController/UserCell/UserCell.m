#import "UserCell.h"

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setImagesRadius];
}

- (void) setImagesRadius {
    //small radius for the background image
    _backgroundImageView.layer.cornerRadius = 15;
    _backgroundImageView.layer.masksToBounds = YES;
    
    //circled user image
    _imageView.layer.cornerRadius = _imageView.frame.size.width / 2;
    _imageView.clipsToBounds = YES;
}

@end
