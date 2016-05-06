//
//  ContestViewController.m
//  Codeforces
//
//  Created by Insaf on 06.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import "ContestViewController.h"
#import "DataManager.h"

@interface ContestViewController () <UITextViewDelegate>

@end

static CGFloat const maxLength = 20.f;
static CGFloat const minLength = 10.f;


@implementation ContestViewController{
    Contest *_contest;
    UITextView *userMark;
}

- (instancetype)initWithContest:(Contest *)contest{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _contest = contest;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    
    CGFloat width = self.view.frame.size.width - 2 * minLength;
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(minLength, maxLength + 64, width, 0)];
    nameLabel.text = @"Название соревнования";
    nameLabel.numberOfLines = 0;
    [nameLabel sizeToFit];
    [self.view addSubview:nameLabel];
    
    UILabel *contestName = [[UILabel alloc]initWithFrame:CGRectMake(minLength, CGRectGetMaxY(nameLabel.frame)+minLength, width, 0)];
    contestName.text = _contest.name;
    contestName.numberOfLines = 0;
    [contestName sizeToFit];
    [self.view addSubview:contestName];
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(minLength,CGRectGetMaxY(contestName.frame)+maxLength, width, 0)];
    dateLabel.text = @"Дата соревнования";
    dateLabel.numberOfLines = 0;
    [dateLabel sizeToFit];
    [self.view addSubview:dateLabel];
    
    UILabel *contestDate = [[UILabel alloc]initWithFrame:CGRectMake(minLength, CGRectGetMaxY(dateLabel.frame)+minLength, width, 0)];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"hh:mm d MMMM y";
    contestDate.text = [dateFormatter stringFromDate:_contest.date];
    contestDate.numberOfLines = 0;
    [contestDate sizeToFit];
    [self.view addSubview:contestDate];

    UILabel *durationLabel = [[UILabel alloc]initWithFrame:CGRectMake(minLength, CGRectGetMaxY(contestDate.frame)+maxLength, width, 0)];
    durationLabel.text = @"Длительность соревнования";
    durationLabel.numberOfLines = 0;
    [durationLabel sizeToFit];
    [self.view addSubview:durationLabel];
    
    UILabel *contestDuration = [[UILabel alloc]initWithFrame:CGRectMake(minLength, CGRectGetMaxY(durationLabel.frame)+minLength, width, 0)];
    contestDuration.text = [self timeFormatted:[_contest.duration intValue]];
    contestDuration.numberOfLines = 0;
    [contestDuration sizeToFit];
    [self.view addSubview:contestDuration];
    
    UILabel *userMarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(minLength, CGRectGetMaxY(contestDuration.frame)+maxLength, width, 0)];
    userMarkLabel.text = @"Метки пользователя";
    userMarkLabel.numberOfLines = 0;
    [userMarkLabel sizeToFit];
    [self.view addSubview:userMarkLabel];

    userMark = [[UITextView alloc]initWithFrame:CGRectMake(minLength, CGRectGetMaxY(userMarkLabel.frame)+minLength, width, self.view.frame.size.height - CGRectGetMaxY(userMarkLabel.frame)-maxLength)];
    userMark.layer.borderWidth = 1;
    userMark.layer.borderColor = [UIColor lightGrayColor].CGColor;
    userMark.layer.cornerRadius = 5;
    userMark.text = _contest.userMark;
    userMark.delegate = self;
    [self.view addSubview:userMark];
}

- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d",hours, minutes];
}

#pragma mark - user action

- (void)viewTapped {
    if (userMark.isFirstResponder) {
        [userMark resignFirstResponder];
    }
}

#pragma mark - textview delegate

@end
