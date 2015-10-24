//
//  TanProject.h
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanBaseItem.h"

@interface TanProject : TanBaseItem
@property (strong,nonatomic) NSNumber *ID;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *des;
@property (copy,nonatomic) NSString *sponser;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *background;
@property (copy,nonatomic) NSString *image;
@property (copy,nonatomic) NSString *distance;
@end
