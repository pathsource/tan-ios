//
//  TANDataCenter.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TANDataCenter.h"
#import "AFNetworking.h"

static TANDataCenter * dataCenter = nil;

@implementation TANDataCenter

+ (TANDataCenter *)dataCenter{
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        dataCenter = [[TANDataCenter alloc] init];
    });
    
    return dataCenter;
}

+ (void)fetchDataWithType:(NSString *)type URL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if ([type isEqualToString:@"POST"]) {
        [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error);
        }];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

@end
