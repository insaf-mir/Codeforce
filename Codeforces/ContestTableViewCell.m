//
//  NewsTableViewCell.h
//  Codeforces
//
//  Created by Insaf on 04.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import "ContestTableViewCell.h"

@implementation ContestTableViewCell {
    
    BOOL wasLayedOutOnce;
    
}

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (!self) {
        return nil;
    }
    [self setBackgroundColor:[UIColor clearColor]];
    _titleLabel = [self createLabel];
    _dateLabel = [self createLabel];
    _userMarkLabel = [self createLabel];
    
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.userMarkLabel];

    wasLayedOutOnce = NO;
    return self;
}

#pragma mark - subviews

- (UILabel *)createLabel {
    UILabel *label =[UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    return label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self reloadLabels];
    
    wasLayedOutOnce = YES;
}

- (void)reloadLabels {
    if (!wasLayedOutOnce) {
        self.titleLabel.frame = (CGRect){CGPointZero, CGSizeMake(self.contentView.frame.size.width - 40.f, 0)};
        self.dateLabel.frame = (CGRect){CGPointZero, CGSizeMake(self.contentView.frame.size.width - 40.f, 0)};
        self.userMarkLabel.frame = (CGRect){CGPointZero, CGSizeMake(self.contentView.frame.size.width - 40.f, 0)};

        [self.titleLabel sizeToFit];
        [self.dateLabel sizeToFit];
        [self.userMarkLabel sizeToFit];
    }
    
    CGFloat x = 20.f;
    CGFloat y = NEWS_TABLE_VIEW_CELL_VERTICAL_DISTANCE;
    
    self.dateLabel.frame = CGRectMake(x, y, self.dateLabel.frame.size.width, self.dateLabel.frame.size.height);
    self.titleLabel.frame = CGRectMake(x, CGRectGetMaxY(self.dateLabel.frame)+y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    self.userMarkLabel.frame = CGRectMake(x, CGRectGetMaxY(self.titleLabel.frame)+y, self.userMarkLabel.frame.size.width, self.userMarkLabel.frame.size.height);
}

@end
