//
//  TANLocation.h
//  Tan
//
//  Created by ChenNathan on 15/10/24.
//  Copyright © 2015年 Vincent Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol TANLocationDelegate <NSObject>
- (void)getLocation:(NSArray*)coordinates;
@end

@interface TANLocation : NSObject
@property (nonatomic, weak) id<TANLocationDelegate> delegate;
+ (TANLocation *)share;
- (void)startGetLocation;
@end
