//
//  Contests+CoreDataProperties.h
//  
//
//  Created by Insaf on 04.05.16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Contests.h"

NS_ASSUME_NONNULL_BEGIN

@interface Contests (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *phase;
@property (nullable, nonatomic, retain) NSString *season;
@property (nullable, nonatomic, retain) NSString *userMark;

@end

NS_ASSUME_NONNULL_END
