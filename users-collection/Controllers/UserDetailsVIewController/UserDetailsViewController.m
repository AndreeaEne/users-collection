#import "UserDetailsViewController.h"
#import <MessageUI/MessageUI.h>

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
    [_emailButton setTitle: myUser.email forState: UIControlStateNormal];
    _phoneLabel.text = myUser.phone;
    [_addressButton setTitle:[[NSString stringWithFormat:@"%@, %@", myUser.address, myUser.street] capitalizedString] forState:UIControlStateNormal];
    
    // Some IDs and ID values are nil.
    if(myUser.ID_value != NULL || ![myUser.ID isEqualToString:@""])
        _idLabel.text = [NSString stringWithFormat:@"ID: %@ %@", myUser.ID, myUser.ID_value];
    self.navigationItem.title = _nameLabel.text;
}

#pragma mark - Buttons
// Sends e-mail to user's address.
- (IBAction)showEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController* composeVC = [[MFMailComposeViewController alloc] init];
        composeVC.mailComposeDelegate = self;
        
        // Configure the fields of the interface.
        [composeVC setToRecipients:@[_emailButton.titleLabel.text]];
        
        // Present the view controller modally.
        [self presentViewController:composeVC animated:YES completion:nil];
    }
    else {
        NSLog(@"This device cannot send email");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // Dismiss the mail compose view controller.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showMaps:(id)sender {
    NSString *addressToLinkTo = @"";// Empty container for the value.
    NSString *mapsPath = @"http://maps.apple.com/?q="; // Google Maps URL.
    
    // Fill the container with the address.
    addressToLinkTo = [[NSString stringWithFormat:@"%@%@", mapsPath, _addressButton.titleLabel.text] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // Open Maps App.
    NSURL *URL = [NSURL URLWithString:addressToLinkTo];
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:URL options:@{} completionHandler:nil];
}
@end
