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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
