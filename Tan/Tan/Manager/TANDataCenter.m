//
//  TANDataCenter.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TANDataCenter.h"
#import "AFNetworking.h"
#import "TanProject.h"

static NSString * const serverStr = @"http://tan.maimoe.com";
static NSString * const projectsStr = @"/projects.json";
static NSString * const detailStr = @"/projects/";

NSString * const TANDidGetProjectNotification = @"TANDidGetProjectNotification";

static TANDataCenter * dataCenter = nil;

@interface TANDataCenter ()
@end

@implementation TANDataCenter

+ (TANDataCenter *)dataCenter{
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        dataCenter = [[TANDataCenter alloc] init];
    });
    
    return dataCenter;
}

+ (NSString *)projectApi
{
    return [serverStr stringByAppendingString:projectsStr];
}

+ (NSString *)projectDetailApi:(NSNumber *)projectID
{
    return [serverStr stringByAppendingFormat:@"%@/%@",detailStr,projectID];
}

+ (NSString *)projectCheckinApi:(NSNumber *)projectID
{
    return [serverStr stringByAppendingFormat:@"%@/%@/checkin",detailStr,projectID];
}

+ (NSString *)projectValidateApi:(NSNumber *)projectID withAnswer:(NSString*)answer
{
    return [serverStr stringByAppendingFormat:@"%@/%@/validate?answer=%@", detailStr, projectID, answer];
}

- (void)startCheckin:(NSNumber *)projectID withCoordinates:(NSArray*)coordinates
{
    NSDictionary *parameters = @{};
    if (nil != coordinates) {
        parameters = @{@"coordinates": coordinates};
    }
    [[TANDataCenter dataCenter] fetchDataWithType:@"GET" URL:[TANDataCenter projectCheckinApi:projectID] parameters:parameters completion:^(id responseObject) {
        NSArray * jsons = responseObject[@"success"];
        
    }];
}

- (void)startValidateAnswer:(NSNumber *)projectID withAnswer:(NSString*)answer
{
    [[TANDataCenter dataCenter] fetchDataWithType:@"GET" URL:[TANDataCenter projectValidateApi:projectID withAnswer:answer] parameters:nil completion:^(id responseObject) {
        NSArray * jsons = responseObject[@"success"];
        
    }];
}

- (void)startFetchProjects:(NSArray*)coordinates
{
    NSDictionary *parameters = @{};
    if (nil != coordinates) {
        parameters = @{@"coordinates": coordinates};
    }
    [[TANDataCenter dataCenter] fetchDataWithType:@"GET" URL:[TANDataCenter projectApi] parameters:parameters completion:^(id responseObject) {
        NSArray * jsons = responseObject[@"projects"];
        __block NSMutableArray * arr = [@[] mutableCopy];
        [jsons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            TanProject * project = [[TanProject alloc] initWithJosnData:obj];
            [arr addObject:project];
            
            if (idx == jsons.count - 1) {
                self.projects = arr;
                
                NSLog(@"Did get projects!");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:TANDidGetProjectNotification object:nil];
            }
        }];
    }];
}

- (void)fetchDataWithType:(NSString *)type URL:(NSString *)URL parameters:(NSDictionary *)parameters completion:(void (^)(id responseObject))success
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if ([type isEqualToString:@"POST"]) {
        [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            if (success) {
                success(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error);
        }];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            if (success) {
                success(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}


@end
