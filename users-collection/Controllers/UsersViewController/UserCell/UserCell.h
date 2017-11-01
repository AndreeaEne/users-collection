#import <UIKit/UIKit.h>

@interface UserCell : UICollectionViewCell

@property (strong, nonatomic) UserCell *item;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
