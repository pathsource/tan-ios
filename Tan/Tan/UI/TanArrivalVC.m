//
//  TanArrivalVC.m
//  Tan
//
//  Created by Vincent Zhang on 10/24/15.
//  Copyright © 2015 Vincent Zhang. All rights reserved.
//

#import "TanArrivalVC.h"
#import "TanDefinition.h"

@interface TanArrivalVC()
{
    
    __weak IBOutlet UIButton *giveupButton;
    __weak IBOutlet UIButton *arrivalButton;
}
@end

@implementation TanArrivalVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrivalButton.backgroundColor = [UIColor colorFromRGB:0x50af37];
    
    giveupButton.backgroundColor =[UIColor colorFromRGB:0xb6b6b6];
}

- (IBAction)arrivalButtonAction:(id)sender {
}

- (IBAction)giveUpButtonAction:(id)sender {
}

@end
