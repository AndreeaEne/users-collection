// Models
#import "User.h"

// Views
#import "UsersCollectionViewController.h"
#import "UserCell.h"
#import "UserDetailsViewController.h"

// Pods
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UsersCollectionViewController ()

// Dictionary with all users.
@property (strong, nonatomic) __block NSMutableArray *UsersData;

@end

@implementation UsersCollectionViewController {
    User *sentUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

// Reloads the view with the new info.
- (void) loadView {
    [self getDataFromAPI];
    [super loadView];
}

// Get information from API.
- (void) getDataFromAPI {
    // Calling the method on a background thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *const url = @"https://randomuser.me/api/?page=0&results=1000&seed=abc";
        [manager GET:url parameters:nil progress:nil
             success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            _UsersData = [NSMutableArray new];
            for (NSDictionary *item in responseObject[@"results"]) {
                NSError *errorDictorionary;
                User *newUser = [[User alloc] initWithDictionary:item error:&errorDictorionary];
                if(errorDictorionary){
                    NSLog(@"Error dictionary: %@", errorDictorionary);
                }
                else [_UsersData addObject:newUser];
            }
            // Update the UI on the main thread.
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error) {
             NSLog(@"Faliure: %@", error);
             }];
    });
}

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

#pragma mark - Navigation
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    sentUser = _UsersData[indexPath.row];
    [self performSegueWithIdentifier:@"showUserInfo" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserDetailsViewController *destVC = [segue destinationViewController];
    [destVC setUser:sentUser];
}

@end
