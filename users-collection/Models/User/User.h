#import <JSONModel/JSONModel.h>

@interface User : JSONModel

@property(nonatomic) NSString *ID;
@property(nonatomic) NSString<Optional> *ID_value;
@property(nonatomic) NSString *firstname;
@property(nonatomic) NSString *lastname;
@property(nonatomic) NSString *birth;
@property(nonatomic) NSString *nationality;
@property(nonatomic) NSString *username;
@property(nonatomic) NSString *email;
@property(nonatomic) NSString *phone;
@property(nonatomic) NSString *address;
@property(nonatomic) NSString *street;
@property(nonatomic) NSURL *image;

- (NSString *)age;

@end
