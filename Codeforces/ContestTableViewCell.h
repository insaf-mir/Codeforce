//
//  NewsTableViewCell.h
//  Codeforces
//
//  Created by Insaf on 04.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NEWS_TABLE_VIEW_CELL_VERTICAL_DISTANCE 15.f

@interface ContestTableViewCell : UITableViewCell

@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *userMarkLabel;

@end
