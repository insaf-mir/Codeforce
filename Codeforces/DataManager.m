//
//  DataManager.m
//  Codeforces
//
//  Created by Insaf on 06.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>

@implementation DataManager

- (instancetype)init {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.managedObjectContext = [self managedObjectContext];
    
    return self;
}

- (NSManagedObjectContext *)managedObjectContext{
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = nil;
    
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)saveNewContest:(Contest *)contest{
    
    if (![self isExistContest:contest]) {
        NSManagedObjectContext *context = _managedObjectContext;
        NSManagedObject *newContest = [NSEntityDescription insertNewObjectForEntityForName:@"Contests" inManagedObjectContext:context];
        
        [newContest setValue:contest.identifier forKey:@"identifier"];
        [newContest setValue:contest.name forKey:@"name"];
        [newContest setValue:contest.duration forKey:@"duration"];
        [newContest setValue:contest.phase forKey:@"phase"];
        [newContest setValue:contest.date forKey:@"date"];
        
        NSError *error = nil;
        if (![[self managedObjectContext] save:&error]) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
        
    }
}

- (BOOL)isExistContest:(Contest *)contest {
    BOOL flag = NO;
    
    NSMutableArray *array = [self getContestsArray];
    
    if (array.count == 0) {
        return NO;
    }
    else {
        for (NSManagedObject *cont in array) {
            if ([[cont valueForKey:@"identifier"] integerValue] == [contest.identifier integerValue]) {
                return YES;
            }
        }
    }
    
    return flag;
}

- (NSMutableArray *)getContestsArray {
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Contests"];
    NSMutableArray *array = [[_managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    
    return array;
}

- (void)deleteAllData{
    NSManagedObjectContext *context = _managedObjectContext;
    
    NSFetchRequest *allContests = [[NSFetchRequest alloc] init];
    [allContests setEntity:[NSEntityDescription entityForName:@"Contests" inManagedObjectContext:context]];
    [allContests setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *contestsArr = [context executeFetchRequest:allContests error:&error];
    for (NSManagedObject *contest in contestsArr) {
        [context deleteObject:contest];
    }
    NSError *saveError = nil;
    [context save:&saveError];
    
}

- (Contest *)getContestFromDictionary:(NSDictionary *)dic fromNetworking:(BOOL)flag{
    Contest *contest = [Contest new];
    
    contest.identifier = flag ? [dic valueForKey:@"id"] : [dic valueForKey:@"identifier"];
    contest.name = [dic valueForKey:@"name"];
    contest.date = flag ? [NSDate dateWithTimeIntervalSince1970:[[dic valueForKey:@"startTimeSeconds"] intValue]]:[dic valueForKey:@"date"];
    contest.phase = flag ? @([[dic valueForKey:@"phase"] isEqualToString:@"FINISHED"]? YES : NO):[dic valueForKey:@"phase"];
    contest.duration = flag?[dic valueForKey:@"durationSeconds"]:[dic valueForKey:@"duration"];
    contest.userMark = flag ? @"User Marks" : [dic valueForKey:@"userMark"];
    
    return contest;
}

- (void)updateContest:(Contest *)contest {
    NSMutableArray *array = [self getContestsArray];
    NSManagedObject *object = nil;
    
    for (NSManagedObject *cont in array) {
        if ([[cont valueForKey:@"identifier"] integerValue] == [contest.identifier integerValue]) {
            object = cont;
            break;
        }
    }
    
    [object setValue:contest.userMark forKey:@"userMark"];
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }

}


@end
