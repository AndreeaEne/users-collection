#import "UsersCollectionViewController.h"
#import "User.h"
#import "UserCell.h"
#import "UserDetailsViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UsersCollectionViewController ()

@property (strong, nonatomic) __block NSMutableArray *UsersData; // dictionary with all users

@end

@implementation UsersCollectionViewController {
    User *sentUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

// Reloads the view with the new info
- (void) loadView {
    [self getDataFromAPI];
    [super loadView];
}

// Get information
- (void) getDataFromAPI {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://randomuser.me/api/?page=0&results=100&seed=abc" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        _UsersData = [NSMutableArray new];
        User *newUser = [[User alloc] init];
        
        
        for (NSDictionary* item in responseObject[@"results"]) {
            NSError *errorDictorionary;
            newUser = [[User alloc] initWithDictionary:item error:&errorDictorionary];
            if(errorDictorionary){
                NSLog(@"Error dictionary: %@", errorDictorionary);
            }
            [_UsersData addObject:newUser];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _UsersData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UINib *cellNib = [UINib nibWithNibName:@"UserCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cell"];
    
    UserCell *cell = (UserCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    User *oneUser = _UsersData[indexPath.row];
    cell.nameLabel.text = [[NSString stringWithFormat:@"%@ %@",oneUser.firstname, oneUser.lastname] capitalizedString];
    cell.locationLabel.text = [NSString stringWithFormat:@"%@ from %@",oneUser.age, oneUser.nationality];
    [cell.imageView sd_setImageWithURL:oneUser.image placeholderImage:[UIImage imageNamed:@"circle.png"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    sentUser = _UsersData[indexPath.row];
    [self performSegueWithIdentifier:@"showUserInfo" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserDetailsViewController *destVC = [segue destinationViewController];
    [destVC setUser:sentUser];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
