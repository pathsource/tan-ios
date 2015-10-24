//
//  TANDataCenter.h
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const TANDidGetProjectNotification;

@interface TANDataCenter : NSObject

@property (strong,nonatomic) NSArray * projects;
+ (TANDataCenter *)dataCenter;
- (void)fetchProjects;

+ (NSString *)projectDetailApi:(NSNumber *)projectID;
@end
