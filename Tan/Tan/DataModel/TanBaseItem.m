//
//  TanBaseItem.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanBaseItem.h"

@implementation TanBaseItem
- (instancetype)initWithJosnData:(NSDictionary *)data
{
    if (self = [super init]) {
        [data enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [self setValue:obj forKey:key];
        }];
    }
    return self;
}

@end
