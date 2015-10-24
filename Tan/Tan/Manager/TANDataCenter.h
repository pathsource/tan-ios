//
//  TANDataCenter.h
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TANDataCenterDelegate <NSObject>
- (void)checkinResult:(BOOL)success withContent:(NSString*)content andHint:(NSString*)hint;
@end

extern NSString * const TANDidGetProjectNotification;

@interface TANDataCenter : NSObject

@property (nonatomic, weak) id<TANDataCenterDelegate> delegate;
@property (strong,nonatomic) NSArray * projects;
+ (TANDataCenter *)dataCenter;
- (void)startFetchProjects:(NSArray*)coordinates;
- (void)startCheckin:(NSNumber *)projectID withCoordinates:(NSArray*)coordinates;
- (void)startValidateAnswer;

+ (NSString *)projectDetailApi:(NSNumber *)projectID;
@end
