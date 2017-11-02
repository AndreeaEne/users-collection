#import "UserDetailsViewController.h"

@interface UserDetailsViewController () {
    User* myUser;
}

@end

@implementation UserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUserInfo];
    
    _portraitImage.layer.cornerRadius = _portraitImage.frame.size.width / 2;
    _portraitImage.clipsToBounds = YES;
}

- (void)setUser:(User *)user {
    myUser = user;
}

- (void)setUserInfo{
    _nameLabel.text = [[NSString stringWithFormat:@"%@ %@",myUser.firstname, myUser.lastname] capitalizedString];
    _ageAndLocationLabel.text = [NSString stringWithFormat:@"%@ from %@",myUser.age, myUser.nationality];
    NSData * data = [NSData dataWithContentsOfURL:myUser.image];
    _portraitImage.image = [UIImage imageWithData:data];
    _usernameLabel.text = myUser.username;
    _emailLabel.text = myUser.email;
    _phoneLabel.text = myUser.phone;
    _addressLabel.text = [[NSString stringWithFormat:@"%@, %@", myUser.address, myUser.street] capitalizedString];
    
    if(myUser.ID_value != NULL || ![myUser.ID isEqualToString:@""])
        _idLabel.text = [NSString stringWithFormat:@"ID: %@ %@", myUser.ID, myUser.ID_value];
}


@end
