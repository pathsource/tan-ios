//
//  TANDataCenter.h
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TANDataCenter : NSObject
+ (TANDataCenter *)dataCenter;
+ (void)fetchDataWithType:(NSString *)type URL:(NSString *)URL parameters:(NSDictionary *)parameters;
@end
