//
//  TanProjectCardView.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanProjectCardView.h"
#import "PSFormatter.h"

@interface TanProjectCardView()
{
    
    ButtonHandler _handler;
    
    __weak IBOutlet UIImageView *bottomShapeImageView;
    __weak IBOutlet UIImageView *projectImageView;
    __weak IBOutlet UILabel *desLabel;
    
}

@end

@implementation TanProjectCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
    
    desLabel.font = [PSFormatter fontMedium];
}

- (void)setup {
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    // Corner Radius
    self.layer.cornerRadius = 10.0;
}

- (void)selectedCardHandler:(ButtonHandler)handler
{
    _handler = handler;
}

- (IBAction)cardSelectedAction:(id)sender {
    if (_handler) {
        _handler(sender);
    }
}

@end
