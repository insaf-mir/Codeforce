//
//  ViewController.m
//  Codeforces
//
//  Created by Insaf on 04.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import "ViewController.h"
#import "Networking.h"
#import "ContestsTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Networking getContestList];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    [button setTitle:@"Contests list" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(self.view.frame.size.width / 2.f, self.view.frame.size.height / 2.f);
    [self.view addSubview:button];

    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    
}

- (void)buttonTapped {
    NSLog(@"button tapped");
    ContestsTableViewController *vc = [[ContestsTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
