//
//  Contest.h
//  Codeforces
//
//  Created by Insaf on 04.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contest : NSObject

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *phase;
@property (nullable, nonatomic, retain) NSString *season;
@property (nullable, nonatomic, retain) NSString *userMark;

@end
