//
//  ContestsTableViewController.m
//  Codeforces
//
//  Created by Insaf on 06.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import "ContestsTableViewController.h"
#import "ContestTableViewCell.h"
#import "DataManager.h"
#import "ContestViewController.h"

@interface ContestsTableViewController () <NSFetchedResultsControllerDelegate>


@end

@implementation ContestsTableViewController{
    DataManager *dataManager;
}

- (instancetype)init {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    dataManager = [DataManager new];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ContestTableViewCell *cell1 = nil;

    if ([cell isMemberOfClass:[ContestTableViewCell class]]) {
        cell1 = cell;
    }
    
    NSDictionary *dic = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"hh:mm d MMMM y";
    
    Contest *contest = [dataManager getContestFromDictionary:dic fromNetworking:NO];
    cell1.titleLabel.text = contest.name;
    cell1.dateLabel.text = [dateFormatter stringFromDate:contest.date];
    cell1.userMarkLabel.text = contest.userMark;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContestTableViewCell *cell = [[ContestTableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = [_fetchedResultsController objectAtIndexPath:indexPath];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"hh:mm d MMMM y";
    
    Contest *contest = [dataManager getContestFromDictionary:dic fromNetworking:NO];
    cell.titleLabel.text = contest.name;
    cell.dateLabel.text = [dateFormatter stringFromDate:contest.date];
    cell.userMarkLabel.text = contest.userMark;
    
    UIColor *backColor = [contest.phase boolValue]? [UIColor redColor]:[UIColor greenColor];
    
    [cell setBackgroundColor:backColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    CGFloat widthMinus = 40.f;
    
    NSDictionary *dic = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    Contest *contest = [dataManager getContestFromDictionary:dic fromNetworking:NO];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"hh:mm d MMMM y";
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - widthMinus, 0)];
    dateLabel.text = [dateFormatter stringFromDate:contest.date];
    dateLabel.numberOfLines = 0;
    [dateLabel sizeToFit];
    height += dateLabel.frame.size.height + 2 * NEWS_TABLE_VIEW_CELL_VERTICAL_DISTANCE;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - widthMinus, 0)];
    titleLabel.text = contest.name;
    titleLabel.numberOfLines = 0;
    [titleLabel sizeToFit];
    height += titleLabel.frame.size.height + NEWS_TABLE_VIEW_CELL_VERTICAL_DISTANCE;
    
    UILabel *userMarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - widthMinus, 0)];
    userMarkLabel.text = contest.userMark;
    userMarkLabel.numberOfLines = 0;
    [userMarkLabel sizeToFit];
    height += userMarkLabel.frame.size.height + NEWS_TABLE_VIEW_CELL_VERTICAL_DISTANCE;
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [_fetchedResultsController objectAtIndexPath:indexPath];
    Contest *contest = [dataManager getContestFromDictionary:dic fromNetworking:NO];

    ContestViewController *vc = [[ContestViewController alloc]initWithContest:contest];
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - fetched result viewcontroller

- (NSFetchedResultsController *)fetchedResultsController {

    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contests" inManagedObjectContext:dataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:dataManager.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;

}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


@end
