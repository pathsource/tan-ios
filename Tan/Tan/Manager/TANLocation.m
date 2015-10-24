//
//  TANLocation.m
//  Tan
//
//  Created by ChenNathan on 15/10/24.
//  Copyright © 2015年 Vincent Zhang. All rights reserved.
//

#import "TANLocation.h"

static TANLocation * location = nil;

@interface TANLocation () <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}
@end

@implementation TANLocation

+ (TANLocation *)share{
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        location = [[TANLocation alloc] init];
    });
    
    return location;
}

- (void)startGetLocation {
    locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        [self prepareLocationUpdate];
    } else {
        [self.delegate getLocation:@[]];
    }
}

- (void)prepareLocationUpdate {
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;;
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

- (void) stopLocationUpdate {
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
}

// CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSArray *coordinates = @[@(newLocation.coordinate.latitude), @(newLocation.coordinate.longitude)];
    [self stopLocationUpdate];
    [self.delegate getLocation: coordinates];
}

@end
