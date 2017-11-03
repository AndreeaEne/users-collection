#import "User.h"

@implementation User

+ (JSONKeyMapper *) keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"ID": @"id.name",
                                                                  @"ID_value": @"id.value",
                                                                  @"firstname": @"name.first",
                                                                  @"lastname": @"name.last",
                                                                  @"birth": @"dob",
                                                                  @"nationality": @"nat",
                                                                  @"username": @"login.username",
                                                                  @"email": @"email",
                                                                  @"phone": @"phone",
                                                                  @"address": @"location.city",
                                                                  @"street": @"location.street",
                                                                  @"image": @"picture.medium"
                                                                  }];
}

// Calculates age from date.
- (NSString *) age {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    NSDate *myDate = [dateFormatter dateFromString: _birth];
    
    return [NSString stringWithFormat:@"%ld years", [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:myDate toDate:[NSDate date] options:0] year]];
}
@end
