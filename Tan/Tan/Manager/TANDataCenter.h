//
//  TANDataCenter.h
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,TANType) {
    TANTypeWalk = 0,
    TANTypeCycling,
    TANTypeVehicle
};

@protocol TANDataCenterDelegate <NSObject>
@optional
- (void)startResult:(BOOL)success;
- (void)checkinResult:(BOOL)success withContent:(NSString*)content andHint:(NSString*)hint;
- (void)validateResult:(BOOL)success;
@end

extern NSString * const TANDidGetProjectNotification;

@class TanProject;
@interface TANDataCenter : NSObject

@property (nonatomic, weak) id<TANDataCenterDelegate> delegate;
@property (strong,nonatomic) NSArray * projects;
@property (strong,nonatomic) TanProject *tanProject;
@property (assign,nonatomic) TANType type;

+ (TANDataCenter *)dataCenter;

- (void)startFetchProjects:(NSArray*)coordinates type:(NSString *)typeName;
- (void)startProject:(NSNumber *)projectID;
- (void)startCheckin:(NSNumber *)projectID withCoordinates:(NSArray*)coordinates;
- (void)startValidateAnswer:(NSNumber *)projectID withAnswer:(NSString*)answer;

+ (NSString *)projectDetailApi:(NSNumber *)projectID;
+ (NSString *)projectCongratApi:(NSNumber *)projectID;

+ (UIImage *)selectedImage:(NSString *)str;
+ (UIImage *)unSelectedImage:(NSString *)str;
@end
