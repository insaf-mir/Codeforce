//
//  ContestsTableViewController.h
//  Codeforces
//
//  Created by Insaf on 06.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface ContestsTableViewController : UITableViewController

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
