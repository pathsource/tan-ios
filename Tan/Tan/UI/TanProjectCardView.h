//
//  TanProjectCardView.h
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonHandler)(id sender);

@interface TanProjectCardView : UIView
- (void)selectedCardHandler:(ButtonHandler)handler;
@end
