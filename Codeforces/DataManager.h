//
//  DataManager.h
//  Codeforces
//
//  Created by Insaf on 06.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Contest.h"

@interface DataManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *contestsArray;

- (void)saveNewContest:(Contest *)contest;
- (NSMutableArray *)getContestsArray;
- (Contest *)getContestFromDictionary:(NSDictionary *)dic fromNetworking:(BOOL)flag;


@end
