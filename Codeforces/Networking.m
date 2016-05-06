//
//  Networking.m
//  Codeforces contests
//
//  Created by Insaf on 04.05.16.
//  Copyright © 2016 Insaf. All rights reserved.
//

#import "Networking.h"
#import "AFNetworking.h"
#import "DataManager.h"


static NSString * const BaseURLString = @"http://codeforces.com/api/";


@implementation Networking

+ (void)getContestList {
    
    NSString *string = [NSString stringWithFormat:@"%@contest.list?gym=false",BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    DataManager *dataManager = [[DataManager alloc]init];
    
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDictionary = [(NSDictionary *)responseObject objectForKey:@"result"];
        NSLog(@"%@", responseDictionary);
        
        for (NSDictionary *dic in responseDictionary) {
            Contest *contest = [dataManager getContestFromDictionary:dic fromNetworking:YES];
            [dataManager saveNewContest:contest];
        }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
}





@end
